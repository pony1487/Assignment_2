class SlowDownPowerUp extends GameObject implements Powerup
{
  int size;
  float timeToLive;
  float timeAlive;
  
  float effectTime = 0;
  float effectDuration = 1.0/ 0.25;
  
  PImage beer;
  
  SlowDownPowerUp(float x, float y, int timeToLive)
  {
    this.pos = new PVector(x,y);
    this.timeToLive = timeToLive;
    this.size = 50;
    
    beer = loadImage("beer.png");
    beer.resize(size,size);
   ;
  }
  
  
  void slowDown()
  {
    
     enemySpeed = 0.20; //default is 1
     terrainSpeed = 0.70; //default is 3
     //start slow audio
     slowMusic.play();
     music.pause();
    
    
     
  }
  
  public void resetSpeed()
  {
    
    enemySpeed = 1;//default is 1
    terrainSpeed = 3; //default is 3
    //stop slow audio
    
    
    slowMusic.pause();
    slowMusic.rewind();
    //start normal audio??
    music.play();
    
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
    effectTime += timeDelta;
    if(timeAlive > timeToLive)
    {
       gameObjects.remove(this); 
    }
    
    if(effectTime > effectDuration)
    {
       resetSpeed(); 
       effectTime = 0;
    }
    
    //see if power up hits player then remove it
    for(int i = 0; i < gameObjects.size();i++)
    {
       GameObject go = gameObjects.get(i);
       
       if( go instanceof Player)
       {
          Player temp = (Player)go;
          
          if( ((pos.x + size) >= temp.pos.x  && (pos.x - size) <= temp.pos.x) && (pos.y + size) >= temp.pos.y)
          {
            gameObjects.remove(this);
          }
       }
    }
    
  }
  
  void render()
  {
    fill(0,255,0);
    //rect(pos.x,pos.y, size, size * 2);
    image(beer, pos.x,pos.y);
      
  }
    
  
  
}