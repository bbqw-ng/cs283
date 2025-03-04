#!/usr/bin/env bats

# File: student_tests.sh
# 
# Create your unit tests suit in this file

@test "ls | grep \".c\"" {
    run ./dsh <<EOF             
ls | grep ".c"

EOF

    # Assertions
    [ "$status" -eq 0 ]
}
