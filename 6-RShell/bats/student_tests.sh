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
  if [[ -n "$DSH_PID" ]] && kill -0 "$DSH_PID" 2>/dev/null; then
    kill "$DSH_PID"
  fi
}


# File: student_tests.sh
# 
# Create your unit tests suit in this file

@test "ls | grep \".c\" works on client" {
    run ./dsh -c<<EOF             
ls | grep ".c"
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

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
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

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
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>cmdloopreturned0"


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


@test "cat can work" {
    run ./dsh -c<<EOF             
cat file.txt
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>asentenceanothersentencewhattheheckhithisisasentencersh>cmdloopreturned0"


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

@test "counting lines work" {
    run ./dsh -c<<EOF             
ls | grep ".c" | wc -l
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>5rsh>cmdloopreturned0"


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

@test "echo works with countingn" {
    run ./dsh -c<<EOF             
echo frog fire | wc -l
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>1rsh>cmdloopreturned0"


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

@test "echo can work with grep to grab the line with the grep thing" {
    run ./dsh -c<<EOF             
echo "a juicy juicy gumdrop fallen from the juicy juicy gumdrop tree" | grep "fallen"
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>ajuicyjuicygumdropfallenfromthejuicyjuicygumdroptreersh>cmdloopreturned0"


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

@test "stop-server works as intended" {
    run ./dsh -c<<EOF             
stop-server
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>cmdloopreturned0"


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

@test "can create files with touch" {
    run ./dsh -c<<EOF             
touch thisisafilethatatestcreated | ls | grep "thisisafilethatatestcreated"
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>thisisafilethatatestcreatedrsh>cmdloopreturned0"


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

@test "can delete files" {
    run ./dsh -c<<EOF             
rm thisisafilethatatestcreated | ls | grep "thisisafilethatatestcreated"
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>rsh>cmdloopreturned0"


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

@test "can create a directory" {
    run ./dsh -c<<EOF             
mkdir acreateddirectory | ls | grep "acreateddirectory"
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>acreateddirectoryrsh>cmdloopreturned0"


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

@test "can delete a directory" {
    run ./dsh -c<<EOF             
rm -r acreateddirectory | ls | grep "acreateddirectory"
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>rsh>cmdloopreturned0"


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

@test "can sort and take unique items" {
    run ./dsh -c<<EOF             
echo -e "apple\nbanana\napple\ncherry\nbanana" | sort | uniq
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>applebananacherryrsh>cmdloopreturned0"


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

@test "reverse sort files" {
    run ./dsh -c<<EOF             
ls | grep ".c" | sort -r
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>rsh_server.crsh_cli.cdshlib.cdsh_cli.cdragon.crsh>cmdloopreturned0"


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

@test "can handle incorrect commands in pipe" {
    run ./dsh -c<<EOF             
echo "hello there" | unknowasnduasdiouauhsudn | wc -l
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>2rsh>cmdloopreturned0"


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


@test "can count characters" {
    run ./dsh -c<<EOF             
echo "superradicalpotatomushroomolivesoupwithsomeoliveoilbread" | wc -c
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>57rsh>cmdloopreturned0"


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


@test "reverse me string" {
    run ./dsh -c<<EOF             
echo "this string is reversed" | rev
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>desreversignirtssihtrsh>cmdloopreturned0"


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

@test "can reverse files in my directory?" {
    run ./dsh -c<<EOF             
ls | grep ".c" | rev
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>c.nogardc.ilc_hsdc.bilhsdc.ilc_hsrc.revres_hsrrsh>cmdloopreturned0"


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

@test "get the first three things in dir" {
    run ./dsh -c<<EOF             
ls | head -n 3 | sort -r
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
removeUnprintableCharacters=$(echo "$output" | tr -d '[:cntrl:]')
stripped_output=$(echo "$removeUnprintableCharacters" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="socketclientmode:addr:127.0.0.1:1234rsh>dshdragon.cbatsrsh>cmdloopreturned0"


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

