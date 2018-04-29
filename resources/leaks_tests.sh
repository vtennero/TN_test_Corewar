#!/bin/bash

DIFF_T=code_size_differs
HEAD_T=invalid_header
LARGE_T=too_large
SMALL_T=too_small
VALID_T=valid_champions

DIFF=$VM_dir/inner/$DIFF_T
HEAD=$VM_dir/inner/$HEAD_T
LARGE=$VM_dir/inner/$LARGE_T
SMALL=$VM_dir/inner/$SMALL_T
VALID=$VM_dir/$VALID_T

VALGRIND_LOGS_DIR="valgrind_logs"
VALGRIND_LOGS_FILENAME="vlg_"

check_outer_valgrind()
{
	local c=1
	local i=1

	rm -rf 2> /dev/null $VM_dir/outer/outer_leaks_log.txt $VM_dir/outer/$VALGRIND_LOGS_DIR
	mkdir -p $VM_dir/outer/$VALGRIND_LOGS_DIR

	#Invalid dump
	local TEST[$((c++))]="-dump" 
	local TEST[$((c++))]="-dump 50"
	local TEST[$((c++))]="-dump dsjfklsj"
	local TEST[$((c++))]="-dump 50 -n"
	local TEST[$((c++))]="-dump 50 5"
	local TEST[$((c++))]="50 5"
	local TEST[$((c++))]="-n -dump"
	
	local TEST[$((c++))]="$VM_dir/valid_champions/Car.cor -dump" 
	local TEST[$((c++))]="$VM_dir/valid_champions/Car.cor -n -dump" 
	local TEST[$((c++))]="$VM_dir/valid_champions/Car.cor -n dump" 
	local TEST[$((c++))]="$VM_dir/valid_champions/Car.cor -n 5" 
	local TEST[$((c++))]="$VM_dir/valid_champions/Car.cor -n sdfsd" 
	local TEST[$((c++))]="-n abc $VM_dir/valid_champions/Car.cor -n sdfsd" 
	local TEST[$((c++))]="-n 1 $VM_dir/valid_champions/Car.cor -n 1 sdfsd" 
	local TEST[$((c++))]="-n 1 -dump $VM_dir/valid_champions/Car.cor -n 1 sdfsd" 
	local TEST[$((c++))]="-n 1 -dump a $VM_dir/valid_champions/Car.cor -n 1 sdfsd" 
	local TEST[$((c++))]="-n -99991 $VM_dir/valid_champions/Car.cor" 
	local TEST[$((c++))]="-n 1 $VM_dir/valid_champions/Car.cor -n 1 $VM_dir/valid_champions/Car.cor" 
	local TEST[$((c++))]="-n 1 $VM_dir/valid_champions/Car.cor -n 1 $VM_dir/valid_champions/Car.cor -n 1 $VM_dir/valid_champions/Car.cor -n 1 $VM_dir/valid_champions/Car.cor" 
	local TEST[$((c++))]="-n 1 $VM_dir/valid_champions/Car.cor -n 1 $VM_dir/valid_champions/Car.cor -n 2 $VM_dir/valid_champions/Car.cor -n 3 $VM_dir/valid_champions/Car.cor" 
	local TEST[$((c++))]="-n 2 $VM_dir/valid_champions/Car.cor -n 1 $VM_dir/valid_champions/Car.cor -n 2 $VM_dir/valid_champions/Car.cor -n 3 $VM_dir/valid_champions/Car.cor"
	local TEST[$((c++))]="$VM_dir/valid_champions/Car.cor -n 3 $VM_dir/valid_champions/Car.cor -n 2 $VM_dir/valid_champions/Car.cor -n 3 $VM_dir/valid_champions/Car.cor"

	#Invalid files
	local TEST[$((c++))]="$VM_dir/outer/file" 
	local TEST[$((c++))]="$VM_dir/outer" 
	
	#No argument
	local TEST[$((c++))]=""

	while [ $i -le $c ]
		do
			local STORAGE_PATH=$VM_dir/outer/$VALGRIND_LOGS_DIR"/"$VALGRIND_LOGS_FILENAME"_$i"
			$HOME/.brew/Cellar/valgrind/3.13.0/bin/valgrind --leak-check=full --log-file="$STORAGE_PATH" ./$VM_dir/corewar ${TEST[$i]} > /dev/null 2>&1
			local definitely_lb=$(cat $STORAGE_PATH | grep "definitely lost: " | cut -d " " -f7)
			local indirectly_lb=$(cat $STORAGE_PATH | grep "indirectly lost: " | cut -d " " -f7)
			if [ "$definitely_lb" != "0" ] || [ "$indirectly_lb" != "0" ]
			then
				printf "TEST[$i]:\t\t\t$definitely_lb bytes definitely lost, $indirectly_lb bytes indirectly lost\n" >> $VM_dir/outer/outer_leaks_log.txt
				printf "💦 "
			else
				printf "$COLOR.$END"
			fi
			let "i++";
		done
		printf "\n\n"

		cat $VM_dir/outer/outer_leaks_log.txt 2>/dev/null
		printf "\n"
	    read -p "Press enter to continue..."
}

check_one_valgrind()
{
	local i=1

	printf "$COLOR\0[$2]\n$END"

	rm -rf 2> /dev/null $1/$VALGRIND_LOGS_DIR $1/$2_leaks_log.txt
	mkdir -p $1/$VALGRIND_LOGS_DIR

	for file in $1/*$4;
		do
			# echo $file
			local STORAGE_PATH=$1/$VALGRIND_LOGS_DIR"/"$VALGRIND_LOGS_FILENAME"_$i"
			$HOME/.brew/Cellar/valgrind/3.13.0/bin/valgrind --leak-check=full --log-file="$STORAGE_PATH" $3 $file > /dev/null 2>&1
			local definitely_lb=$(cat $STORAGE_PATH | grep "definitely lost: " | cut -d " " -f7)
			local indirectly_lb=$(cat $STORAGE_PATH | grep "indirectly lost: " | cut -d " " -f7)
			if [ "$definitely_lb" != "0" ] || [ "$indirectly_lb" != "0" ]
			then
				printf "$file:\t\t\t$definitely_lb bytes definitely lost, $indirectly_lb bytes indirectly lost\n" >> $1/$2_leaks_log.txt
				printf "💦 "
			else
				printf "$COLOR.$END"
			fi
			let "i++";
		done
		printf "\n\n"

	cat $1/$2_leaks_log.txt 2>/dev/null
	printf "\n"
}

valgrind_vm_valid()
{
	clear
	printf "$COLOR\0TN_TEST // COREWAR\n$END"
	printf "$COLOR\0LEAKS TESTS\n$END"
	printf "$COLOR\0VALID CHAMPIONS\n$END"

	check_one_valgrind $VALID $VALID_T ./$VM_dir/corewar .cor

    read -p "Press enter to continue..."
}

valgrind_vm_invalid()
{
	clear
	printf "$COLOR\0TN_TEST // COREWAR\n$END"
	printf "$COLOR\0LEAKS TESTS\n$END"
	printf "$COLOR\0INVALID ARGUMENTS (OUTER)\n$END"

	check_outer_valgrind

	printf "$COLOR\0INVALID CHAMPIONS (INNER)\n$END"
	
	check_one_valgrind $DIFF $DIFF_T ./$VM_dir/corewar .cor
	check_one_valgrind $HEAD $HEAD_T ./$VM_dir/corewar .cor
	check_one_valgrind $LARGE $LARGE_T ./$VM_dir/corewar .cor
	check_one_valgrind $SMALL $SMALL_T ./$VM_dir/corewar .cor
    read -p "Press enter to continue..."
}

valgrind_asm()
{
	clear
	printf "$COLOR\0TN_TEST // COREWAR\n$END"
	printf "$COLOR\0LEAKS TESTS\n$END"
	printf "$COLOR\0ASM\n$END"
	printf "$COLOR\0Warning /!\\ Launching valgrind with fsanitize will make your session crash! Ctrl+C to stop now!\n$END"

	rm -rf 2> /dev/null $ASM_dir/all_champs/*.cor

	check_one_valgrind $ASM_dir/all_champs ALL_CHAMPS ./$ASM_dir/asm .s

	mv $ASM_dir/all_champs/ALL_CHAMPS_leaks_log.txt ../ 2> /dev/null

	rm -rf 2> /dev/null $ASM_dir/all_champs/*.cor
	
    read -p "Press enter to continue..."
}

valgrind_vm()
{
	#COMMENT THE FOLLOWING LINE TO SILENCE VALID CHAMPION VM LEAK CHECKS (CAN TAKE A WHILE...)
	valgrind_vm_valid

	valgrind_vm_invalid
}

run_leaks_tests()
{
	local VERSION=$(ls $HOME/.brew/Cellar | grep valgrind)

	clear
	printf "$COLOR\0TN_TEST // COREWAR\n$END"
	printf "$COLOR\0LEAKS TESTS\n$END"

	if [ $VERSION ]
	then
		#COMMENT THE FOLLOWING LINE TO SILENCE *ALL* ASM LEAK CHECKS
		# valgrind_asm

		#COMMENT THE FOLLOWING LINE TO SILENCE *ALL* VM LEAK CHECKS
		valgrind_vm
	else
		printf "$COLOR\0Valgrind is not installed on this machine.\n
		Installing it now...$END"
		brew update && brew install valgrind && alias valgrind="~/.brew/bin/valgrind"
	fi
	rm -rf 2> /dev/null $ASM_dir/asm.dSYM asm.dSYM
	rm -rf 2> /dev/null $VM_dir/corewar.dSYM
	printf "$COLOR\n[LEAKS DONE]\n$END"

}