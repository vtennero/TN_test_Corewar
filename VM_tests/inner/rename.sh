# i=1

# while [ $i -le 50 ]
# do
# 	mv pagny_u_$i.cor i_pagny_$i.cor
# 	let "i ++"
# done

RENAME=too_small_

i=1

for file in ./*.cor;
do
mv $file $RENAME$i.cor
let "i++"
done
