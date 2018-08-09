#!/bin/ksh
line="===================================="
flag=y
while [[ $flag = "y" || $flag = "Y" || $flag = "Yes" || $flag = "yes" ]]
do
	clear
	echo "Welcome to the Craps table!"
	echo "$line"
	read -p "Press enter to roll the first die."
	
	min=1 
	max=6 
	hit=0 
	craps=() 

	roll1=$(( RANDOM % $max + $min ))
	craps+=($roll1)
	echo "Rolling..."
	sleep .5
	echo "You rolled $roll1."
	read -p "Press enter to roll the second die."

	roll2=$(( RANDOM % $max + $min ))
	craps+=($roll2)
	echo "Rolling..."
	sleep .75
	echo "You rolled $roll2."

	echo "$line"
	point=$(( roll1 + roll2 ))
	echo "$roll1 and $roll2 equals $point." 

	if [[ $point -eq 7 || $point -eq 11 ]]
	then
		echo "$line"
		echo "You WIN!"
	elif [[ $point -eq 2 || $point -eq 3 || $point -eq 12 ]]
	then
		echo "$line"
		echo "Sorry you lose!"
	else
		while [[ $hit -ne $point && $hit -ne  7 ]]
		do
			echo "$line"
			echo "You are rolling for $point..."
			read -p "Press enter to roll the first die."
			roll1=$(( RANDOM % $max + $min ))
			craps+=($roll1)
			echo "Rolling..."
			sleep .5
			echo "You rolled $roll1."
			
			read -p "Press enter to roll the second die."
			roll2=$(( RANDOM % $max + $min ))
			craps+=($roll2)
			echo "Rolling..."
			sleep .75
			echo "You rolled $roll2."
		
			hit=$(( roll1 + roll2 ))

			echo "$roll1 and $roll2 equals $hit."
		done
	
		if [[ $hit -eq $point ]]
		then
			echo "$line"
			echo "You WIN!"
		else 
			echo "$line"
			echo "Sorry you lose!"
		fi
	fi

	echo -n "Here are all your rolls: "
	for ((i=0;i<${#craps[*]};i++))
	do
		if [[ $(( i + 1 )) -eq ${#craps[*]} ]]
		then
			echo -ne "and ${craps[$i]}.\n"
		else
			echo -n "${craps[$i]}, "
		fi
	done
	
	echo "$line"
	echo "Would you like to play again? Y/N"
	read flag
	while [[ $flag != "y" && $flag != "Y" && $flag != "Yes" && $flag != "yes" && $flag != "N" && $flag != "n" && $flag != "No" && $flag != "no" ]]
	do
		echo "Play again? (Y)es or (N)o"
		read flag
	done
done
