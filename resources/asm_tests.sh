#!/bin/bash

asm_compile_zaz()
{
	printf "$COLOR\0Compiling Zaz...This will take some time...\n$END"

    rm -rf $ASM_dir/zaz_cor
    mkdir -p $ASM_dir/zaz_cor
    for file in $ASM_dir/s_files/*.s;
        do
	        # ./$ASM_dir/zaz $file 2>&1
	        ./$ASM_dir/zaz $file
        done

    for file in $ASM_dir/s_files/*.cor;
        do
            mv $file $ASM_dir/zaz_cor/
        done
}

asm_compile_you()
{
	printf "$COLOR\0Compiling you...\n$END"

    rm 2> /dev/null your_prog_log.txt
    if [ $(ls | grep asm) ]
    then
        rm -rf your_cor
        mkdir -p your_cor
        for file in s_files/*.s;
            do
	            ./asm $file >> your_asm_log.txt 2>&1 
            done

        for file in s_files/*.cor;
            do
                mv $file your_cor/
            done
    else
		printf "$COLOR\0Move your asm to the current folder, then restart.\n$END"
    fi
}

asm_make_a_difference()
{
    rm 2> /dev/null diff_log.txt
    if [ $(ls | grep your_cor) ]
    then

	printf "$COLOR\0Will you make a difference ?\n$END"

    diff -bur your_cor zaz_cor >> diff_log.txt
    cat diff_log.txt

    fi
}

run_asm_tests()
{
    clear
	printf "$COLOR\0TN_TEST // COREWAR\n$END"
	printf "$COLOR\0ASM DIFF TESTS\n$END"
	printf "$COLOR\0Disclaimer: this script only tests VALID players.\n$END"
    asm_compile_zaz
    asm_compile_you
    asm_make_a_difference
}