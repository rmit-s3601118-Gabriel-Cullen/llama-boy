Assignment 2 - Unix systems admin


CONTENTS OF THIS FILE
---------------------
   
 * Introduction
 * Requirements
 * Configuration




INTRODUCTION
------------

My program can change any led dynamically so it doesnt matter what led files are in the directory it will read them all.
It can turn the led on, off and change event of the led as in the assignment specs.

The ledconfig.sh file contains the mainMenu function, the ledMenu function, the eventsMenu function and the processPerformance function. 
When the code is run the mainMenu function is called and all other menus can be accessed after choosing an led from the main menu.


 * For full code and  files, visit the github project page:
   https://github.com/rmit-s3601118-Gabriel-Cullen/llama-boy




REQUIREMENTS
------------

This module requires the following modules:

 * ledConfig.sh (https://github.com/rmit-s3601118-Gabriel-Cullen/llama-boy/blob/master/ledconfig.sh)




CONFIGURATION
-------------

* The code should be executed using the command "sudo ./ledconfig.sh". 
* Needs root privilages so that it can access and make changes to the led files.