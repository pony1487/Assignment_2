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
    
  }
  
  void update()
  {
    forward.x = sin(theta);
    forward.y = - cos(theta);
    
    pos.add(PVector.mult(PVector.mult(forward, speed), timeDelta));
   
    //println("Bullet x = " + pos.x);
    //println("Bullet y = " + pos.y);
    
    
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
    spriteX = pos.x;
    spriteY = pos.y;
    image(sprite,spriteX,spriteY);
    pushMatrix();
    translate(pos.x, pos.y);
    
    
    rotate(theta);
    stroke(255);
    line(0, - size / 2, 0, size / 2);
    popMatrix();
    
  }
  
  
  
}