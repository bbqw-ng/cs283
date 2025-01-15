#include <stdio.h>
#include <string.h>
#include <stdlib.h>


#define BUFFER_SZ 50

//prototypes
void usage(char *);
void print_buff(char *, int);
int  setup_buff(char *, char *, int);

//prototypes for functions to handle required functionality
int count_words(char *, int, int);
//add additional prototypes here


int setup_buff(char *buff, char *user_str, int len){
    //TODO: #4:  Implement the setup buff as per the directions
    
    //checks for user_str > BUFFER_SZ
    int userStringLength = 0;
    for (int l = 0; *(user_str+l) != '\0'; l++) {
      userStringLength++;
    }

    printf("%d\n", userStringLength);
    //user provided string's length is too large for our buffer.
    if (userStringLength > len) 
      return -1;
  
    //this should be empty since we hadn't set up the buffer yet.
    printf("%s <- If not blank, something is wrong.\n", buff);
    printf("The User String: %s\n", user_str);

    //keeps track of the current buffer length
    int currBuffLen = 0;

    //We want to first filter out any spaces. We can do this by checking the character after the current one.
    for (int i = 0; *(user_str+i) != '\0'; i++) {
      //if current char is not space or tab, copy over to buffer.
      if (*(user_str+i) != ' ' && *(user_str+i) != '\t') {
        *(buff+currBuffLen) = user_str[i];
        currBuffLen++;
      } else {
        //if it is space or tab, add space to buffer if current realized length of buffer is 0. 
        if (currBuffLen == 0) {
          *(buff+currBuffLen) = ' ';
          currBuffLen++;
        //check previous char of buffer, if it is not space, add a space.
        } else if (buff[currBuffLen-1] != ' ') {
          *(buff+currBuffLen) = ' ';
          currBuffLen++;
        }
      }
    }
    //We can then use memset to set the rest of the items in the buffer to "." using currBuffLen.
    //here we cast a char pointer since we are not dealing with ints.
    memset((char*)(buff+currBuffLen), '.', BUFFER_SZ-currBuffLen);
    //returns the currBuffLen (BEFORE the "." were added in), effectively giving us a false null terminator or length limiter we can use.
    return currBuffLen;
}

void print_buff(char *buff, int len){
    printf("Buffer:  ");
    for (int i=0; i<len; i++){
        putchar(*(buff+i));
    }
    putchar('\n');
}

void usage(char *exename){
    printf("usage: %s [-h|c|r|w|x] \"string\" [other args]\n", exename);

}

int count_words(char *buff, int len, int str_len){
    //YOU MUST IMPLEMENT
    return 0;
}

//ADD OTHER HELPER FUNCTIONS HERE FOR OTHER REQUIRED PROGRAM OPTIONS

int main(int argc, char *argv[]){

    char *buff;             //placehoder for the internal buffer
    char *input_string;     //holds the string provided by the user on cmd line
    char opt;               //used to capture user option from cmd line
    int  rc;                //used for return codes
    int  user_str_len;      //length of user supplied string

    //TODO:  #1. WHY IS THIS SAFE, aka what if arv[1] does not exist?
    //      When argv[1] does not exist, OR when the argument count is less than 2, it provides the user with a template and then terminates the program. 
    //      This is safe because again, it terminates the program if argv[1] doesn't exist.
    if ((argc < 2) || (*argv[1] != '-')){
        usage(argv[0]);
        exit(1);
    }

    opt = (char)*(argv[1]+1);   //get the option flag

    //handle the help flag and then exit normally
    if (opt == 'h'){
        usage(argv[0]);
        exit(0);
    }

    //WE NOW WILL HANDLE THE REQUIRED OPERATIONS

    //TODO:  #2 Document the purpose of the if statement below
    //      The purpose of the if statement below is to check if the arguments provided are less than 3. 
    //      This is because we want the program name, the choice, and the string. 
    //      Without those 3 arguments our program will not work as expected so we have to error handle that if it ever occurred hence the if statement checking for the 3 arguments.
    if (argc < 3){
        usage(argv[0]);
        exit(1);
    }

    input_string = argv[2]; //capture the user input string

    //TODO:  #3 Allocate space for the buffer using malloc and
    //          handle error if malloc fails by exiting with a 
    //          return code of 99
    
    //allocate mem from heap return pointer to buff
    // we can also do sizeof(char) * 50, but a char is always 1 byte so it doesn't matter
    buff = (char*)malloc(BUFFER_SZ);
    //if buff is null, memory allocation failed, terminates prog with code 99.
    if (buff == NULL)
      exit(99);

    user_str_len = setup_buff(buff, input_string, BUFFER_SZ);     //see todos
    if (user_str_len < 0){
        printf("Error setting up buffer, error = %d", user_str_len);
        exit(2);
    }

    switch (opt){
        case 'c':
            rc = count_words(buff, BUFFER_SZ, user_str_len);  //you need to implement
            if (rc < 0){
                printf("Error counting words, rc = %d", rc);
                exit(2);
            }
            printf("Word Count: %d\n", rc);
            break;
        //TODO:  #5 Implement the other cases for 'r' and 'w' by extending
        //       the case statement options
        case 'r':
            //reverses character in place in the sample string.
            break;
        case 'w':
            //prints individual words and their length in the sample string
            break;
        default:
            usage(argv[0]);
            exit(1);
    }

    //TODO:  #6 Dont forget to free your buffer before exiting
    print_buff(buff,BUFFER_SZ);
    free(buff);
    buff = NULL;

    printf("Buffer freed successfully.");
    exit(0);
}

//TODO:  #7  Notice all of the helper functions provided in the 
//          starter take both the buffer as well as the length.  Why
//          do you think providing both the pointer and the length
//          is a good practice, after all we know from main() that 
//          the buff variable will have exactly 50 bytes?
//  
//          Knowing the length of the buffer will not always be the case, and in the case that we don't it is best practice
//          to provide the pointer and the buffer size to avoid any problems with memory and things like segfaults.
//          PLACE YOUR ANSWER HERE
