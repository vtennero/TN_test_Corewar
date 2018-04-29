#!/bin/bash

ASM_dir=ASM_tests
VM_dir=VM_tests

ERROR_OUTPUT="ERROR"
USAGE_OUTPUT="Usage:"

source resources/asm_tests.sh
source resources/vm_tests.sh
source resources/leaks_tests.sh
source resources/assets_interface.sh
source resources/outer_tests.sh
source resources/valid_tests.sh

run_animation
print_start_title

#MODIFY THE FOLLOWING VARIABLES TO MATCH YOUR OUTPUT (FOR GREP)
ERROR_OUTPUT="ERROR"
USAGE_OUTPUT="Usage:"

#COMMENT THE FOLLOWING LINE TO SKIP *ALL* ASM TESTS
# run_asm_tests

#COMMENT THE FOLLOWING LINE TO SKIP *ALL* VM TESTS
run_vm_tests

#COMMENT THE FOLLOWING LINE TO SKIP *ALL* LEAKS TESTS
# run_leaks_tests

printf "$COLOR\0[ALL DONE]\n$END"