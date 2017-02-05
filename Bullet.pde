class Bullet extends GameObject
{
  float theta;
  float size;
  float speed = 200;
  float alive;
  float timeToLive;
  PImage sprite;
  float spriteX, spriteY;
  
  Bullet(float x, float y, float theta, float size,float timeToLive)
  {
    pos = new PVector(x, y);
    forward = new PVector(0, 1);
    this.theta = theta;
    this.size = size;
    this.timeToLive = timeToLive;
    this.alive = 0;
    sprite = loadImage("bullet.png");
    sprite.resize(250,250);
    
  }
  
  void update()
  {
    forward.x = sin(theta);
    forward.y = - cos(theta);
    
    pos.add(PVector.mult(PVector.mult(forward, speed), timeDelta));
   
   
 

    
    //remove the bullets if they go offscreen
  if (pos.x > width)
    {
       gameObjects.remove(this);
    }
    if (pos.x < 0)
    {
       gameObjects.remove(this);
    }
    if (pos.y > height)
    {
       gameObjects.remove(this);
    }
    if (pos.y < 0)
    {
       gameObjects.remove(this);
    }
    
    //keep track of who long bullet lasts for
    alive += timeDelta;
    
    if(alive > timeToLive)
    {
       gameObjects.remove(this); 
    }
   

  
}

  void render()
  {
    
    pushMatrix();
    translate(pos.x, pos.y);
    
    
    rotate(theta);
    stroke(255);
    line(0, - size / 2, 0, size / 2);//original bullet
    
    //this slows the game
    //image(sprite,-115,-195);//this took trial and error to get the bullet sprite to fire from the player. I am not sure why it wouldnt work at 0,0
    
    popMatrix();
    
  }
  
 
     
  
  
  
  
}