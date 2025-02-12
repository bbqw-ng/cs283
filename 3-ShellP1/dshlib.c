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

  //Establishing a delimiter var for strtok_r
  const char *delim = PIPE_STRING;

  //creates a copy of cmd_list since strtok_r modifies string in place
  char *cmdCpy = strdup(cmd_line);

  //Establish a save pointer for strtok_r since strtok is static
  char *save;
  char *token = strtok_r(cmdCpy, delim, &save);
  
  int cmdNumber = 0;
  while (token != NULL) {
    //Removes leading and trailing whitespace
    char *trimmed = strdup(rightTrim(leftTrim(token)));
    //Splits command into exe and args
    command_t *command = commandSplitter(trimmed);
    //Adds into command list
    clist->commands[cmdNumber] = *command;
    clist->num = ++cmdNumber;
    
    //Need to free this memory since memory was allocated for the duplication
    free(trimmed);
    trimmed = NULL; 
    free(command);
    command = NULL;
    
    //Gets next token
    token = strtok_r(NULL, delim, &save);
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
  command_t *cmd = malloc(sizeof(command_t));

  char *copy = strdup(command);
  const char *delim = " ";

  char *save;

  //Parsing exe
  char *token = strtok_r(copy, delim, &save);
  if (token != NULL) 
    strcpy(cmd->exe, token);

  //Parsing arguments
  //command = pos 0 + length of token (ex: 4) + 1 (ignores the space) = the args after exe.
  char *args = save;
  if (args != NULL) 
    strcpy(cmd->args, args);

  //freeing mem
  free(copy);
  copy = NULL;

  return cmd;
}
