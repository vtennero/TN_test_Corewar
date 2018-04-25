#!/bin/bash

COLOR='\x1b[38;5;220m'
END='\x1b[0m'
ASM_dir=ASM_tests
VM_dir=VM_tests

source resources/asm_tests.sh
source resources/vm_tests.sh

# sh resources/animation.sh

clear
echo "$COLOR\0TN_TEST // COREWAR\n$END"
sleep 1

# run_asm_tests
run_vm_tests

echo "$COLOR\0[ALL DONE]$END"