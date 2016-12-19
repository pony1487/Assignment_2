/*
  c15737505
  Object Oriented Programming
  Assignment 2

*/

//ground variables
float groundX, groundY;
float groundHeight;

//ArrayLists
ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();

void setup()
{
    size(800,600);
    
    //set up ground
    groundHeight = 50;
    groundX = 0;
    groundY = height - groundHeight;
    
    //init stuff
    initPlayer();
    
}//end setup

void draw()
{
  
  
  //background(0);
  drawGameObjects();
  drawGround();
  
  
}//end draw

void drawGameObjects()
{
    for(int i = 0; i < gameObjects.size(); i++)
    {
       gameObjects.get(i).render(); 
    }
}//end drawGameObjects()

void drawGround()
{
    fill(0,225,0);
    noStroke();
    rect(groundX, groundY, width, groundHeight);
  
}//end drawGround

void initPlayer()
{
    Player p =  new Player();
    
    gameObjects.add(p);
  
}//end initPlayer