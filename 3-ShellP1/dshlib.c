#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

#include "dshlib.h"


/* INPUT : Pointer to command to trim
 * RETURN : Returns pointer to trimmed command
 */
char *leftTrim(char *command);
char *rightTrim(char *command);

/* INPUT: Pointer to the command to split into args
 * RETURN : Returns a pointer to the command that was created on arguments and exe
 */
command_t *commandSplitter(char *command);



/*
 *  build_cmd_list
 *    cmd_line:     the command line from the user
 *    clist *:      pointer to clist structure to be populated
 *
 *  This function builds the command_list_t structure passed by the caller
 *  It does this by first splitting the cmd_line into commands by spltting
 *  the string based on any pipe characters '|'.  It then traverses each
 *  command.  For each command (a substring of cmd_line), it then parses
 *  that command by taking the first token as the executable name, and
 *  then the remaining tokens as the arguments.
 *
 *  NOTE your implementation should be able to handle properly removing
 *  leading and trailing spaces!
 *
 *  errors returned:
 *
 *    OK:                      No Error
 *    ERR_TOO_MANY_COMMANDS:   There is a limit of CMD_MAX (see dshlib.h)
 *                             commands.
 *    ERR_CMD_OR_ARGS_TOO_BIG: One of the commands provided by the user
 *                             was larger than allowed, either the
 *                             executable name, or the arg string.
 *
 *  Standard Library Functions You Might Want To Consider Using
 *      memset(), strcmp(), strcpy(), strtok(), strlen(), strchr()
 */
int build_cmd_list(char *cmd_line, command_list_t *clist) {
  //Checks for # of commands and length of commands / args
  for (int i = 0, j = 0; *(cmd_line+i) != '\0'; i++) {
    if (*(cmd_line+i) == PIPE_CHAR) {
      ++j;
    }
    if (j > 7) {
      return ERR_TOO_MANY_COMMANDS;
    }
    if (i > ARG_MAX) {
      return ERR_CMD_OR_ARGS_TOO_BIG;
    }
  }

  //Now we want to add commands into the command list along with their arguments 
  //We want to strip the spaces (leading and trailing)
  //We will utilize strtok(command, delimiter);

  const char *delim = PIPE_STRING;
  //creates a copy of cmd_list since strtok modifies string
  char *cmdCpy = malloc(ARG_MAX);
  strcpy(cmdCpy, cmd_line);

  char *token = strtok(cmdCpy, delim);
  char *trimmed = rightTrim(leftTrim(token));
    
  //turn it into a command
  command_t *command = commandSplitter(trimmed);
  
  //add command into command list
  int cmdNumber = 0;
  clist->commands[cmdNumber] = *command;
  clist->num = ++cmdNumber;
  
  while (token != NULL) {
    //with strtok, use NULL after first strtok to continue delimiting
    token = strtok(NULL, delim);
    printf("%s", token);
    //Need to check for NULL, or else seg fault since dereferencing null causes seg fault
    if (token != NULL) {
      trimmed = rightTrim(leftTrim(token));
      command = commandSplitter(trimmed);
      clist->commands[cmdNumber] = *command;
      clist->num = ++cmdNumber;
    }
  }
  free(cmdCpy);
  cmdCpy = NULL;
  return OK;
}

char *leftTrim(char *command) {
  while (isspace(*command)) 
    command++;
  return command;
}

char *rightTrim(char *command) {
  //trailing is directly modifying command
  char *trailing = command + strlen(command) - 1;
  //if there is a trailing space, go backward 1 in index.
  while (isspace(*trailing)) {
    --trailing;
  }
  //once there is no more trailing spaces, terminate the string with a null terminator at the index AFTER the current character
  *(trailing + 1) = '\0';
  return command;
}



//error with command splitter splitting by spaces in the thing
command_t *commandSplitter(char *command) {
  command_t *cmd = malloc(ARG_MAX + EXE_MAX);

  //need this for making so it doesnt touich command?
  char *cmdCpy = malloc(ARG_MAX);
  strcpy(cmdCpy, command);

  const char *delim = " ";

  //Parsing exe
  char *token = strtok(cmdCpy, delim);
  printf("%s", token);
  if (token != NULL) 
    strcpy(cmd->exe, token);

  //Parsing arguments
  //command = pos 0 + length of token (ex: 4) + 1 (ignores the space) = the args after exe.
  char *args = command + strlen(token) + 1;
  if (args != NULL) 
    strcpy(cmd->args, args);


  return cmd;
}
