/*
  c15737505
  Object Oriented Programming
  Assignment 2

*/
//used for text input on screen
import controlP5.*;
ControlP5 cp5;

//used to store players score and name
import java.io.FileWriter;
File file;
Table table;

//Gravity and other useful constants
final float GRAVITY = 5;
float timeDelta = 1.0f / 60.0f;
float timePassedInMain = 0;

//buttons for menu
Button b1;
Button b2;
Button b3;
Button b4;


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


//mode for each screen;
//1 = Game, 2 = Readme, 3 = Exit, 4 = Game Over, 5 = leaderboard
int mode;

//background and floor images
PImage backgroundImage;
PImage groundImage;

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

void setup()
{
    size(800,600);
    
    //set up ground
    groundHeight = 50;
    groundX = 0;
    groundY = height - groundHeight;
    
    //set up background and floor
    backgroundImage = loadImage("skybackground.jpg");
    backgroundImage.resize(width, height);
    
    groundImage = loadImage("ground.png");
    groundImage.resize(width,100);
    
    t = new Terrain();
    gameObjects.add(t);
    
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
    cp5 = new ControlP5(this);
    cp5.setColorForeground(#FFFF00);
    cp5.setColorBackground(0);
    cp5.setColorActive(#FFFF00);

    cp5.addTextfield("name").setPosition(width/3 + 25, 150).setSize(100, 50).setAutoClear(false);

    cp5.addBang("submit").setPosition(width/2, 150).setSize(100, 50).setLabel("SUBMIT");
    
    //init buttons
    initButtons();
    
    //init table to read scores
    table = loadTable("scores.tsv","header");
    
    
   
 
    
}//end setup

void draw()
{
  
  switch(mode)
  {
    case 0:
         background(0);
         //text("IGN 10/10", width/2 - 50, height/2);//to do
         drawMenu();
         break;
    case 1:
        //background(0);
        //remove name box
        cp5.remove("name");
        cp5.remove("submit");
       
        
        image(backgroundImage, 0,0);
        drawGameObjects();
        drawGround();
        timePassedInMain += timeDelta;//keep track of time in main
        
        //do stuff here to have enemy spawn at intervals
        //println("Game Timer: " + timePassedInMain);
        //println("Speed: " + enemySpeed);
        if(enemySpawnTime > enemySpawnRate)
        {
          spawnEnemy();
          enemySpawnTime = 0;  //reset time
        }
        
        if(bPowerupSpawnTime > bPowerupSpawnRate )
        {
          spawnBerzerkPowerUp();
          bPowerupSpawnTime = 0;
        }
        
        if(sPowerUpSpawnTime > sPowerUpSpawnRate )
        {
          spawnSlowDownPowerUp();
          sPowerUpSpawnTime = 0;
        }
        
        //increment time between spawns
        enemySpawnTime += timeDelta;
        bPowerupSpawnTime += timeDelta;
        sPowerUpSpawnTime += timeDelta;
        break;
    case 2:
        background(0);
        cp5.remove("name");
        cp5.remove("submit");
        text("ReadME", width/2, height/2);//to do
        break;
    case 3:
        
        exit(); 
        break;
    case 4:
        cp5.remove("name");
        cp5.remove("submit");
        drawScoreScreen();
        //scoreScreen.writeToFile();
        break;
        
    case 5:
      background(0);
      cp5.remove("name");
        cp5.remove("submit");
      //text("Leaderboard", width/2, height/2);
      printLeaderBoard();
      break;
        
        
        
        
  

  }
  
 
  
  
}//end draw
 

void submit()
{
    userName=cp5.get(Textfield.class, "name").getText();
    
    //error checking is not working here.FIX
    if(userName == " ")
    {
       println("Error: please provide name");
       mode = 0;
    }
    else
    {
    initPlayer();
    mode = 1;
    }
    
}

void drawGameObjects()
{
    for(int i = 0; i < gameObjects.size(); i++)
    {
       gameObjects.get(i).render(); 
       gameObjects.get(i).update(); 
       
    }
}//end drawGameObjects()

void drawGround()
{
    fill(0,225,0);
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
  
    //not used, maybe use it to clean up code or do something interesting
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
    BerzerkPowerUp bezerk = new BerzerkPowerUp(random(0,width),0,4);
    gameObjects.add(bezerk);
}

void spawnSlowDownPowerUp()
{
    SlowDownPowerUp slowDown = new SlowDownPowerUp(random(0,width),0,4);
    gameObjects.add(slowDown);
}

//game over screen
void drawScoreScreen()
{
    scoreScreen.update();
    scoreScreen.render();
    
}//end drawGameOver


void initButtons()
{
    float buttonWidth = 100;
    float buttonHeight  = 50;
    float buttonSpacing = 100;
    
    
  
    float buttonX = width / 2 - (buttonWidth / 2);
    float buttonY = height / 4;
    
    b1 = new Button(buttonWidth, buttonHeight,buttonX, buttonY, "Play");
    b2 = new Button(buttonWidth, buttonHeight,buttonX, buttonY + buttonSpacing, "Readme");
    b3 = new Button(buttonWidth, buttonHeight,buttonX, buttonY + (buttonSpacing * 2), "LeaderBoard");
    b4 = new Button(buttonWidth, buttonHeight,buttonX, buttonY + (buttonSpacing * 3), "Exit");
  
}//end initButtons()

void drawMenu()
{
   //b1.render();
   //b1.drawText();
   
   b2.render();
   b2.drawText();
   b2.isClicked();
   
   
   b3.render();
   b3.drawText();
   b3.isClicked();
   
   b4.render();
   b4.drawText();
   b4.isClicked();
}//edn drawMenu()


//wont work if file is empty!!!
void printLeaderBoard()
{
    float leaderBoardSpaceing = 100;
    String[] scores = loadStrings("scores.tsv");
    //top 3 scores kept
    
    //store top 3 scoresto be written to screen
    String first, second, third;
    first = scores[0];
    second = scores[1];
    third = scores[2];
    
    //display entire score board in console
    for(int i = 0; i < scores.length; i++)
    {
       System.out.println(i + 1 + ") " + scores[i]); 
    }
    
  
      text(first, width/2, height/2);
      text(second, width/2, height/2 + leaderBoardSpaceing);
      text(third, width/2,  height/2 + (leaderBoardSpaceing * 2));
    
    
    

    
  
}//end printLeaderBoard()

//Code for handling keys
void keyPressed()
{ 
  keys[keyCode] = true;
  if (key >= '0' && key <='9')
  {
    mode = key - '0';
  }
  println(mode);
  
  //do if key == 'w', write to file
  if(key == 'w')
  {
      scoreScreen.writeToFile();//writes to default processing location, look into changing this!
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