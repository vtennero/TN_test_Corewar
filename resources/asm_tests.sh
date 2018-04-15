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

    if [ $(ls | grep asm) ]
    then
        rm -rf your_cor
        mkdir -p your_cor
        for file in s_files/*.s;
            do
	            ./asm $file 2>&1
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
    if [ $(ls | grep your_cor) ]
    then
    # if [ $(ls your_cor) ]
    # then
	printf "$COLOR\0Will you make a difference ?\n$END"

    for file in your_cor/*.cor
        do
            diff $file ../zaz_cor/$file
        done
    # fi
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