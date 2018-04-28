#!/bin/bash

COLOR='\x1b[38;5;220m'
END='\x1b[0m'
ASM_dir=ASM_tests
VM_dir=VM_tests
ERROR_OUTPUT="Erreur"

source resources/asm_tests.sh
source resources/vm_tests.sh
source resources/leaks_tests.sh

sh resources/animation.sh

clear
echo "$COLOR\0TN_TEST // COREWAR\n$END"
sleep 1

#COMMENT THE FOLLOWING LINE TO SILENCE *ALL* ASM TESTS
run_asm_tests

#COMMENT THE FOLLOWING LINE TO SILENCE *ALL* VM TESTS
run_vm_tests

#COMMENT THE FOLLOWING LINE TO SILENCE *ALL* LEAKS TESTS
run_leaks_tests

echo "$COLOR\0[ALL DONE]$END"