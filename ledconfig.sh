#! /bin/bash


ledFile="/sys/class/leds"


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
	for file in $ledFile/*; 
	do
		#prints the name of each file inside /sys/class/leds folder
	    	echo "$n. ""$(basename " $file")" 

		#assigning file names to variables so they can be called from other functions
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


# This function displays the led menu
# from this menu you can choose to turn the led on or off 
# or choose to associate the led with a system event
ledMenu()
{
	eval "selectDir=\$File_$selection" 

	
	echo ""
	echo $selectDir
	echo "================="
	echo "What would you like to do with this led?"
	
	echo "1) turn on"
	echo "2) turn off"
	echo "3) associate with a system event"
	echo "4) associate with the performance of a process"
	echo "5) stop association with a process’ performance"
	echo "6) quit to main menu"
	echo "Please enter a number (1-6) for for your choice:"
	
	read selection1
	
	case "$selection1" in 
	1)
		echo 1 > /sys/class/leds/$selectDir/brightness
		ledMenu
		;;
	2)
		echo 0 > /sys/class/leds/$selectDir/brightness
		ledMenu
		;;
	3)	
		eventsMenu
		;;
	4)
		processPerformance
		;;
	6)
		mainMenu
		;;
	*)
		echo "Error: Didn't enter a number from 1-6. Please try again: "
		ledMenu
		;;
esac
}


# This function displays the events menu
# from this menu you can choose a system event to associate the led with
eventsMenu()
{
	echo ""
	echo $selectDir
	echo "================================= "
	echo "Available events are: "
	echo "--------------------- "
	
	n=1
	for word in $(< /sys/class/leds/$selectDir/trigger)
	do
		# removes [] brackets from currently selected event and replaces them with * at the end of the word
	    	echo "$n) ${word}" | sed 's/\[//;s/\]/*/'

		# Assigning file names to variables so they can be called from other functions
		declare Line_$[n]=${word}
	
		n=$(( n+1 )) #increments $n 
	done
	
	echo "$n) Quit to previous menu"
	echo "Please select an option (1-$n):"
	
	read selection2
	eval "selectEvent=\$Line_$selection2" 
	
	
	i=$(( $n-1 )) 

	
	#
	if [ "$selection2" -lt 32 ]; then
	  echo $selectEvent > /sys/class/leds/$selectDir/trigger
	  eventsMenu
	elif [ "$selection2" -eq 33 ]; then
	  ledMenu
	else
	  echo "Error: Didn't enter a number from 1-$n. Please try again:"
	  eventsMenu
fi

}


# This function displays the process performance menu
processPerformance()
{

	echo ""
	echo "Associate LED with the performance of a process"
	echo "------------------------------------------------"
	echo "Please enter the name of the program to monitor(partial names are ok):"

	read programName

	ps -ejH

	echo "Do you wish to 1) monitor memory or 2) monitor cpu? [enter memory or cpu]: "
	echo "starting to monitor ***process name here***"
	

#SIGKILL (terminates a process)
}


# runs the main menu function when the code is executed
mainMenu