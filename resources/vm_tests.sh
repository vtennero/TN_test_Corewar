#!/bin/bash

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

exec_and_save()
{
	echo "./corewar $1"
	./$VM_dir/corewar $1
	echo "\n"
}

outer_parsing_tests()
{
	printf "$COLOR\0OUTER PARSING TESTS\n$END"

	#Invalid dump
	exec_and_save -dump
	exec_and_save -dump 50
	exec_and_save -dump 50 -n
	exec_and_save -dump 50 5
	exec_and_save 50 5
	
	exec_and_save "$VM_dir/zaz_cor/Car.cor -dump"
	exec_and_save "$VM_dir/zaz_cor/Car.cor -n dump"
	exec_and_save "$VM_dir/zaz_cor/Car.cor -n 5"
	exec_and_save "$VM_dir/zaz_cor/Car.cor -n sdfsd"
	exec_and_save "-n abc $VM_dir/zaz_cor/Car.cor -n sdfsd"
	exec_and_save "-n 1 $VM_dir/zaz_cor/Car.cor -n 1 sdfsd"
	exec_and_save "-n -99991 $VM_dir/zaz_cor/Car.cor"
	exec_and_save "-n 1 $VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor"
	exec_and_save "-n 1 $VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor"
	exec_and_save "-n 1 $VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor -n 2 $VM_dir/zaz_cor/Car.cor -n 3 $VM_dir/zaz_cor/Car.cor"
	exec_and_save "-n 2 $VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor -n 2 $VM_dir/zaz_cor/Car.cor -n 3 $VM_dir/zaz_cor/Car.cor"
	exec_and_save "$VM_dir/zaz_cor/Car.cor -n 1 $VM_dir/zaz_cor/Car.cor -n 2 $VM_dir/zaz_cor/Car.cor -n 3 $VM_dir/zaz_cor/Car.cor"


}

# inner_parsing_tests()
# {

# }

run_vm_tests()
{
    clear
	printf "$COLOR\0TN_TEST // COREWAR\n$END"
	printf "$COLOR\0VM TESTS\n$END"
	# printf "$COLOR\0Disclaimer: this script only tests VALID players.\n$END"

	if [ $(ls | grep corewar) ]
	then
		cp corewar $VM_dir/
	    # vm_compile_zaz
		outer_parsing_tests
		# inner_parsing_tests
	else
		printf "$COLOR\0Move your corewar to the current folder, then restart.\n$END"
	fi
}