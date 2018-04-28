#!/bin/bash

OUTER=$VM_dir/outer/tests_logs
INNER=$VM_dir/inner/tests_logs

DIFF_T=code_size_differs
HEAD_T=invalid_header
LARGE_T=too_large
SMALL_T=too_small

DIFF=$VM_dir/inner/$DIFF_T
HEAD=$VM_dir/inner/$HEAD_T
LARGE=$VM_dir/inner/$LARGE_T
SMALL=$VM_dir/inner/$SMALL_T

vm_compile_zaz()
{
	printf "$COLOR\0Compiling Zaz...This will take some time...\n$END"

    rm 2> /dev/null vm_log_zaz.txt

    for file in $VM_dir/valid_champions/*.cor;
        do
			echo $file >> vm_log_zaz.txt
	        ./$VM_dir/corzaz $file >> vm_log_zaz.txt 2>&1 
	        # ./$VM_dir/corzaz $file
			sleep 0.5
			pkill corzaz
			pkill corzaz
			pkill corzaz
			echo "\n" >> vm_log_zaz.txt
        done
}

outer_parsing_tests()
{
	local i=1
	local c=1
	local failed=0

	clear
	printf "$COLOR\0TN_TEST // COREWAR\n$END"
	printf "$COLOR\0VM TESTS\n$END"
	printf "$COLOR\0OUTER PARSING TESTS\n\n$END"

	rm -rf 2> /dev/null $OUTER
	mkdir -p $OUTER

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
	local TEST[$((c++))]="$VM_dir/$OUTER" 
	
	#No argument
	local TEST[$((c++))]="" 
	

	while [ $i -le $c ]
	do
		printf "$COLOR\0Error on TEST $i 🔥\n$END" >> $OUTER/TEST[$i].txt 2>&1
		printf "./$VM_dir/corewar ${TEST[$i]}\n" >> $OUTER/TEST[$i].txt 2>&1
		./$VM_dir/corewar ${TEST[$i]} >> $OUTER/TEST[$i].txt 2>&1
		pkill corewar
		# if grep -r "Usage:" $OUTER/TEST[$i].txt > /dev/null;
		if grep -r "ERROR" $OUTER/TEST[$i].txt > /dev/null;
			then
				printf "$COLOR\0.$END"
				rm $OUTER/TEST[$i].txt
			else
				printf "🔥 "
				let "failed++"
				# $((failed++))
		fi
		let "i++"
	done
	printf "\n\n"

	cat $OUTER/* 2>/dev/null

	printf "$COLOR\n$(expr $c - $failed)/$c tests passed\n$END"
	printf "$COLOR\0[OUTER PARSING TESTS DONE]\n$END"
    read -p "Press enter to continue..."
}

inner_parsing_tests()
{
	local i=1

	clear
	printf "$COLOR\0TN_TEST // COREWAR\n$END"
	printf "$COLOR\0VM TESTS\n$END"
	printf "$COLOR\0INNER PARSING TESTS\n$END"
	printf "$COLOR\0[$2]\n\n$END"

	rm -rf 2> /dev/null $1/tests_logs
	mkdir -p $1/tests_logs

	for file in $1/*.cor;
        do
			printf "$COLOR\0Error on TEST[$i] 🔥\n$END" >> $1/tests_logs/TEST[$i].txt 2>&1
			printf "./$VM_dir/corewar $file\n" >> $1/tests_logs/TEST[$i].txt 2>&1
	        ./$VM_dir/corewar $file >> $1/tests_logs/TEST[$i].txt 2>&1
# 			# pkill corewar
			# if grep -r "Usage:" $1/tests_logs/TEST[$i].txt > /dev/null;
			if grep -r "ERROR" $1/tests_logs/TEST[$i].txt > /dev/null;
			then
				printf "$COLOR\0.$END"
				rm $1/tests_logs/TEST[$i].txt
			else
				printf "🔥 "
		fi
		let "i++"
        done
	printf "\n\n"
	cat $1/tests_logs/* 2>/dev/null

    read -p "Press enter to continue..."
}

run_vm_tests()
{
    clear
	printf "$COLOR\0TN_TEST // COREWAR\n$END"
	printf "$COLOR\0VM TESTS\n\n$END"

	if [ $(ls | grep corewar) ]
	then
		cp corewar $VM_dir/
	    # vm_compile_zaz
		outer_parsing_tests
		inner_parsing_tests $DIFF $DIFF_T
		inner_parsing_tests $HEAD $HEAD_T
		inner_parsing_tests $LARGE $LARGE_T
		inner_parsing_tests $SMALL $SMALL_T
	else
		printf "$COLOR\0Move your asm to the current folder, then restart (File must be named corewar).\n$END"
	fi
}