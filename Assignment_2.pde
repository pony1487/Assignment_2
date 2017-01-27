/*
  c15737505
  Object Oriented Programming
  Assignment 2

*/

//Gravity and other useful constants
final float GRAVITY = 5;
float timeDelta = 1.0f / 60.0f;
float timePassedInMain = 0;


//spawn times
float enemySpawnRate = 2.0;
float enemySpawnTime = 1.0 / enemySpawnRate;

float bPowerupSpawnRate = 4.0;
float bPowerupSpawnTime = 1.0 / bPowerupSpawnRate;

//ground variables
float groundX, groundY;
float groundHeight;

//ArrayLists
ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[1000];//this and check keys are bryans code

//hashmap for player scores and name
HashMap<String,Integer> resultHM = new HashMap<String,Integer>();

//mode for each screen;
//1 = Game, 2 = Readme, 3 = Exit, 4 = Game Over
int mode;

//background and floor images
PImage backgroundImage;
PImage groundImage;

//Other varaibles
int playerScore;// trying to figure how to ecapsulate this in the player class. Cant get enemy object to let player object know it is hit
float enemyFallSpeed;//Is global so it can be accessed by slowDown powerup
float terrainScrollSpeed;


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
    
    //init stuff
    initPlayer();
    
    //start at menu
    mode = 0;
    //init fall speed for enemy
    enemyFallSpeed = 1;//original is 1
    terrainScrollSpeed = 3;//original is 3
    
}//end setup

void draw()
{
  
  switch(mode)
  {
    case 0:
         background(0);
         text("MENU", width/2, height/2);//to do
         break;
    case 1:
        //background(0);
        image(backgroundImage, 0,0);
        drawGameObjects();
        drawGround();
        timePassedInMain += timeDelta;//keep track of time in main
        
        //do stuff here to have enemy spawn at intervals
        println("Game Timer: " + timePassedInMain);
        if(enemySpawnTime > enemySpawnRate)
        {
          spawnEnemy();
          enemySpawnTime = 0;  
        }
        
        if(bPowerupSpawnTime > bPowerupSpawnRate )
        {
          spawnBerzerkPowerUp();
          bPowerupSpawnTime = 0;
        }
        
        //increment time between spawns
        enemySpawnTime += timeDelta;
        bPowerupSpawnTime += timeDelta;
        break;
    case 2:
        background(0);
        text("ReadME", width/2, height/2);//to do
        break;
    case 3:
        exit(); 
        break;
    case 4:
        fill(255,0,0);
        text("YOU DIED!!", width/2, height/2);
        break;
  

  }
  
 
  
  
}//end draw

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
    Player p =  new Player();
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
    //SlowDownPowerUp slowDown = new SlowDownPowerUp();
    //gameObjects.add(slowDown);
}


//Code for handling keys
void keyPressed()
{ 
  keys[keyCode] = true;
  if (key >= '0' && key <='9')
  {
    mode = key - '0';
  }
  println(mode);
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