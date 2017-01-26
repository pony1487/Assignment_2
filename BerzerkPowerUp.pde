class BerzerkPowerUp extends GameObject implements Powerup
{
  int size;
  float timeToLive;
  float timeAlive;
  
  BerzerkPowerUp(float x, float y,float timeToLive)
  {
    this.size = 20;
    this.pos = new PVector(x,y);
    this.timeToLive = timeToLive;
    this.timeAlive = 0;
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

  }
  
  void render()
  {
    //draw a heart or heart sprite
    fill(255,0,0);
    rect(pos.x,pos.y, size, size);
  }
    
  
  
}