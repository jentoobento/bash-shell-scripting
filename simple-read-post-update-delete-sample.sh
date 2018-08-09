line="==================================="
echo "What is the name of your phonebook?"
read pbname
while [[ "${#pbname}" -lt 1 ]]
do
	echo "Sorry phonebook names must be at least one character long."
	echo "What is the name of your phonebook?"
	read pbname
done
choice=0
while [ "$choice" -ne 5 ]
do
	echo "$line"
	echo "Phone Book System Menu"
	echo "$line"
	echo "1) Add an entry"
	echo "2) Delete an entry"
	echo "3) List file or entry"
	echo "4) Change entry"
	echo "5) Exit System"
	echo "$line"
	echo "What is your choice?"
	read choice
	
	while [[ "$choice" == *[A-Z]* || "$choice" == *[a-z]* || "$choice" -gt 5 || "$choice" -lt 1 ]]
	do
		echo "Sorry that choice is invalid."
		echo "What is your choice?"
		read choice
	done

	if [ "$choice" -eq 1 ]					
	then
		echo "$line"
		echo "> 1) Add an entry"
		echo "$line"
		answer=Y
		until [[ "$answer" == "N" || "$answer" == "n" ]]
		do
			echo "Enter a name to add:"
			read name
			while [[ "$name" == *[0-9]* || "$name" == *[:]* ]] 				
			do
				echo "Sorry names cannot contain numbers or colons."
				echo "Enter a name to add:"
				read name
			done 
			echo "Enter phone number to add:"
			read number
			while [[ "$number" == *[:]* || "$number" == *[A-Z]* || "$number" == *[a-z]* ]]	
			do
				echo "Sorry numbers cannot contain letters or colons."
				echo "Enter a number to add:"
				read number
			done
			echo "$name:$number" >> $pbname						
			echo "Entry $name $number has been added."
			echo "Would you like to add another? Y/N"
			read answer

			while [[ "$answer" != "Y" && "$answer" != "y" && "$answer" != "N" && "$answer" != "n" ]]
			do
				echo "Sorry that choice is invalid."
				echo "Would you like to add another? (Y)es or (N)o"
				read answer
			done
		done	
		read -p "Press enter to return to menu."
	fi

	if [ $choice -eq 2 ]								
	then
		if [[ ! -s $pbname || ! -f $pbname ]]						
		then
			echo "There are no entries to delete in file: $pbname."
			echo "Please use the first choice to add an entry."
		else
			echo "$line"
			echo "> 2) Delete an entry"
			echo "$line"
			answer=Y
			until [[ $answer == "N" || $answer == "n" ]]
			do
				echo "Enter name to delete:"
				read name
				if grep -q -i $name $pbname				
				then
					echo "Here are the entries that match:"
					echo "$line"	
					awk 'BEGIN{IGNORECASE=1} {FS=":"} {if($1 ~ "'${name}'") print NR")", $0;}' $pbname 	
					grep -n -i $name $pbname | awk 'BEGIN {FS=":"} {print $1;}' > temp	 
					echo "$line"
					echo "Enter number of entry to delete:"
					read num
					valid=n
					while [[ "$valid" == "n" ]]
					do
						if [[ "$num" != *[0-9]* ]]
						then
							valid=n
							echo "Sorry that entry number is invalid."
							echo "Please choose number of entry to delete:"
							read num
						elif grep -q $num temp
						then
							valid=y
						else
							valid=n
							echo "Sorry that entry number is invalid."
							echo "Please choose an entry number listed above."
							read num
						fi
					done		
					rm temp								
					echo "$line"
					awk '{if(NR=="'${num}'") print $0,"was deleted.";}' $pbname	
					sed "$num"'d' $pbname > temp					
					mv temp $pbname							
				else
					echo "There are no entries that match that name."
				fi

				echo "Would you like to delete another? Y/N"
				read answer
				while [[ "$answer" != "Y" && "$answer" != "y" && "$answer" != "N" && "$answer" != "n" ]]
				do
					echo "Sorry that choice is invalid."
					echo "Would you like to delete another? (Y)es or (N)o"
					read answer
				done
			done
		fi
		read -p "Press enter to return to menu."
	fi

	if [ $choice -eq 3 ]										
	then
		if [[ ! -s $pbname || ! -f $pbname ]]
		then
			echo "There are no entries to list in file: $pbname."
			echo "Please use the first choice to add an entry."
		else
			echo "$line"
			echo "> 3) List file or entry"
			answer=Y
			until [[ $answer == "N" || $answer == "n" ]]
			do
				echo "$line"
				echo "Options:"
				echo "   1) List specific entry"
				echo "   2) List all entries"
				echo "$line"
				echo "Please choose an option:"
				read option
				while [[ "$option" == *[A-Z]* || "$option" == *[a-z]* || "$option" -gt 2 || "$option" -lt 1 ]]
				do
					echo "Sorry that option is invalid."
					echo "Please choose an option:"
					read option
				done				

				if [ "$option" -eq 1 ]					
				then
					echo "Enter name:"
					read name
					if grep -q -i $name $pbname
					then
						echo "Here are the entries with that name:"
						echo "$line"
						#awk 'BEGIN {FS=":"} {if($1 ~ "'${name}'") print $0;}' $pbname	
						grep -i "$name" $pbname
						echo "$line"
					else
						echo "There are no entries that match that name."
					fi
				else									
					echo "Instructions:" > temp
					echo "Press 'u' to scroll up." >> temp
					echo "Press 'd' to scroll down." >> temp
					echo "Press 'q' when you are finished." >> temp
					echo "========================================" >> temp
					echo "All entries in $pbname:" >> temp
					echo "========================================" >> temp
					cat $pbname >> temp
					less temp
					rm temp							
				fi

				echo "Would you like to list entries again? Y/N"
				read answer
				while [[ "$answer" != "Y" && "$answer" != "y" && "$answer" != "N" && "$answer" != "n" ]]
				do
					echo "Sorry that choice is invalid."
					echo "Would you like to list entries again? (Y)es or (N)o"
					read answer
				done
			done
		fi
		read -p "Press enter to return to menu."
	fi

	if [ $choice -eq 4 ]										
	then	
		if [[ ! -s $pbname || ! -f $pbname ]]
		then
			echo "There are no entries to change in file: $pbname."
			echo "Please use the first choice to add an entry."
		else
			answer=Y
			echo "$line"
			echo "> 4) Change entry"
			echo "$line"
			until [[ "$answer" == "N" || "$answer" == "n" ]]
			do
				echo "Enter name of entry to be changed:"
				read name
				while [[ "$name" == *[0-9]* || "$name" == *[:]* ]]
				do
					echo "Sorry names cannot contain numbers or colons."
					echo "Enter name of entry to be changed."
					read name
				done
				if grep -q -i $name $pbname
				then
					echo "Here are the entries with that name:"
					echo "$line"	
					awk 'BEGIN{IGNORECASE=1} {FS=":"} {if($1 ~ "'${name}'") print NR")",$0;}' $pbname
					grep -n -i $name $pbname | awk 'BEGIN {FS=":"} {print $1;}' > temp	 
					echo "$line"
					echo "Please choose which entry number to change:"
					read num
					valid=n
					while [[ "$valid" == "n" ]]
					do
						if [[ "$num" != *[0-9]* ]]
						then
							valid=n
							echo "Sorry that entry number is invalid."
							echo "Please choose what entry number to change."
							read num
						elif grep -q $num temp
						then
							valid=y
						else
							valid=n
							echo "Sorry that entry number is invalid."
							echo "Please choose an entry number listed above."
							read num
						fi
					done		
					rm temp					
					echo "$line"
					echo "Options:"
					awk 'BEGIN {FS=":"} {if(NR=="'${num}'") print "   1) Change this name:",$1;}' $pbname
					awk 'BEGIN {FS=":"} {if(NR=="'${num}'") print "   2) Change this number:",$2;}' $pbname
					echo "$line"
					echo "Please choose an option:"
					read option
			
					while [[ "$option" == *[A-Z]* || "$option" == *[a-z]* || "$option" -gt 2 || "$option" -lt 1 ]]
					do 
						echo "Sorry that option is invalid."
						echo "Please choose an option:"
						read option
					done

					if [ "$option" -eq 1 ]					
					then
						echo "Please enter the new full name:"
						read newname
						while [[ "$newname" == *[0-9]* || "$newname" == *[:]* ]]
						do
							echo "Sorry names cannot have numbers or colons."
							echo "Please enter the new full name:"
							read newname
						done
						awk -v n="$newname" 'BEGIN {FS=":"} NR=="'${num}'" {$1=n} {print $1":"$2;}' $pbname > temp
						mv temp $pbname							
						echo "$line"
						awk 'BEGIN {FS=":"} NR=="'${num}'" {print "The new entry is",$0;}' $pbname 
						echo "$line"
					else							
						echo "Please enter the new number:"
						read newnum
						while [[ "$newnum" == *[A-Z]* || "$newnum" == *[a-z]* || "$newnum" == *[:]* ]]
						do
							echo "Sorry numbers cannot contain letters or colons."
							echo "Please enter the new number:"
							read newnum
						done
						awk -v n="$newnum" 'BEGIN {FS=":"} NR=="'${num}'" {$2=n} {print $1":"$2;}' $pbname > temp
						mv temp $pbname	
						echo "$line"
						awk 'BEGIN {FS=":"} NR=="'${num}'" {print "The new entry is",$0;}' $pbname
						echo "$line"
					fi
				else
					echo "There are no entries that match that name."
				fi					
				echo "Would you like to change another entry? Y/N"
				read answer
			done
		fi
		read -p "Press enter to return to menu."
	fi
done
echo "Goodbye!"
