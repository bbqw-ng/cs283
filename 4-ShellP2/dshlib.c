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
 * Implement your exec_local_cmd_loop function by building a loop that prompts the 
 * user for input.  Use the SH_PROMPT constant from dshlib.h and then
 * use fgets to accept user input.
 * 
 *      while(1){
 *        printf("%s", SH_PROMPT);
 *        if (fgets(cmd_buff, ARG_MAX, stdin) == NULL){
 *           printf("\n");
 *           break;
 *        }
 *        //remove the trailing \n from cmd_buff
 *        cmd_buff[strcspn(cmd_buff,"\n")] = '\0';
 * 
 *        //IMPLEMENT THE REST OF THE REQUIREMENTS
 *      }
 * 
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
 * 
 *  Standard Library Functions You Might Want To Consider Using (assignment 1+)
 *      malloc(), free(), strlen(), fgets(), strcspn(), printf()
 * 
 *  Standard Library Functions You Might Want To Consider Using (assignment 2+)
 *      fork(), execvp(), exit(), chdir()
 */
int exec_local_cmd_loop()
{
  char *cmdBuff = malloc(SH_CMD_MAX);
  int rc = 0;
  cmd_buff_t cmd;
  cmd._cmd_buffer = malloc(SH_CMD_MAX);

  while(1) {
    printf("%s", SH_PROMPT);

    if (fgets(cmdBuff, SH_CMD_MAX, stdin) == NULL) {
      printf("\n");
      break;
    }

    //removing trailing space
    cmdBuff[strcspn(cmdBuff, "\n")] = '\0';

    int buildReturn = build_cmd_buff(cmdBuff, &cmd);
    if (buildReturn != OK) {
      printf("Something went wrong with parsing the command.\n");
      continue;
    }

    if (strcmp(cmd.argv[0], "exit") == 0) {
      exit(0);
    }

    if (strcmp(cmd.argv[0], "dragon") == 0) {
      printDragon();
      continue;
    }

    if (strcmp(cmd.argv[0],"echo") == 0) {
      pid_t pid = fork();
      if (pid == 0) {
        execvp("echo", cmd.argv);
      } else if (pid > 0) {
        int childState;
        waitpid(pid, &childState, 0);
      }
      continue;
    }

    if (strcmp(cmd.argv[0], "cd") == 0) {
      if (cmd.argv[1] != NULL) {
        if (chdir(cmd.argv[1]) != 0) 
          printf("Directory Not Found\n");
      } else {
        //does nothing at the moment - shell p.2
        //change to home dir if no other args
        //chdir(getenv("HOME"));
      }
      continue;
    }

    if (strcmp(cmd.argv[0], "pwd") == 0) {
      //allocate space for the getcwd command
      char cwd[DIRECTORY_LENGTH];
      if (getcwd(cwd, sizeof(cwd)) != NULL) 
        printf("%s", cwd);
      continue;
    }

    if (strcmp(cmd.argv[0], "ls") == 0) {
      pid_t pid = fork();
        //inside child
      if (pid == 0) {
        execvp("ls", cmd.argv);
        //parents waiting for child
      } else if (pid > 0) {
        int childState;
        waitpid(pid, &childState, 0);
      }
      continue;
    }

    if (strcmp(cmd.argv[0], "which") == 0) {
      pid_t pid = fork();
      // pid = 0:" inside of child
      if (pid == 0) {
        execvp("which", cmd.argv);
        // parent waiting for chilkd
      } else if (pid > 0) {
        int childState;
        waitpid(pid, &childState, 0);
      } 
      continue;
    }

    if (strcmp(cmd.argv[0], "uname") == 0) {
      pid_t pid = fork();
      if (pid == 0) {
        execvp("uname", cmd.argv);
      } else if (pid > 0) {
        int childState;
        waitpid(pid, &childState, 0);
      }
      continue;
    }
  }
  free(cmdBuff);
  return OK;
}

int build_cmd_buff(char *cmdLine, cmd_buff_t *cmd) {
  //Empty Command
  if (cmdLine == NULL || strlen(cmdLine) < 1)  {
    printf(CMD_WARN_NO_CMD);
    return WARN_NO_CMDS;
  }

  //copy the original buff into the command
  strcpy(cmd->_cmd_buffer, cmdLine);

  //Check cmdLine for length violation or violation of # of commands
  for (int i = 0, j = 0; *(cmdLine+i) != '\0'; i++) {
    if (*(cmdLine+i) == PIPE_CHAR) 
      ++j;
    if (j > 7) 
      return ERR_TOO_MANY_COMMANDS;
    if (i > ARG_MAX) 
      return ERR_CMD_OR_ARGS_TOO_BIG;
  }

  const char *delim = PIPE_STRING;
  char *cmdCpy = strdup(cmdLine);
  char *save;

  char *token = strtok_r(cmdCpy, delim, &save);
  //Keep track of the number of total commands (different than args of a cmd)
  int cmdNum = 0;

  //Splits it by the pipe \ //
  while (token != NULL) {
    char *trimmed = strdup(rightTrim(leftTrim(token)));
    int trimmedOriginalLength = strlen(trimmed);

    bool quoteMode = false;
    char *start = trimmed;
    int argIndex = 0;

    //parsing the command between pipes ( command 1 | command 2 | command 3 ) each per iteration of while loop
    for (int i = 0; i <= trimmedOriginalLength; i++) { 
      if ( (*(trimmed+i) == ' ' && !quoteMode && i != trimmedOriginalLength)) {
        *(trimmed+i) = '\0';
        //makes sure we don't add any extra spaces
        if (start != trimmed+i)
          cmd[cmdNum].argv[argIndex++] = strdup(start);
        start = trimmed+i+1;

      } else if (*(trimmed+i) == '\"' && !quoteMode) {
        quoteMode = true;
        start = trimmed+i+1;

      } else if (*(trimmed+i) == '\"' && quoteMode) {
        quoteMode = false;
        *(trimmed+i) = '\0';
        cmd[cmdNum].argv[argIndex++] = strdup(start);
        start = trimmed+i+1;
      } 
    }

    //Adds the last argument into the argv for the command
    if (*start != '\0') {
      cmd[cmdNum].argv[argIndex++] = strdup(start);
    }

    //null terminating the current string
    cmd[cmdNum].argv[argIndex] = NULL;
    cmd->argc = ++cmdNum;

    free(trimmed);
    trimmed = NULL;

    token = strtok_r(NULL, delim, &save);
  }

  //printing cmd for sanity check
  //printCmdBuff(cmd);

  free(cmdCpy);
  cmdCpy = NULL;
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
    for (int j = 0; cmdBuff[i].argv[j] != NULL; j++) 
      printf("%s\n", cmdBuff[i].argv[j]);
}






