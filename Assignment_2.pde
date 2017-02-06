/*
  c15737505
 Object Oriented Programming
 Assignment 2
 
 */
//used for text input on screen
import controlP5.*;
ControlP5 cp5;

//audio stuff
import ddf.minim.*;
Minim minim;
AudioPlayer gunSound;
AudioPlayer playerHit;
AudioPlayer playerDies;
AudioPlayer jetPack;
AudioPlayer enemyExplosion;
AudioPlayer music;
AudioPlayer slowMusic;

//used to store players score and name
import java.io.FileWriter;
File file;
Table table;

BufferedReader reader;

//Gravity and other useful constants
final float GRAVITY = 5;
float timeDelta = 1.0f / 60.0f;
float timePassedInMain = 0;

//buttons for menu
Button b1;
Button b2;
Button b3;
Button b4;
Button b5;


//spawn times
float enemySpawnRate = 2.0;
float enemySpawnTime = 1.0 / enemySpawnRate;

float bPowerupSpawnRate = 4.0;
float bPowerupSpawnTime = 1.0 / bPowerupSpawnRate;

float sPowerUpSpawnRate = 6.0;
float sPowerUpSpawnTime = 1.0 / sPowerUpSpawnRate;

//ground variables
float groundX, groundY;
float groundHeight;

//ArrayLists
ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[1000];//this and check keys are bryans code
ArrayList<String> leaderBoardScores = new ArrayList<String>();



//mode for each screen;
//1 = Game, 2 = Readme, 3 = Exit, 4 = Game Over, 5 = leaderboard
int mode;

//background and floor images
PImage backgroundImage;
PImage groundImage;
PImage enemyImage;
PImage berzerkImage;
PImage slowDownImage;

//Other varaibles
int playerScore;// trying to figure how to ecapsulate this in the player class. Cant get enemy object to let player object know it is hit
String userName;

//used to manipulate speed of enemies and terrain when powerup
float enemySpeed;
float terrainSpeed;
float durationOfEffect;

//scoreScreen for player score and info
ScoreScreen scoreScreen;


//"Pipes"
Terrain t;

//used to make sure  drawCP5Buttons() is called once so it doesnt keep creating textbox 60fps
boolean  cp5Called;
boolean terrainCalled;

void setup()
{
  size(800, 600);

  //set up ground
  groundHeight = 50;
  groundX = 0;
  groundY = height - groundHeight;

  //set up background and floor
  backgroundImage = loadImage("skybackground.jpg");
  backgroundImage.resize(width, height);

  groundImage = loadImage("ground.png");
  groundImage.resize(width, 100);

  //make new terrain add it to array
   generateTerrain();

  //for writing player scores to file
  //It defaults to wherever processing is saved on the hard drive. I could not find how to have the file default to wherever the sketch is saved. I am not sure if this will
  //work on your computer.
  file = new File("C:\\Users\\Ronan\\Documents\\College\\Year 2\\Semester 1\\Object Oriented Programming\\Assignment_2\\scores.tsv");
  //start at menu
  mode = 0;

  //init speeds
  enemySpeed = 1; //default is 1
  terrainSpeed = 3; //default is 3
  durationOfEffect = 3.0;

  //set up scoreScreen
  scoreScreen = new ScoreScreen();

  //get user name
  /*
    cp5 = new ControlP5(this);
   cp5.setColorForeground(#FFFF00);
   cp5.setColorBackground(0);
   cp5.setColorActive(#FFFF00);
   */


  //init buttons
  initButtons();

  //init table to read scores
  //is this used???? Check and delete if not
  table = loadTable("scores.tsv", "header");


  //used for reading files
  reader = createReader("scores.tsv");

  //reset flag
  cp5Called = false;
  terrainCalled = false;

  //init audio stuff
  minim = new Minim(this);
  gunSound = minim.loadFile("gunSound.mp3");
  playerHit = minim.loadFile("playerHit.mp3");
  playerDies = minim.loadFile("playerDies.mp3");
  jetPack = minim.loadFile("jetPack.mp3");
  enemyExplosion = minim.loadFile("enemyExplosion.mp3");
  music = minim.loadFile("MainSong.mp3");
  slowMusic = minim.loadFile("GameMusicSlowed.mp3");
  
  //load images for readme
  enemyImage = loadImage("enemy1.png");
  berzerkImage = loadImage("heart.png");
  slowDownImage = loadImage("beer.png");
  
  enemyImage.resize(200,200);
  berzerkImage.resize(200,200);
  slowDownImage.resize(200,200);
   
  music.play();
 
}//end setup

void draw()
{

  switch(mode)
  {
  case 0:
    background(0);

    drawMenu();
    terrainCalled = false;

    //ensure the text/submit field is only draw once
    if (!cp5Called)
    {
      drawCP5Buttons();
    }

    playerDies.pause();
    break;
  case 1:
    //background(0);
    //remove name box
    cp5.remove("name");
    cp5.remove("submit");
    
    if(!terrainCalled)
    {
       generateTerrain(); 
    }


    image(backgroundImage, 0, 0);
    drawGameObjects();
    drawGround();
    timePassedInMain += timeDelta;//keep track of time in main

    //do stuff here to have enemy spawn at intervals
    //println("Game Timer: " + timePassedInMain);
    //println("Speed: " + enemySpeed);
    if (enemySpawnTime > enemySpawnRate)
    {
      spawnEnemy();
      enemySpawnTime = 0;  //reset time
    }

    if (bPowerupSpawnTime > bPowerupSpawnRate )
    {
      spawnBerzerkPowerUp();
      bPowerupSpawnTime = 0;
    }

    if (sPowerUpSpawnTime > sPowerUpSpawnRate )
    {
      spawnSlowDownPowerUp();
      sPowerUpSpawnTime = 0;
    }

    //increment time between spawns
    enemySpawnTime += timeDelta;
    bPowerupSpawnTime += timeDelta;
    sPowerUpSpawnTime += timeDelta;

    //reset the boolean so when you go back to the main menu you can enter a name again
    cp5Called = false;
    playerDies.pause();
    break;
  case 2:
    background(0);
    cp5.remove("name");
    cp5.remove("submit");
   
    //reset the boolean so when you go back to the main menu you can enter a name again
    cp5Called = false;
    terrainCalled = false;
    drawReadMe();
    playerDies.pause();
    break;
  case 3:

    exit(); 
    break;
  case 4:
    cp5.remove("name");
    cp5.remove("submit");
    cp5Called = false;
     terrainCalled = false;
    drawScoreScreen();


    break;

  case 5:
    background(0);
    printLeaderBoard();
    cp5.remove("name");
    cp5.remove("submit");
    //text("Leaderboard", width/2, height/2);
    //reset the boolean so when you go back to the main menu you can enter a name again
    cp5Called = false;
     terrainCalled = false;
    break;
  }//end switch
}//end draw


void submit()
{
  userName=cp5.get(Textfield.class, "name").getText();


  initPlayer();
  mode = 1;
  cp5Called = true;
}

void drawGameObjects()
{
  for (int i = 0; i < gameObjects.size(); i++)
  {
    gameObjects.get(i).render(); 
    gameObjects.get(i).update();
  }
}//end drawGameObjects()

void drawGround()
{
  fill(0, 225, 0);
  noStroke();
  //rect(groundX, groundY, width, groundHeight);
  image(groundImage, groundX, groundY - 50);
}//end drawGround

void initPlayer()
{
  Player p =  new Player(userName);
  playerScore = 0;

  gameObjects.add(p);
}//end initPlayer



void generateTerrain()
{

   t = new Terrain();
   gameObjects.add(t);
   terrainCalled = true;
}

//spwan stuff
void spawnEnemy()
{
  //create enemy at radom x coordinate
  Enemy e = new Enemy(random(0, width), 0);
  gameObjects.add(e);
}

void spawnBerzerkPowerUp()
{
  BerzerkPowerUp bezerk = new BerzerkPowerUp(random(0, width), 0, 4);
  gameObjects.add(bezerk);
}

void spawnSlowDownPowerUp()
{
  SlowDownPowerUp slowDown = new SlowDownPowerUp(random(0, width), 0, 4);
  gameObjects.add(slowDown);
}

//game over screen
void drawScoreScreen()
{
  scoreScreen.update();
  scoreScreen.render();

  //play sound and reset music
  playerDies.play();
  music.rewind();
  //slowMusic.pause();
  slowMusic.rewind();

  b5.render();
  b5.drawText();
  b5.isClicked();
  
  //clean up objects.This stops the bug that onec a player dies they cant go back to the main menu and enter another name and play again
  for(int i = 0;i < gameObjects.size();i++)
  {
     gameObjects.remove(i); 
  }
}//end drawGameOver


void initButtons()
{
  float buttonWidth = 100;
  float buttonHeight  = 50;
  float buttonSpacing = 100;



  float buttonX = width / 2 - (buttonWidth / 2);
  float buttonY = height / 4;

  b1 = new Button(buttonWidth, buttonHeight, buttonX, buttonY, "Play");
  b2 = new Button(buttonWidth, buttonHeight, buttonX, buttonY + buttonSpacing, "Readme");
  b3 = new Button(buttonWidth, buttonHeight, buttonX, buttonY + (buttonSpacing * 2), "LeaderBoard");
  b4 = new Button(buttonWidth, buttonHeight, buttonX, buttonY + (buttonSpacing * 3), "Exit");
  b5 = new Button(buttonWidth, buttonHeight, buttonX, buttonY + (buttonSpacing * 3.75), "Home");
}//end initButtons()

void drawMenu()
{
  textSize(32);
  text("IGN 10/10", width/2, 100);

  b2.render();
  b2.drawText();
  b2.isClicked();


  b3.render();
  b3.drawText();
  b3.isClicked();

  b4.render();
  b4.drawText();
  b4.isClicked();

  //reset the player dying sound so it will play again player does not exit after dying
  playerDies.rewind();
}//edn drawMenu()


//wont work if file is empty!!!
void printLeaderBoard()
{  
  b5.render();
  b5.drawText();
  b5.isClicked();
  int leaderBoardSize = 3;//how many scores we will display
  int leaderBoardArraListSize = 0;//will be used to set the size of the temp array that will be sorted. The entire array, not just the first 3 elements

  textSize(32);

  text("LeaderBoard", width/2, 100);

  float leaderBoardSpaceing = 100;
  String line;

  //read scores from file
  try 
  {
    line = reader.readLine();
  } 
  catch (IOException e) 
  {
    e.printStackTrace();
    line = null;
  }
  if (line == null) 
  {
    // Stop reading because of an error or file is empty
    //this causes bug which stops the home button being pressed. 
    //noLoop();
  } else 
  {

    leaderBoardScores.add(line);
  }

  //use this to set size of temp string array
  leaderBoardArraListSize =  leaderBoardScores.size();

  //println("leaderBoardArraListSize = " + leaderBoardArraListSize);

  //array that will be used to sort scores
  String[] temp = new String[100];

  //intialise temp

  for (int i = 0; i < leaderBoardArraListSize; i++)
  {
    temp[i] = "EMPTY";
  }
  //testing
  for (int i = 0; i < leaderBoardArraListSize; i++)
  {
    //println(i + ") " + temp[i]);
  }



  textSize(26);
  //this is the only way I could this to work. It copies the 3 scores into a temp array. If I dont do this the program crashes while trying
  //to print the arrayList if the file is empty
  for (int i = 0; i < leaderBoardScores.size(); i++)
  {

    temp[i] = leaderBoardScores.get(i);
  }

  //sort temp array by last number
  char tempChar1;
  char tempChar2;

  for (int i = 0; i < leaderBoardArraListSize; i++)
  {
    for (int j = 0; j < (leaderBoardArraListSize - 1); j++)
    {
      tempChar1 = temp[j].charAt(temp[j].length() - 1);
      tempChar2  = temp[j+1].charAt(temp[j+1].length() - 1);

      //println(temp[j]);


      if (tempChar1 < tempChar2)
      {
        String tempString = temp[j];
        temp[j] = temp[j + 1];
        temp[j+1] = tempString;
      }
    }
  }
  //display scores
  fill(255);



  text("1) " + temp[0], width/2, height/2);
  text("2) " + temp[1], width/2, height/2 + leaderBoardSpaceing);
  text("3) " + temp[2], width/2, height/2 + (leaderBoardSpaceing * 2));
}//end printLeaderBoard()

void drawReadMe()
{
  float x = 100;
  float y = 100;
  
  float spaceing = 200;
  float textPadding = spaceing / 2;
  image(enemyImage, x, y);
  image(berzerkImage, x + spaceing,y);
  image(slowDownImage, x + (spaceing * 2),y);
  
  text("Enemy", x + textPadding, y);
  text("Health", x + spaceing + textPadding, y);
  text("SlowDown",  x + (spaceing * 2) + textPadding, y);
  
  text("Use the arrow keys to move your character!!", width/2, 400);
  text("Shoot enemies while avoiding the pipes!!", width/2, 450);
  b5.render();
  b5.drawText();
  b5.isClicked();
}//end drawReadme()

void drawCP5Buttons()
{
  cp5 = new ControlP5(this);
  cp5.setColorForeground(#FFFF00);
  cp5.setColorBackground(0);
  cp5.setColorActive(#FFFF00);
  cp5.addTextfield("name").setPosition(width/3 + 25, 150).setSize(100, 50).setAutoClear(false);


  cp5.addBang("submit").setPosition(width/2, 150).setSize(100, 50).setLabel("SUBMIT");

  cp5Called = true;
}//end drawCP5Buttons()

//Code for handling keys
void keyPressed()
{ 
  keys[keyCode] = true;
  if (key >= '0' && key <='9')
  {
    mode = key - '0';
  }
  //println(mode);

  //do if key == 'w', write to file
  if (key == 'w')
  {
    scoreScreen.writeToFile();//writes to default processing location, look into changing this!
    scoreScreen.wPressed();
  }
}
void keyReleased()
{
  keys[keyCode] = false;
}

boolean checkKey(int k)
{
  if (keys.length >= k) 
  {
    return keys[k] || keys[Character.toUpperCase(k)];
  }
  return false;
}