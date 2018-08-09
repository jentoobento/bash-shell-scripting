line="===================================="
flag=y
while [[ $flag = "y" || $flag = "Y" || $flag = "Yes" || $flag = "yes" ]]
do
	#reset flags
	player21=n
	playerbust=n
	dealer21=n
	dealerbust=n
	clear
	echo "Welcome to the Blackjack table!"
	echo "$line"
	read -p "Press enter to begin."

	decknames=("SpadesAce" "SpadesTwo" "SpadesThree" "SpadesFour" "SpadesFive" "SpadesSix" "SpadesSeven" "SpadesEight" "SpadesNine" "SpadesTen" "SpadesJack" "SpadesQueen" "SpadesKing" "HeartsAce" "HeartsTwo" "HeartsThree" "HeartsFour" "HeartsFive" "HeartsSix" "HeartsSeven" "HeartsEight" "HeartsNine" "HeartsTen" "HeartsJack" "HeartsQueen" "HeartsKing" "ClubsAce" "ClubsTwo" "ClubsThree" "ClubsFour" "ClubsFive" "ClubsSix" "ClubsSeven" "ClubsEight" "ClubsNine" "ClubsTen" "ClubsJack" "ClubsQueen" "ClubsKing" "DiamondsAce" "DiamondsTwo" "DiamondsThree" "DiamondsFour" "DiamondsFive" "DiamondsSix" "DiamondsSeven" "DiamondsEight" "DiamondsNine" "DiamondsTen" "DiamondsJack" "DiamondsQueen" "DiamondsKing")

	deck=()
	min=0 
	max=52
	count=1
	while [[ $count -le 52 ]]
	do
		random=$(( RANDOM % $max + $min ))
		numtomove=${decknames[$random]}
		while [[ "$numtomove" == "deleted" ]]
		do
			random=$(( RANDOM % $max + $min ))
			numtomove=${decknames[$random]}
		done
		deck+=( $numtomove ) 
		decknames[$random]="deleted"
		count=$(( count + 1 ))
	done

	player=()
	dealer=()

	echo "Dealing you a card..."
	sleep .75
	numdealt=0 
	topcard=${deck[$numdealt]} 
	player+=($topcard)
	echo "You pick up a $topcard."

	echo "Dealer takes a card..."
	sleep 1
	numdealt=$(( numdealt + 1 ))
	topcard=${deck[$numdealt]} 
	dealer+=($topcard)

	echo "Dealing you a card..."
	sleep 2
	numdealt=$(( numdealt + 1 ))
	topcard=${deck[$numdealt]} 
	player+=($topcard)
	echo "You pick up a $topcard."

	echo "Dealer takes a card..."
	sleep 2
	numdealt=$(( numdealt + 1 ))
	topcard=${deck[$numdealt]} 
	dealer+=($topcard)
	echo "$line"
	echo "Dealer shows a $topcard." 

	playerhand=0
	dealerhand=0

	for ((i=0;i<${#player[*]};i++))
	do
		case ${player[$i]} in
			*"Ace")	playerhand=$(( playerhand + 11 ));;
			*"Two") playerhand=$(( playerhand + 2 ));;
			*"Three") playerhand=$(( playerhand + 3 ));;
			*"Four") playerhand=$(( playerhand + 4 ));;
			*"Five") playerhand=$(( playerhand + 5 ));;
			*"Six") playerhand=$(( playerhand + 6 ));;
			*"Seven") playerhand=$(( playerhand + 7 ));;
			*"Eight") playerhand=$(( playerhand + 8 ));;
			*"Nine") playerhand=$(( playerhand + 9 ));;
			*"Ten") ;& 
			*"Jack") ;& 
			*"Queen") ;&
			*"King") playerhand=$(( playerhand + 10 ));;
			*) echo "Error";;
		esac
	done

	#if player gets 2 aces on the first draw calculate as 12
	if [[ $playerhand -eq 22 ]]
	then
		playerhand=12
	fi

	echo "$line"
	echo "You have ${player[0]} and ${player[1]}."
	echo "Your hand equals to $playerhand."
	echo "$line"

	#find initial value for dealer's hand
	for ((i=0;i<${#dealer[*]};i++))
	do
		case ${dealer[$i]} in
			*"Ace")	dealerhand=$(( dealerhand + 11 ));;
			*"Two") dealerhand=$(( dealerhand + 2 ));;
			*"Three") dealerhand=$(( dealerhand + 3 ));;
			*"Four") dealerhand=$(( dealerhand + 4 ));;
			*"Five") dealerhand=$(( dealerhand + 5 ));;
			*"Six") dealerhand=$(( dealerhand + 6 ));;
			*"Seven") dealerhand=$(( dealerhand + 7 ));;
			*"Eight") dealerhand=$(( dealerhand + 8 ));;
			*"Nine") dealerhand=$(( dealerhand + 9 ));;
			*"Ten") ;& 
			*"Jack") ;& 
			*"Queen") ;&
			*"King") dealerhand=$(( dealerhand + 10 ));;
			*) echo "Error";;
		esac
	done

	if [[ $dealerhand -eq 22 ]]
	then
		dealerhand=12
	fi

	if [[ $playerhand -eq 21 && $dealerhand -eq 21 ]]
	then 
		echo "The dealer shows ${dealer[0]} and ${dealer[1]}."
		echo "PUSH! Both players have Blackjack!"
	elif [[	$playerhand -eq 21 && $dealerhand -ge 17 ]]
	then 
		echo "The dealer shows ${dealer[0]} and ${dealer[1]}."
		echo "BLACKJACK! You WIN!"
	else 
		if [[ $playerhand -eq 21 ]]
		then 
			player21=y
			echo "BLACKJACK!"
		fi

		option=0
		while [[ $option -ne 2 && $player21 != "y" ]]
		do
			echo "Dealer is waiting for your signal..."
			echo "1) Hit"
			echo "2) Stay"
			echo "What will you do?"
			read option
			while [[ $option -ne 1 && $option -ne 2 ]]
			do
				echo "Choose an action. (1)Hit or (2)Stay"
				read option
			done
			if [[ $option -eq 1 ]]
			then
				echo "Dealing you a card..."
				sleep 1
				numdealt=$(( numdealt + 1 ))
				topcard=${deck[$numdealt]} 
				player+=($topcard)
				echo "You pick up a $topcard."
				
				case $topcard in
					*"Ace")	playerhand=$(( playerhand + 11 ));;
					*"Two") playerhand=$(( playerhand + 2 ));;
					*"Three") playerhand=$(( playerhand + 3 ));;
					*"Four") playerhand=$(( playerhand + 4 ));;
					*"Five") playerhand=$(( playerhand + 5 ));;
					*"Six") playerhand=$(( playerhand + 6 ));;
					*"Seven") playerhand=$(( playerhand + 7 ));;
					*"Eight") playerhand=$(( playerhand + 8 ));;
					*"Nine") playerhand=$(( playerhand + 9 ));;
					*"Ten") ;& 
					*"Jack") ;& 
					*"Queen") ;&
					*"King") playerhand=$(( playerhand + 10 ));;
					*) echo "Error";;
				esac
				echo "$line"
				echo "Your hand now equals to $playerhand."
				echo "$line"
			else
				echo "$line"
				echo "You are staying at $playerhand."
				echo "$line"
			fi

			if [[ $playerhand -gt 21 ]]
			then 
				echo "You BUSTED!"
				playerbust=y
				break
			elif [[	$playerhand -eq 21 ]]
			then	
				echo "BLACKJACK!"
				player21=y
				break
			fi
		done

		echo "Dealer shows ${dealer[0]} and ${dealer[1]}." 

		while [[ $dealerhand -lt 17 ]]
		do
			echo "Dealer takes a hit..."
			sleep 1
			numdealt=$(( numdealt + 1 ))
			topcard=${deck[$numdealt]} 
			dealer+=($topcard)
			echo "Dealer picks up a $topcard."
			
			case $topcard in
				*"Ace")	dealerhand=$(( dealerhand + 11 ));;
				*"Two") dealerhand=$(( dealerhand + 2 ));;
				*"Three") dealerhand=$(( dealerhand + 3 ));;
				*"Four") dealerhand=$(( dealerhand + 4 ));;
				*"Five") dealerhand=$(( dealerhand + 5 ));;
				*"Six") dealerhand=$(( dealerhand + 6 ));;
				*"Seven") dealerhand=$(( dealerhand + 7 ));;
				*"Eight") dealerhand=$(( dealerhand + 8 ));;
				*"Nine") dealerhand=$(( dealerhand + 9 ));;
				*"Ten") ;& 
				*"Jack") ;& 
				*"Queen") ;&
				*"King") dealerhand=$(( dealerhand + 10 ));;
				*) echo "Error";;
			esac
			echo "$line"
			echo "Dealer's hand now equals to $dealerhand."
			echo "$line"
		done

		if [[ $dealerhand -eq 21 ]]
		then 
			echo "Dealer has BLACKJACK!"
			dealer21=y
		elif [[ $dealerhand -gt 21 ]]
		then
			echo "Dealer BUSTS!"
			dealerbust=y
		elif [[ $dealerhand -ge 17 && $dealerhand -lt 21 ]]
		then
			echo "Dealer stays at $dealerhand."
		fi
	
		echo "$line"
		if [[ $player21 = "y" && $dealer21 = "y" ]]
		then 
			echo "PUSH! Both players have Blackjack!"
		elif [[ $playerbust = "y" && $dealerbust = "y" ]]
		then 
			echo "PUSH! Both players Busted!"
		elif [[ $player21 = "y" && $dealerbust = "y" ]]
		then 
			echo "BLACKJACK! Dealer Busted! You WIN!"
		elif [[ $dealer21 = "y" && $playerbust = "y" ]]
		then 
			echo "BUST! Dealer has Blackjack! You lose!"
		elif [[ $dealerbust = "y" && $playerbust != "y" ]]
		then 
			echo "Dealer Busted! You WIN!"
		elif [[ $playerbust = "y" && $dealerbust != "y" ]]
		then 
			echo "BUST! You Lose!"
		elif [[ $playerbust != "y" && $playerhand -gt $dealerhand ]]
		then 
			echo "Your hand beat the dealer's! You WIN!"
		elif [[ $playerhand -eq $dealerhand ]]
		then 
			echo "PUSH! No hand wins."
		elif [[ $dealerbust != "y" && $playerhand -lt $dealerhand ]]
		then 
			echo "The dealer's hand beat yours! You Lose!"
		fi
	fi
	echo "$line"
	echo "Would you like to play again? Y/N"
	read flag
	while [[ $flag != "Y" && $flag != "y" && $flag != "Yes" && $flag != "yes" && $flag != "N" && $flag != "n" && $flag != "No" && $flag != "no" ]]
	do
		echo "Play again? (Y)es or (N)o"
		read flag
	done
done
