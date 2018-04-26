#!/bin/bash

OUTER=$VM_dir/outer/tests_logs
INNER=$VM_dir/inner/tests_logs

vm_compile_zaz()
{
	printf "$COLOR\0Compiling Zaz...This will take some time...\n$END"

    rm 2> /dev/null vm_log_zaz.txt

    for file in $VM_dir/zaz_cor/*.cor;
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

    # for file in $VM_dir/s_files/*.cor;
        # do
            # mv $file $VM_dir/zaz_cor/
        # done
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
	
	local TEST[$((c++))]="$VM_dir/zaz_cor/Car.cor -dump" 
	local TEST[$((c++))]="$VM_dir/zaz_cor/Car.cor -n -dump" 
	local TEST[$((c++))]="$VM_dir/zaz_cor/Car.cor -n dump" 
	local TEST[$((c++))]="$VM_dir/zaz_cor/Car.cor -n 5" 
	local TEST[$((c++))]="$VM_dir/zaz_cor/Car.cor -n sdfsd" 
	local TEST[$((c++))]="-n abc $VM_dir/zaz_cor/Car.cor -n sdfsd" 
	local TEST[$((c++))]="-n 1 $VM_dir/zaz_cor/Car.cor -n 1 sdfsd" 
	local TEST[$((c++))]="-n 1 -dump $VM_dir/zaz_cor/Car.cor -n 1 sdfsd" 
	local TEST[$((c++))]="-n 1 -dump a $VM_dir/zaz_cor/Car.cor -n 1 sdfsd" 
	local TEST[$((c++))]="-n -99991 $VM_dir/zaz_cor/Car.cor" 
	local TEST[$((c++))]="-n 1 $VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor" 
	local TEST[$((c++))]="-n 1 $VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor" 
	local TEST[$((c++))]="-n 1 $VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor -n 2 $VM_dir/zaz_cor/Car.cor -n 3 $VM_dir/zaz_cor/Car.cor" 
	local TEST[$((c++))]="-n 2 $VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor -n 2 $VM_dir/zaz_cor/Car.cor -n 3 $VM_dir/zaz_cor/Car.cor"
	local TEST[$((c++))]="$VM_dir/zaz_cor/Car.cor -n 3 $VM_dir/zaz_cor/Car.cor -n 2 $VM_dir/zaz_cor/Car.cor -n 3 $VM_dir/zaz_cor/Car.cor"

	while [ $i -le $c ]
	do
		printf "$COLOR\0Error on TEST $i 🔥\n$END" >> $OUTER/TEST[$i].txt 2>&1
		printf "./$VM_dir/corewar ${TEST[$i]}\n" >> $OUTER/TEST[$i].txt 2>&1
		./$VM_dir/corewar ${TEST[$i]} >> $OUTER/TEST[$i].txt 2>&1
		pkill corewar
		if grep -r "Usage:" $OUTER/TEST[$i].txt > /dev/null;
			then
				rm $OUTER/TEST[$i].txt
			else
			let "failed++"
				# $((failed++))
		fi
		let "i++"
	done
	cat $OUTER/*

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
	printf "$COLOR\0INNER PARSING TESTS\n\n$END"

	# rm -rf $VM_dir/inner/i_pagny/tests_logs
	rm -rf 2> /dev/null $VM_dir/inner/i_pagny/tests_logs
	mkdir -p $VM_dir/inner/i_pagny/tests_logs

	for file in $VM_dir/inner/i_pagny/*.cor;
        do
			printf "$COLOR\0Error on TEST[$i] 🔥\n$END" >> $VM_dir/inner/i_pagny/tests_logs/TEST[$i].txt 2>&1
			printf "./$VM_dir/corewar $file\n" >> $VM_dir/inner/i_pagny/tests_logs/TEST[$i].txt 2>&1
	        ./$VM_dir/corewar $file >> $VM_dir/inner/i_pagny/tests_logs/TEST[$i].txt 2>&1
			# pkill corewar
			if grep -r "Usage:" $VM_dir/inner/i_pagny/tests_logs/TEST[$i].txt > /dev/null;
			then
				rm $VM_dir/inner/i_pagny/tests_logs/TEST[$i].txt
		fi
		let "i++"
            # printf "$COLOR\0■$END"
        done
	cat $VM_dir/inner/i_pagny/tests_logs/*

	printf "$COLOR\0[INNER PARSING TESTS DONE]\n$END"
    read -p "Press enter to continue..."
}

run_vm_tests()
{
    clear
	printf "$COLOR\0TN_TEST // COREWAR\n$END"
	printf "$COLOR\0VM TESTS\n$END"

	if [ $(ls | grep corewar) ]
	then
		cp corewar $VM_dir/
	    # vm_compile_zaz
		outer_parsing_tests
		# inner_parsing_tests
	else
		printf "$COLOR\0Move your asm to the current folder, then restart (File must be named corewar).\n$END"
	fi
}