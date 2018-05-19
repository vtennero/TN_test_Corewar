#!/bin/bash

#COLORS
COLOR='\x1b[38;5;220m'
END='\x1b[0m'

run_clean_up()
{
	local CLEAN="rm -rf 2>/dev/null"
  
	print_title "Cleaning..."

	#ASM
	# $CLEAN asm
	$CLEAN $ASM_dir/asm
	$CLEAN $ASM_dir/*.txt
	
	$CLEAN $ASM_dir/all_champs/*.cor $ASM_dir/invalid_champs/*.cor $ASM_dir/valid_champs/*.cor
	$CLEAN $ASM_dir/your_cor $ASM_dir/zaz_cor $ASM_dir/your_invalid_cor

	#VM
	# $CLEAN corewar
	$CLEAN $VM_dir/corewar
	$CLEAN $VM_dir/*.txt
	
	$CLEAN $VM_dir/inner/code_size_differs/tests_logs $VM_dir/inner/code_size_differs/valgrind_logs
	$CLEAN $VM_dir/inner/invalid_header/tests_logs $VM_dir/inner/invalid_header/valgrind_logs
	$CLEAN $VM_dir/inner/too_small/tests_logs $VM_dir/inner/too_small/valgrind_logs
	$CLEAN $VM_dir/inner/too_large/tests_logs $VM_dir/inner/too_large/valgrind_logs

	$CLEAN $VM_dir/outer/tests_logs $VM_dir/outer/valgrind_logs

	$CLEAN $VM_dir/valid_champions/natapol $VM_dir/valid_champions/you $VM_dir/valid_champions/diff $VM_dir/valid_champions/valgrind_logs

	$CLEAN $VM_dir/battle/exec $VM_dir/battle/you $VM_dir/battle/diff $VM_dir/battle/valgrind_logs
	
	$CLEAN $VM_dir/num_and_dump/exec $VM_dir/num_and_dump/you $VM_dir/num_and_dump/diff $VM_dir/num_and_dump/valgrind_logs
	
	#LEAKS
	$CLEAN $ASM_dir/asm.dSYM asm.dSYM $VM_dir/corewar.dSYM
	$CLEAN $ASM_dir/all_champs/valgrind_logs $ASM_dir/invalid_champs/valgrind_logs

	#MISC
	$CLEAN corewar.dSYM

	printf "$COLOR\0[CLEANING DONE]\n$END"
}