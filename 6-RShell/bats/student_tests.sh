#!/usr/bin/env bats

# File: student_tests.sh
# 
# Create your unit tests suit in this file

@test "ls | grep \".c\"" {
    run ./dsh <<EOF             
ls | grep ".c"
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="dragon.cdsh_cli.cdshlib.cdsh3>dsh3>cmdloopreturned0"

# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "${stripped_output} -> ${expected_output}"

# Check exact match
[ "$stripped_output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]

}

@test "counting lines from grep works" {
    run ./dsh <<EOF             
ls | grep ".c" | wc -l
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="3dsh3>dsh3>cmdloopreturned0"

# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "${stripped_output} -> ${expected_output}"

# Check exact match
[ "$stripped_output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]

}


@test "counting lines with expression with echo and wc" {
    run ./dsh <<EOF             
echo frog fire | wc -l
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="1dsh3>dsh3>cmdloopreturned0"

# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "${stripped_output} -> ${expected_output}"

# Check exact match
[ "$stripped_output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]

}

@test "grabbing the remnants of a world long lost" {
    run ./dsh <<EOF             
echo a melancholic memory of what once was | grep "memory"
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="amelancholicmemoryofwhatoncewasdsh3>dsh3>cmdloopreturned0"

# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "${stripped_output} -> ${expected_output}"

# Check exact match
[ "$stripped_output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]

}

@test "sorting fruit echoes" {
    run ./dsh <<EOF             
echo -e "cherry\nberry\nsushi" | grep "y" | sort -r
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="cherryberrydsh3>dsh3>cmdloopreturned0"

# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "${stripped_output} -> ${expected_output}"

# Check exact match
[ "$stripped_output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]

}

@test "cat counts file!" {
    run ./dsh <<EOF             
cat file.txt | wc -l
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="5dsh3>dsh3>cmdloopreturned0"

# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "${stripped_output} -> ${expected_output}"

# Check exact match
[ "$stripped_output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]

}

@test "unique fruits!" {
    run ./dsh <<EOF             
echo -e "apple\nbanana\napple\ncherry\nbanana" | sort | uniq
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="applebananacherrydsh3>dsh3>cmdloopreturned0"

# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "${stripped_output} -> ${expected_output}"

# Check exact match
[ "$stripped_output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]

}

@test "sort all .c files by reverse order" {
    run ./dsh <<EOF             
ls | grep ".c" | sort -r
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="dshlib.cdsh_cli.cdragon.cdsh3>dsh3>cmdloopreturned0"

# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "${stripped_output} -> ${expected_output}"

# Check exact match
[ "$stripped_output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]

}

@test "the void will give naught back" {
    run ./dsh <<EOF             
cat /dev/null | wc -l
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="0dsh3>dsh3>cmdloopreturned0"

# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "${stripped_output} -> ${expected_output}"

# Check exact match
[ "$stripped_output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]

}

@test "grab first 3 things in the directory then sort it" {
    run ./dsh <<EOF             
ls | head -n 3 | sort -r
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="dshdragon.cbatsdsh3>dsh3>cmdloopreturned0"

# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "${stripped_output} -> ${expected_output}"

# Check exact match
[ "$stripped_output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]

}

@test "invalid command in pipe" {
    run ./dsh <<EOF             
echo "hello there" | this is not a correct command! | wc -l
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="brianshell:Nosuchfileordirectory0dsh3>dsh3>cmdloopreturned0"

# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "${stripped_output} -> ${expected_output}"

# Check exact match
[ "$stripped_output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]

}

@test "counting 57 characters" {
    run ./dsh <<EOF             
echo "superradicalpotatomushroomolivesoupwithsomeoliveoilbread" | wc -c
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="57dsh3>dsh3>cmdloopreturned0"

# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "${stripped_output} -> ${expected_output}"

# Check exact match
[ "$stripped_output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]

}

@test "the infamous YES command destroyer of systems" {
    run ./dsh <<EOF             
yes "yes" | head -n 15
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="yesyesyesyesyesyesyesyesyesyesyesyesyesyesyesdsh3>dsh3>cmdloopreturned0"

# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "${stripped_output} -> ${expected_output}"

# Check exact match
[ "$stripped_output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]

}

@test "super unique things" {
    run ./dsh <<EOF             
echo -e "cat\ndog\ncat\ndog\nroach\nbarboach\nniki\nzefanya\nindigo\nindigo\nroach" | sort -u 
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="barboachcatdogindigonikiroachzefanyadsh3>dsh3>cmdloopreturned0"

# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "${stripped_output} -> ${expected_output}"

# Check exact match
[ "$stripped_output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]

}

@test "reverse my STRING?" {
    run ./dsh <<EOF             
echo "this string is reversed" | rev
EOF

 # Strip all whitespace (spaces, tabs, newlines) from the output
stripped_output=$(echo "$output" | tr -d '[:space:]')

# Expected output with all whitespace removed for easier matching
expected_output="desreversignirtssihtdsh3>dsh3>cmdloopreturned0"

# These echo commands will help with debugging and will only print
#if the test fails
echo "Captured stdout:" 
echo "Output: $output"
echo "Exit Status: $status"
echo "${stripped_output} -> ${expected_output}"

# Check exact match
[ "$stripped_output" = "$expected_output" ]

# Assertions
[ "$status" -eq 0 ]

}


