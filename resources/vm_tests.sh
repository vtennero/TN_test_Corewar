#!/bin/bash

OUTER=$VM_dir/outer/tests_logs

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
	printf "$COLOR\0OUTER PARSING TESTS\n\n$END"
	
	local i=1
    
	rm -rf 2> /dev/null $OUTER
	mkdir -p $OUTER

	#Invalid dump
	local TEST[1]="-dump" 
	local TEST[2]="-dump 50"
	local TEST[3]="-dump dsjfklsj"
	local TEST[4]="-dump 50 -n"
	local TEST[5]="-dump 50 5"
	local TEST[6]="50 5"
	local TEST[7]="-n -dump"
	
	local TEST[8]="$VM_dir/zaz_cor/Car.cor -dump" 
	local TEST[9]="$VM_dir/zaz_cor/Car.cor -n -dump" 
	local TEST[10]="$VM_dir/zaz_cor/Car.cor -n dump" 
	local TEST[11]="$VM_dir/zaz_cor/Car.cor -n 5" 
	local TEST[12]="$VM_dir/zaz_cor/Car.cor -n sdfsd" 
	local TEST[13]="-n abc $VM_dir/zaz_cor/Car.cor -n sdfsd" 
	local TEST[14]="-n 1 $VM_dir/zaz_cor/Car.cor -n 1 sdfsd" 
	local TEST[15]="-n 1 -dump $VM_dir/zaz_cor/Car.cor -n 1 sdfsd" 
	local TEST[16]="-n 1 -dump a $VM_dir/zaz_cor/Car.cor -n 1 sdfsd" 
	local TEST[17]="-n -99991 $VM_dir/zaz_cor/Car.cor" 
	local TEST[18]="-n 1 $VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor" 
	local TEST[19]="-n 1 $VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor" 
	local TEST[20]="-n 1 $VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor -n 2 $VM_dir/zaz_cor/Car.cor -n 3 $VM_dir/zaz_cor/Car.cor" 
	local TEST[21]="-n 2 $VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor -n 2 $VM_dir/zaz_cor/Car.cor -n 3 $VM_dir/zaz_cor/Car.cor"
	local TEST[22]="$VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor -n 2 $VM_dir/zaz_cor/Car.cor -n 3 $VM_dir/zaz_cor/Car.cor"

	while [ $i -le 22 ]
	do
		echo "$COLOR\0Error on TEST $i 🔥$END" >> $OUTER/TEST[$i].txt 2>&1
		./$VM_dir/corewar ${TEST[$i]} >> $OUTER/TEST[$i].txt 2>&1
		pkill corewar
		if grep -r "Usage:" $OUTER/TEST[$i].txt > /dev/null;
			then
				rm $OUTER/TEST[$i].txt
		fi
		let "i++"
	done
	cat $OUTER/*

	printf "$COLOR\0[OUTER PARSING TESTS DONE]\n\n$END"
    read -p "Press enter to continue..."
}

inner_parsing_tests()
{
	
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
		# outer_parsing_tests
		inner_parsing_tests
	else
		printf "$COLOR\0Move your asm to the current folder, then restart.\n$END"
	fi
}