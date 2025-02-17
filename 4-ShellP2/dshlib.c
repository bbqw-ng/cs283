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
  char *cmd_buff = malloc(SH_CMD_MAX);
  int rc = 0;
  cmd_buff_t cmd;
  cmd._cmd_buffer = malloc(SH_CMD_MAX);

  while(1) {
    printf("%s", SH_PROMPT);
    if (fgets(cmd_buff, SH_CMD_MAX, stdin) == NULL) {
      printf("\n");
      break;
    }

    //removing trailing space
    cmd_buff[strcspn(cmd_buff, "\n")] = '\0';
    int buildCode = build_cmd_buff(cmd_buff, &cmd);
    if (buildCode == WARN_NO_CMDS) {
      continue;
    } 
  }
    // TODO IMPLEMENT parsing input to cmd_buff_t *cmd_buff

    // TODO IMPLEMENT if built-in command, execute builtin logic for exit, cd (extra credit: dragon)
    // the cd command should chdir to the provided directory; if no directory is provided, do nothing

    // TODO IMPLEMENT if not built-in command, fork/exec as an external command
    // for example, if the user input is "ls -l", you would fork/exec the command "ls" with the arg "-l"
    free(cmd_buff);
    return OK;
}

int build_cmd_buff(char *cmdLine, cmd_buff_t *cmdBuff) {
  //Empty Command
  if (cmdLine == NULL || strlen(cmdLine) < 1)  {
    printf(CMD_WARN_NO_CMD);
    return WARN_NO_CMDS;
  }

  //copy the original buff into the command
  strcpy(cmdBuff->_cmd_buffer, cmdLine);
  printf("%s\n", cmdBuff->_cmd_buffer);  

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
    bool quoteMode = false;
    char *start = trimmed;
    int argIndex = 0;
    //parsing the command
    for (int i = 0; *(trimmed+i) != '\0'; i++) {
      if (*(trimmed+i) == ' ' && !quoteMode) {
        *(trimmed+i) = '\0';
        cmdBuff[cmdNum].argv[argIndex++] = strdup(start);
        start = trimmed+i+1;
      }
      if (*(trimmed+i) == '\"' && !quoteMode) {
        quoteMode = true;
        start = trimmed+i+1;
      } else if (*(trimmed+i) == '\"' && quoteMode) {
        quoteMode = false;
        *(trimmed+i) = '\0';
        cmdBuff[cmdNum].argv[argIndex++] = strdup(start);
        start = trimmed+i+1;
      }
    }
    
    for (int i = 0; i <= cmdNum; i++) {
      for (int j = 0; j <= argIndex; j++) {
        printf("%s\n", cmdBuff[cmdNum].argv[i]);
      }
    }

    cmdBuff->argc = cmdNum;

    token = strtok_r(NULL, delim, &save);

    free(trimmed);
    trimmed = NULL;
  }

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





