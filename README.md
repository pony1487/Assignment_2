# Assignment_2
Object Oriented Programming Assignment 2: Make a Game


# C15737505 

# Object Oriented Programming Assignment 1

For this assignement we were tasked with making a game using the various skills we have learned over the past semester. These include:
 - Classes
 - Inheritance
 - Polymorphism
 - Abstract Classes
 - Interfaces
 - Vectors

## Basic Controls
The user can use the mosue to click the various menu buttons to navigate. When playing the game the following controls are used:
 - Up (to Fire jet pack), Left, Right to move the player
 - Space to fire upward 

Once the player dies the game is over and the score is displayed. The player has the option of pressing 'W' to write their score to a file, which will then be read,sorted and displayed on the LeaderBoard page.

## Core Gameplay
The gameplay is based on a combination of space invaders and flappy bird. The player must shoot up to kill the enemies while jumping/flying over incoming obstacles from the right.
The are two types of powerups. One increases the players health to 200, and the other slows down the enemy and pipes movement.

## Music/Sound FX and Animation
The game uses the audio library minim to load and play .mp3 files. A variety of sound effects are applied to the player and enemies. For example, when the up key is pressed, the player's Y axis decreases, this triggers a jet pack sound while the players animation changes. The animation is done by storing different PImages in an array. A animation mode variable stores the index of array. This is changed depending on what movement the player is doing.

For the main music, I used an online 8 bit sound generate to create a simple beat and melody. This is loaded and played at the start of the the program. When the player hits the slowDown power up, the main music is stopped and a slowed down version of the same track is played for the duration of the power up effect.
 
 ## Video 
 
 ![Video](http://img.youtube.com/vi/tu1Nzzgk20I/0.jpg)](http://www.youtube.com/watch?v=tu1Nzzgk20I)










 

