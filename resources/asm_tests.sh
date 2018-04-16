#!/bin/bash

compile_zaz()
{
	printf "$COLOR\0Compiling Zaz...This will take some time...\n$END"

    rm -rf zaz_cor
    mkdir -p zaz_cor
    for file in s_files/*.s;
        do
	        ./zaz $file 2>&1
        done

    for file in s_files/*.cor;
        do
            mv $file zaz_cor/
        done
}

compile_you()
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

make_a_difference()
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
    # compile_zaz
    compile_you
    make_a_difference
}