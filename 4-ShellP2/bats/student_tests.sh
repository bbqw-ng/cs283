#!/usr/bin/env bats

# File: student_tests.sh
# 
# Create your unit tests suit in this file

@test "Example: check ls runs without errors (external command dsh2> runs after)" {
    current=$(pwd)
    run ./dsh <<EOF                
ls
EOF
 
    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching
    

    ##KEEP IN MIND THIS MIGHT BE DIFFERENT FOR YOURS, IT SHOULD JUST BE ALL OF THE FILES IN THE 4-SHELLP2 DIRECTORY THAT SHOW FROM ls
    expected_output="batsdragon.cdshdsh_cli.cdshlib.cdshlib.hmakefilequestions.mddsh2>dsh2>cmdloopreturned0"

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

@test "Check cd actually changes the directory (built-in command)" {
    current=$(pwd)
    run ./dsh <<EOF                
cd bats
pwd
EOF

    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching
    expected_output="dsh2>dsh2>$current/batsdsh2>cmdloopreturned0"

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

@test "lots of ls statements :D" {
    current=$(pwd)

    cd /tmp
    rm -rf robinhood123123123

    mkdir robinhood123123123
    cd robinhood123123123
    touch snow
    mkdir hotpotrocket
    cd hotpotrocket
    touch man
    run "${current}/dsh" <<EOF                
pwd
ls
cd ..
ls
cd ..
pwd
EOF
 
    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching
    

    expected_output="manhotpotrocketsnowdsh2>/tmp/robinhood123123123/hotpotrocketdsh2>dsh2>dsh2>dsh2>dsh2>/tmpdsh2>cmdloopreturned0"

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


@test "cd to a directory that doesnt exist" {
    current=$(pwd)

    cd /tmp
    run "${current}/dsh" <<EOF                
cd doodoo
pwd
EOF
 
    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching
    

    ##KEEP IN MIND THIS MIGHT BE DIFFERENT FOR YOURS, IT SHOULD JUST BE ALL OF THE FILES IN THE 4-SHELLP2 DIRECTORY THAT SHOW FROM ls
    expected_output="dsh2>DirectoryNotFounddsh2>/tmpdsh2>cmdloopreturned0"

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


@test "can cd into a directory with an absolute path" {
    current=$(pwd)

    rm -rf /tmp/rocksolid
    cd /tmp
    mkdir rocksolid
    run "${current}/dsh" <<EOF                
cd rocksolid
pwd
EOF
 
    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching
    

    ##KEEP IN MIND THIS MIGHT BE DIFFERENT FOR YOURS, IT SHOULD JUST BE ALL OF THE FILES IN THE 4-SHELLP2 DIRECTORY THAT SHOW FROM ls
    expected_output="dsh2>dsh2>/tmp/rocksoliddsh2>cmdloopreturned0"

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


@test "which which which idk" {
    current=$(pwd)
    run ./dsh <<EOF                
which "eggplant magic monster"
EOF
 
    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching
    

    ##KEEP IN MIND THIS MIGHT BE DIFFERENT FOR YOURS, IT SHOULD JUST BE ALL OF THE FILES IN THE 4-SHELLP2 DIRECTORY THAT SHOW FROM ls
    expected_output="dsh2>dsh2>cmdloopreturned0"

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


@test "uname" {
    current=$(pwd)
    run ./dsh <<EOF                
uname
EOF
 
    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching
    

    ##KEEP IN MIND THIS MIGHT BE DIFFERENT FOR YOURS, IT SHOULD JUST BE ALL OF THE FILES IN THE 4-SHELLP2 DIRECTORY THAT SHOW FROM ls
    expected_output="Linuxdsh2>dsh2>cmdloopreturned0"

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


@test "echo long statement" {
    current=$(pwd)
    run ./dsh <<EOF                
echo "rad mango man go" man      go go man go "soup and featherss            sss" ";;;"    hedgehod
EOF
 
    # Strip all whitespace (spaces, tabs, newlines) from the output
    stripped_output=$(echo "$output" | tr -d '[:space:]')

    # Expected output with all whitespace removed for easier matching
    

    ##KEEP IN MIND THIS MIGHT BE DIFFERENT FOR YOURS, IT SHOULD JUST BE ALL OF THE FILES IN THE 4-SHELLP2 DIRECTORY THAT SHOW FROM ls
    expected_output="radmangomangomangogomangosoupandfeathersssss;;;hedgehoddsh2>dsh2>cmdloopreturned0"

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

