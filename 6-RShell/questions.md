1. How does the remote client determine when a command's output is fully received from the server, and what techniques can be used to handle partial reads or ensure complete message transmission?

The remote client determines when a command's output is fully received from the user with the null terminator. To handle partial reads, or to ensure complete message transmission we want to include the length of the buffer + 1, so that it includes the null terminator so the server knows when to stop reading.

2. This week's lecture on TCP explains that it is a reliable stream protocol rather than a message-oriented one. Since TCP does not preserve message boundaries,i
how should a networked shell protocol define and detect the beginning and end of a command sent over a TCP connection? What challenges arise if this is not handled correctly?

To find the end of a stream, again we want to use the null terminator to signify that that is the end of one command. The challenges that might arise if this is not handled correctly is that the server might interpret a valid command as an invalid command due to mismatch in the command start and stop.

3. Describe the general differences between stateful and stateless protocols.

stateless protocols do not worry about the status or "state" of another program, it is independent and all the data that is needed is given in the current interaction rather than data from previous interactions

4. Our lecture this week stated that UDP is "unreliable". If that is the case, why would we ever use it?

UDP is unreliable, but it is usable in certain scenarios such as when stream transfer lag is acceptable or where efficiency is valued over reliability.

5. What interface/abstraction is provided by the operating system to enable applications to use network communications?

the sockets api is the interface or the abstraction that is provided by the op system to enable applications to use network communications. that api provides functions to communicate to different sockets such as send, receive,listen, etc.
