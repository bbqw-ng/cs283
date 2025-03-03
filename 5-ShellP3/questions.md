1. Your shell forks multiple child processes when executing piped commands. How does your implementation ensure that alli
child processes complete before the shell continues accepting user input? What would happen if you forgot to call waitpid() on all child processes?

My implementation ensures that all child processes complete before the shell continues accepting user input, but using waitpid() for each one of the processes that were created with fork. If I had forgotten to call waitpid() on all child processes, there would be potential problems with things like behavioral aspects of the program or there could be resource leakage or zombie processes.

2. The dup2() function is used to redirect input and output file descriptors. Explain why it is necessary to close unused pipe ends after calling 
dup2(). What could go wrong if you leave pipes open?

It is necessary to close unused pipe ends after calling dup2() because it helps us avoid things like deadlocks where a process is waiting for input, but never gets it. If you forget to close pipe ends, you might accidently read frmo or write to the wrong file descriptors.

3. Your shell recognizes built-in commands (cd, exit, dragon). Unlike external commands, 
built-in commands do not require execvp(). Why is cd implemented as a built-in rather than an external 
command? What challenges would arise if cd were implemented as an external process?

Cd is implemented as a built-in rather than an external command because it allows for the altering of directories inside of the shell (which is important for other actions that matter based on the current directory). The challenges that would arise from implementing cd as an external command is the fact that it wouldn't change the parent process' working directory, so when the child process completes, the parent process' working directory wouldn't have changed.

4. Currently, your shell supports a fixed number of piped commands (CMD_MAX). How would you modify your implementation to allow an 
arbitrary number of piped commands while still handling memory allocation efficiently? What trade-offs would you need to consider?

To modify my implementation to allow an arbitrary number of piped commands while still handling memory allocation efficiently I think I would change how the memory is allocated. Since here we allocate memory statically, giving a fixed size for memory, a lot of memory is wasted since some commands don't take up that amount, so I would allocate memory dynamically instead to save memory and thereby reducing and making mem allocation more efficient. The trade off with this would be that you would have to implement more code to determine the size to dynamically allocate for each piece of memory, so it would make the runtime longer, but have better memory efficiency.





