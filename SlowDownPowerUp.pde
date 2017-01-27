class SlowDownPowerUp extends GameObject implements Powerup
{
  int size;
  float timeToLive;
  float timeAlive;
  
  SlowDownPowerUp(float x, float y, int timeToLive)
  {
    this.pos = new PVector(x,y);
    this.timeToLive = timeToLive;
  }
  
  
  void applyTo(Player p)
  {
  }
  
  void applyToGameObjects(GameObject go)
  {
     //adjust speed of terrain scrolling and enemy fall speed
     //loop through gameObjects and do something if it is terrain, if it is enemy etc
      
  }
  
  void update()
  {
    
  }
  
  void render()
  {
  }
    
  
  
}