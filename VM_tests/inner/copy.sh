i=1

while [ $i -le 50 ]
do
	cp pagny.cor pagny_u_$i.cor
	let "i ++"
done
