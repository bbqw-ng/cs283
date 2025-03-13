#!/usr/bin/env bats

#
#
#
#
# Setting up the server here so tests can work as intended.
#
#
#
setup() {
  #Starts the server in the background
  ./dsh -s &
  #keeps the pid of the server to kill later after testing
  DSH_PID=$!
}

#cleaning up after tests
teardown() {
  kill $DSH_PID
}


# File: student_tests.sh
# 
# Create your unit tests suit in this file

@test "ls | grep \".c\" works on client" {
    run ./dsh -c<<EOF             
ls | grep ".c"
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>dragon.cdsh_cli.cdshlib.crsh_cli.crsh_server.crsh>cmdloopreturned0"


# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "Stripped Output: ${stripped_output}"
echo "Expected Output: ${expected_output}"

# Check exact match
[ "$stripped_output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]

}

@test "pwd works" {
    run ./dsh -c<<EOF             
pwd
cd ..
pwd
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>/home/bbqwang/cs283/6-RShellrsh>rsh>/home/bbqwang/cs283rsh>cmdloopreturned0"


# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "Stripped Output: ${stripped_output}"
echo "Expected Output: ${expected_output}"

# Check exact match
[ "$stripped_output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]

}

@test "exit works as intended" {
    run ./dsh -c<<EOF             
exit
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socket client mode:  addr:127.0.0.1:1234
rsh> cmd loop returned 0"


# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "Stripped Output: ${output}"
echo "Expected Output: ${expected_output}"

# Check exact match
[ "$output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]
}


@test "exit works as intendeda" {
    run ./dsh <<EOF             
exit
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
#stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="localmodedsh4>"


# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "Stripped Output: ${output}"
echo "Expected Output: ${expected_output}"

# Check exact match
[ "$output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]

}
