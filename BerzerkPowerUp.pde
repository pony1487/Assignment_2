class BerzerkPowerUp extends GameObject implements Powerup
{
  int size;
  float timeToLive;
  float timeAlive;
  PImage heart;
  
  BerzerkPowerUp(float x, float y,float timeToLive)
  {
    this.size = 20;
    this.pos = new PVector(x,y);
    this.timeToLive = timeToLive;
    this.timeAlive = 0;
    heart = loadImage("heart.png");
    heart.resize(size,size);
  }
  
  void applyTo(Player p)
  {
      p.health = 200;
      
  }
  
  void applyToGameObjects(GameObject go)
  {
     //not sure if I will use this in this power up
      
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
    //draw a heart or heart sprite
    fill(255,0,0);
    //rect(pos.x,pos.y, size, size);
    image(heart,pos.x,pos.y);
  }
    
  
  
}