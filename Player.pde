class Player extends GameObject
{
  int size;
  PVector velocity;
  
  Player()
  {
    size = 50;
    pos = new PVector(100, groundY - (size / 2));
    velocity = new PVector(0.1,0.1);
  
  }
  
  
  void update()
  {
    if(checkKey(UP))
    {
        
    }
    
    if(checkKey(LEFT))
    {
       velocity.x = velocity.x + 0.1;
       pos.sub(velocity);
    }
    
    if(checkKey(RIGHT))
    {
       velocity.x = velocity.x + 0.1;
       pos.add(velocity);
       
    }
    
    //slow down
    velocity.mult(0.99f);
  }
  
  void render()
  {
      fill(255,0,0);
      ellipse(pos.x, pos.y,size, size);
  }
  

  
}