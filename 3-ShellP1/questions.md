1. In this assignment I suggested you use `fgets()` to get user input in the main while loop. Why is `fgets()` a good choice for this application?

    > **Answer**:  fgets allows the user to limit the length of the input read and in turn, decreasing the chance for a buffer overflow attack which scanf inherently has.

2. You needed to use `malloc()` to allocte memory for `cmd_buff` in `dsh_cli.c`. Can you explain why you needed to do that, instead of allocating a fixed-size array?

    > **Answer**:  We needed to allocate memory for cmd_buff in dsh_cli.c instead of allocating a fixed-size array because user input is usually different each time in length and in content, so it is best to have it dynamic rather than a static fixed-size array.


3. In `dshlib.c`, the function `build_cmd_list(`)` must trim leading and trailing spaces from each command before storing it. Why is this necessary? If we didn't trim spaces, what kind of issues might arise when executing commands in our shell?

    > **Answer**:  We must trim leading and trailing spaces from each command before storing it. This is necessary because command are usually case and content sensitive, meaning a space could invalidate the command. If you have a space before "cd", the command wouldn't work.

4. For this question you need to do some research on STDIN, STDOUT, and STDERR in Linux. We've learned this week that shells are "robust brokers of input and output". Google _"linux shell stdin stdout stderr explained"_ to get started.

- One topic you should have found information on is "redirection". Please provide at least 3 redirection examples that we should implement in our custom shell, and explain what challenges we might have implementing them.

    > **Answer**:  1) Taking the text from a file.txt and using that as input for something. "<" 2) Taking the output of something and appending it into a file.txt ">>" 3)Overwriting a file.txt with the output of something. ">" Some challenges we might have doing that would be having access to the files in the directory. Since we are working with a shell that is our own, we don't have the files on the original shell where we can redirect easily.

- You should have also learned about "pipes". Redirection and piping both involve controlling input and output in the shell, but they serve different purposes. Explain the key differences between redirection and piping.

    > **Answer**:  The differences between redirection and piping is that redirection is only redirecting something from stdin to stdout or into a file or out of a file while piping is a more specialized form of redirection where you are able to chain commands along with the input or output of a file.

- STDERR is often used for error messages, while STDOUT is for regular output. Why is it important to keep these separate in a shell?

    > **Answer**:  It is important to keep STDERR and STDOUT separate in a shell because since they both show as output, it is important to be able to differentiate them from each other especially to see if this is just output from a program or an error that occurred from a program. Also going back to redirection and pipes, you most likely wouldn't want an error message in your output or as input to another program.

- How should our custom shell handle errors from commands that fail? Consider cases where a command outputs both STDOUT and STDERR. Should we provide a way to merge them, and if so, how?

    > **Answer**:  Our custom shell should handle errors from commands that fail using some sort of message with stderr to show that this command failed. Considering a command that outputs both stdout and stderr I think we should not provide a way to merge them since again, we made the important distinction between stdout and stderr and how knowing that they are different changes the course of action. We should keep them separate to differentiate between something that is an error and something that is not.
