1. Can you think of why we use `fork/execvp` instead of just calling `execvp` directly? What value do you think the `fork` provides?

    > **Answer**:  We use fork/execvp instead of just calling execvp directly, because with execvp, it would transform the current process into the executable which would then stop whatever else the process is doing and replcae it with whatver the command was. Fork is used to create another process to do execvp so you don't lose whatever was in your other process.

2. What happens if the fork() system call fails? How does your implementation handle this scenario?

    > **Answer**:  If the fork() system call fails it returns -1 and errno is set to indicate there was an error, then it should print, forked failed and continue on with the next iteration of the loop.

3. How does execvp() find the command to execute? What system environment variable plays a role in this process?

    > **Answer**:  execvp() finds the command to execute by looking thru the /usr/bin files and then executing it with the arguments in the command. The PATH env var plays a role in this process.

4. What is the purpose of calling wait() in the parent process after forking? What would happen if we didn’t call it?

    > **Answer**:  The purpose of calling wait in the parent process after forking is to wait for the child process to complete or finish executing its bit. If we didn't call wait, the parent process would keep running and not wait for the child, which could create some problems.

5. In the referenced demo code we used WEXITSTATUS(). What information does this provide, and why is it important?

    > **Answer**:  WEXITSTATUS provides the exit code that the child returns. This is important in the case that your child returns an exit code that isn't expected and you can handle it promptly.

6. Describe how your implementation of build_cmd_buff() handles quoted arguments. Why is this necessary?

    > **Answer**:  This is necessary for things like echo where quotes do matter in order to include things like spaces. If you didn't handle quoted arguments, it would split it by the space inside of the quotes, leaving it not work as expected.

7. What changes did you make to your parsing logic compared to the previous assignment? Were there any unexpected challenges in refactoring your old code?

    > **Answer**:  I changed it by ignoring the pipe parsing, and then changing the parts to add the arguments and commands, some unexpected challenges in refactoring my old code was that I had to change most of the code to fit the new command struct and parsing related to that.

8. For this quesiton, you need to do some research on Linux signals. You can use [this google search](https://www.google.com/search?q=Linux+signals+overview+site%3Aman7.org+OR+site%3Alinux.die.net+OR+site%3Atldp.org&oq=Linux+signals+overview+site%3Aman7.org+OR+site%3Alinux.die.net+OR+site%3Atldp.org&gs_lcrp=EgZjaHJvbWUyBggAEEUYOdIBBzc2MGowajeoAgCwAgA&sourceid=chrome&ie=UTF-8) to get started.

- What is the purpose of signals in a Linux system, and how do they differ from other forms of interprocess communication (IPC)?

    > **Answer**:  The purpose of signals in a linux system to allow the user to send different signals in order to trigger things like events such as terminating / killing a program. They are different from other forms of interprocess communication because a process doesn't need to wait or check for them unlike pipes or other ipcs. the process is interrupted when a signal comes.

- Find and describe three commonly used signals (e.g., SIGKILL, SIGTERM, SIGINT). What are their typical use cases?

    > **Answer**:  SIGKILL -> Killing a process without asking for permission. Process doesn't get to choose whether to listen or not. SIGTERM -> Kills a process, but allows for post-process cleanup, such as closing files, freeing mem, etc. SIGINT -> Stops a program, when the interrupt signal is sent. Allows program to handle the signal rather than close abruptly. Use Cases: SIGKILL -> When lets say a program is stuck, you want to kill it since you can't do anything else to it. SIGTERM -> When you press X on something, it is an example, it allows for cleanup, etc before closing. SIGINT -> Ctrl+C, to stop a program running in something like a terminal


- What happens when a process receives SIGSTOP? Can it be caught or ignored like SIGINT? Why or why not?

    > **Answer**:  When a process receives SIGSTOP, it suspends a process (pauses), instead of terminating. It cannot be caught or ignored like SIGINT because it is a "non-maskable signal", because of kernel forced suspension.
