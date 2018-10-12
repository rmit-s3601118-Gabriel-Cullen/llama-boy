#! /bin/bash



# This function displays the main menu
# That is the menu that contains the names of all the leds that can be configured 
mainMenu()
{

	echo ""
	echo "Welcome to Gabe's LED_Configurator!"
	echo "==================================="
	echo "Please select an led to configure:"
	
	n=1

	#Searches through files in the /leds folder
	for file in "/sys/class/leds"/*; 
	do
		#prints the name of each file inside /sys/class/leds folder
	    	echo "$n. ""$(basename " $file")" 

		#assigning file names to variables so they can be called in other parts of the code
		declare File_$[n]="$(basename " $file")" 
		
	n=$(( n+1 )) #increments $n 
	done
	
	echo "$n. Quit"
	echo "Please enter a number (1-$n) for the led to configure or quit:"
	
	read selection #read user input 
	
	
	i=$(($n-1))
	

	#case statement based on user input
	case "$selection" in 
	[1-$i])
		ledMenu #call ledMenu function
		;;
	$n)
		exit 0
		;;
	*)
		echo "Error: Didn't enter a number from 1-$n. Please try again:"
		mainMenu
		;;
esac
}