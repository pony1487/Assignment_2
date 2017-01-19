/*
  c15737505
  Object Oriented Programming
  Assignment 2

*/

//Gravity and other useful constants
final float GRAVITY = 5;
float timeDelta = 1.0f / 60.0f;

//ground variables
float groundX, groundY;
float groundHeight;

//ArrayLists
ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[1000];//this and check keys are bryans code

//background and floor images
PImage backgroundImage;
PImage groundImage;

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
    
}//end setup

void draw()
{
  
  
  //background(0);
  image(backgroundImage, 0,0);
  drawGameObjects();
  drawGround();
  
 
  
  
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
    
    gameObjects.add(p);
  
}//end initPlayer

void generateTerrain()
{
  
  
}

void keyPressed()
{ 
  keys[keyCode] = true;
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