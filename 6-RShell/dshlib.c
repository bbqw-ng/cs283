#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdbool.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
#include "dshlib.h"

/*
 *   Also, use the constants in the dshlib.h in this code.  
 *      SH_CMD_MAX              maximum buffer size for user input
 *      EXIT_CMD                constant that terminates the dsh program
 *      SH_PROMPT               the shell prompt
 *      OK                      the command was parsed properly
 *      WARN_NO_CMDS            the user command was empty
 *      ERR_TOO_MANY_COMMANDS   too many pipes used
 *      ERR_MEMORY              dynamic memory management failure
 * 
 *   errors returned
 *      OK                     No error
 *      ERR_MEMORY             Dynamic memory management failure
 *      WARN_NO_CMDS           No commands parsed
 *      ERR_TOO_MANY_COMMANDS  too many pipes used
 *   
 *   console messages
 *      CMD_WARN_NO_CMD        print on WARN_NO_CMDS
 *      CMD_ERR_PIPE_LIMIT     print on ERR_TOO_MANY_COMMANDS
 *      CMD_ERR_EXECUTE        print on execution failure of external command
 */
int exec_local_cmd_loop()
{
  char *cmdBuff = malloc(SH_CMD_MAX);
  int rc = 0;
  cmd_buff_t cmd;
  cmd._cmd_buffer = malloc(SH_CMD_MAX);
  command_list_t *cmdList = malloc((CMD_MAX) * sizeof(command_t));

  while(1) {
    printf("%s", SH_PROMPT);

    if (fgets(cmdBuff, SH_CMD_MAX, stdin) == NULL) {
      printf("\n");
      break;
    }

    //removing trailing space
    cmdBuff[strcspn(cmdBuff, "\n")] = '\0';

    int buildReturn = build_cmd_buff(cmdBuff, &cmd, cmdList);
    if (buildReturn != OK) {
      printf("Something went wrong with parsing the command.\n");
      continue;
    }

    if (strcmp(cmdList->commands->argv[0], "exit") == 0) {
      exit(0);
    } else if (strcmp(cmdList->commands->argv[0], "dragon") == 0) {
      printDragon();
      continue;
    } else if (strcmp(cmdList->commands->argv[0], "cd") == 0) {
      if (cmd.argv[1] != NULL) {
        if (chdir(cmd.argv[1]) != 0) 
          printf("Directory Not Found\n");
      } else {
        chdir(getenv("HOME"));
      }
      continue;
    } else if (strcmp(cmdList->commands->argv[0], "pwd") == 0) {
      //allocate space for the getcwd command
      char cwd[DIRECTORY_LENGTH];
      if (getcwd(cwd, sizeof(cwd)) != NULL) 
        printf("%s\n", cwd);
      continue;
    } else {
      execute_pipeline(cmdList);
      continue;
    }
  }
  //free cmdList
  free(cmdBuff);
  return OK;
}

int execute_pipeline(command_list_t *cmdList) {
  int numOfCommands = cmdList->num + 1;
  int pipes[numOfCommands - 1][2];
  pid_t pids[numOfCommands];

  //creating pipes for the # of commands
  for (int i = 0; i < numOfCommands - 1; i++) {
    if (pipe(pipes[i]) == -1) {
      printf("piping operation failed\n");
      return ERR_EXEC_CMD;
    }
  }

  //doble chekc the commands before piping begins to make sure that everything is intended.
  //printCmdList(cmdList);

  //fork processes
  for (int i = 0; i < numOfCommands; i++) {
    pids[i] = fork();

    //if you are the child process run this.
    if (pids[i] == 0) { 
      //not first cmd
      if (i > 0) {
        dup2(pipes[i - 1][0], STDIN_FILENO);
      } 
      //if not last cmd
      if (i < numOfCommands - 1) {
        dup2(pipes[i][1], STDOUT_FILENO);
      }
      for (int j = 0; j < numOfCommands - 1; j++) {
        close(pipes[j][0]);
        close(pipes[j][1]);
      }
      if (execvp(cmdList->commands[i].argv[0], cmdList->commands[i].argv) == -1) {
        perror("brian shell");
        exit(ERR_EXEC_CMD);
      }
    } 
    //if fork fails (aka not the child)
    else if (pids[i] < 0) { 
      printf("fork failed to properly execute\n");
      return ERR_EXEC_CMD;
    }
  }

  //close all the file descriptors to avoid any errors with things like zombie processes, etc etc
  for (int i = 0; i < numOfCommands - 1; i++) {
    close(pipes[i][0]);
    close(pipes[i][1]);
  }

  //wait for all the children to finish execution
  for (int i = 0; i < numOfCommands; i++) {
    waitpid(pids[i], NULL, 0);
  }

  return OK;
}

int build_cmd_buff(char *cmdLine, cmd_buff_t *cmd, command_list_t *cmdList) {
  if (cmdLine == NULL || strlen(cmdLine) < 1) {
    printf(CMD_WARN_NO_CMD);
    return WARN_NO_CMDS;
  }

  strcpy(cmd->_cmd_buffer, cmdLine);

  //checking for any pipe overflows, (invlaid commands)
  int pipeCount = 0;
  for (int i = 0; cmdLine[i] != '\0'; i++) {
    if (cmdLine[i] == PIPE_CHAR)
      pipeCount++;
    if (pipeCount > 7)
      return ERR_TOO_MANY_COMMANDS;
    if (i > ARG_MAX)
      return ERR_CMD_OR_ARGS_TOO_BIG;
  }

  char *delim = PIPE_STRING;
  char *cmdCpy = strdup(cmdLine);
  char *save;
  char *token = strtok_r(cmdCpy, delim, &save);
  
  int cmdNum = 0;

  while (token != NULL) {
    char *trimmed = strdup(rightTrim(leftTrim(token)));
    int trimmedLength = strlen(trimmed);

    bool quoteMode = false;
    char *start = trimmed;
    int argIndex = 0;

    //initializes current singular command with 0 args first
    cmdList->commands[cmdNum].argc = 0;

    for (int i = 0; i <= trimmedLength; i++) { 
      //handle non quotes and spaces
      if ((trimmed[i] == ' ' && !quoteMode) || trimmed[i] == '\0') {
        if (start != &trimmed[i]) {
          trimmed[i] = '\0';
          cmdList->commands[cmdNum].argv[argIndex++] = strdup(start);
          cmdList->commands[cmdNum].argc++;
        }
        start = &trimmed[i + 1];
        //handle quotataions
      } else if (trimmed[i] == '\"') {
        quoteMode = !quoteMode;
        if (!quoteMode)
          trimmed[i] = '\0';
        else
          start = &trimmed[i + 1];
      }
    }

    cmdList->commands[cmdNum].argv[argIndex] = NULL;
    cmdNum++;

    free(trimmed);
    token = strtok_r(NULL, delim, &save);
  }

  cmdList->num = cmdNum - 1;

  free(cmdCpy);
  return OK;
}

char *leftTrim(char *cmd) {
  while (isspace(*cmd))
    cmd++;
  return cmd;
}

char *rightTrim(char *cmd) {
  char *trailing = cmd + strlen(cmd)-1;
  while(isspace(*trailing)) 
    --trailing;
  *(trailing + 1) = '\0';
  return cmd;
}

void printCmdBuff(cmd_buff_t *cmdBuff) {
  for (int i = 0; i < cmdBuff->argc ;i++) 
    for (int j = 0; cmdBuff->argv[j] != NULL; j++) 
      printf("%s\n", cmdBuff->argv[j]);
}

void printCmdList(command_list_t *cmdList) {
  for (int i = 0; i <= cmdList->num; i++) {
    for (int j = 0; j < cmdList->commands[i].argc; j++) {
      printf("%s\n", cmdList->commands[i].argv[j]);
    }
  }
}

