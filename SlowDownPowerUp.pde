class SlowDownPowerUp extends GameObject implements Powerup
{
  int size;
  float timeToLive;
  float timeAlive;
  
  SlowDownPowerUp(float x, float y, int timeToLive)
  {
    this.pos = new PVector(x,y);
    this.timeToLive = timeToLive;
    this.size = 20;
  }
  
  
  void slowDown()
  {
     enemySpeed = 0.5; //default is 1
     terrainSpeed = 1; //default is 3 
  }
  
  //reset speed variables
  void resetSpeed()
  {
      enemySpeed = 1; //default is 1
      terrainSpeed = 3; //default is 3 
  }
  
  
  void applyTo(Player p)
  {
  }
  
  void applyToGameObjects(GameObject go)
  {
     //adjust speed of terrain scrolling and enemy fall speed
     //loop through gameObjects and do something if it is terrain, if it is enemy etc
     //go.speed = 0.5;
      
  }
  
  void update()
  {
      pos.y = pos.y + 1;
     
    //this code is used in 3 classes. Maybe see can it be moved into Gameobject class??
    //remove powerup if it falls through floor
    if (pos.y > height)
    {
       gameObjects.remove(this);
       
    }
    
    timeAlive += timeDelta;
    if(timeAlive > timeToLive)
    {
       gameObjects.remove(this); 
    }
    
  }
  
  void render()
  {
    fill(0,255,0);
    rect(pos.x,pos.y, size, size * 2);
      
  }
    
  
  
}