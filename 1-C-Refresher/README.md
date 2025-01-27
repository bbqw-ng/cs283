#### This is Homework 1, C programming pointer review assignment.

There is a warning because I had commented out a part of the reverse function to cover the test case in the test.sh file.
If you wish to see reverse with placeholder, please uncomment. It will also get rid of the warning too.

Also there was a test case that was supposed to remove extra spaces, and it wasn't clear in the instructions if we should check 
the user inputted string should be less than 50 chars (including duplicate spaces) or the buffer (in the end) should be less than 50 chars (duplicate spaces removed)

- Case 1: (checks user string for length violation)
user string -> "this string      is longer than 50 characters     "
user string > 50; exit(1)

- Case 2: (checks buffer for length violation after processing)
user string -> "this string      is longer than 50    characters     "
buffer conversion -> this string is longer than 50 characters
buffer <= 50; is good.
