#!/bin/bash

asm_compile_zaz()
{
	printf "$COLOR\0Compiling Zaz...This can take up to 6 minutes...\n$END"

    rm -rf $ASM_dir/zaz_cor
    mkdir -p $ASM_dir/zaz_cor
    printf "$COLOR\0[$END"
    for file in $ASM_dir/s_files/*.s;
        do
	        ./$ASM_dir/zaz $file > /dev/null 2>&1
	        # ./$ASM_dir/zaz $file
            printf "$COLOR\0■$END"
        done
    printf "$COLOR\0]$END"
    for file in $ASM_dir/s_files/*.cor;
        do
            mv $file $ASM_dir/zaz_cor/
        done
}

asm_compile_you()
{
	printf "$COLOR\nCompiling you...\n$END"

    rm 2> /dev/null your_prog_log.txt
    rm -rf $ASM_dir/your_cor
    mkdir -p $ASM_dir/your_cor
    printf "$COLOR\0[$END"
        for file in $ASM_dir/s_files/*.s;
            do
	            ./$ASM_dir/asm $file >> $ASM_dir/your_asm_log.txt 2>&1
                printf "$COLOR\0■$END"
            done
    printf "$COLOR\0]$END"
        for file in $ASM_dir/s_files/*.cor;
            do
                mv $file $ASM_dir/your_cor/
            done
}

asm_make_a_difference()
{
    rm 2> /dev/null $ASM_dir/diff_log.txt
    # if [ $(ls | grep your_cor) ]
    # then

	printf "$COLOR\nWill you make a difference ?\n$END"

    diff -bur $ASM_dir/your_cor $ASM_dir/zaz_cor >> $ASM_dir/diff_log.txt
    cat $ASM_dir/diff_log.txt

    # fi
}

run_asm_tests()
{
    clear
	printf "$COLOR\0TN_TEST // COREWAR\n$END"
	printf "$COLOR\0ASM DIFF TESTS\n\n$END"

    if [ $(ls | grep asm) ]
	then
    	printf "$COLOR\0Disclaimer: this script only tests VALID players.\n$END"
		cp asm $ASM_dir/
	    # asm_compile_zaz
        asm_compile_you
        asm_make_a_difference
	else
		printf "$COLOR\0Move your corewar to the current folder, then restart.\n$END"
	fi
	printf "$COLOR\0[ASM DIFF TESTS DONE]\n\n$END"
    read -p "Press enter to continue..."
}