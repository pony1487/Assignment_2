class Bullet extends GameObject
{
  float theta;
  float size;
  float speed = 200;
  float timeToLive;
  float alive;
  
  Bullet(float x, float y, float theta, float size, float timeToLive)
  {
    pos = new PVector(x, y);
    forward = new PVector(0, 1);
    this.theta = theta;
    this.size = size;
    this.timeToLive = timeToLive;
  }
  
  void update()
  {
    forward.x = sin(theta);
    forward.y = - cos(theta);
    
    pos.add(PVector.mult(PVector.mult(forward, speed), timeDelta));
   
    println("Bullet x = " + pos.x);
    println("Bullet y = " + pos.y);
  }
  
  
  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    stroke(255);
    line(0, - size / 2, 0, size / 2);
    popMatrix();
  }
  
  
  
}