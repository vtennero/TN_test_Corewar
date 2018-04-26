i=1

while [ $i -le 50 ]
do
	mv pagny_u_$i.cor i_pagny_$i.cor
	let "i ++"
done
