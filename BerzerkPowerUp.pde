class BerzerkPowerUp extends GameObject implements Powerup
{
  BerzerkPowerUp()
  {
  }
  
  void applyTo(Player p)
  {
      p.health += 200;
      
  }
  
  void applyToGameObjects(GameObject go)
  {
     //not sure if I will use this in this power up
      
  }
  
  void update()
  {
    
  }
  
  void render()
  {
    //draw a heart or heart sprite
  }
    
  
  
}