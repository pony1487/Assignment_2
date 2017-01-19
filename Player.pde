class Player extends GameObject
{
  int size;
  float mass = 1;
  float power = 100;
  float jumpTime = 1.0;//mot used here, might be useful in future
  boolean isJumping;
  float theta;
  
 
  
  
  Player()
  {
    size = 50;
    pos = new PVector(100, groundY - (size / 2));
    velocity = new PVector(0,0);
    force = new PVector(0,0);
    accel = new PVector(0,0);
    gravity = new PVector(0,GRAVITY);
    forward = new PVector(0,-1);
    isJumping = false;
    theta = 0;
  
  }
  
  /*
  // Newton's 2nd law: F = M * A
  // or A = F / M
  void applyForce(PVector force) {
    // Divide by mass 
    PVector f = PVector.div(force, mass);
    // Accumulate all forces in acceleration
    acceleration.add(f);
  }

  void update() {

    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // position changes by velocity
    position.add(velocity);
    // We must clear acceleration each frame
    acceleration.mult(0);
  }
  
  */
  
  void update()
  {
    forward.x = sin(theta);
    forward.y  = -cos(theta);
    
    if(checkKey(UP))
    {
      isJumping = true;
      
      pos.y = pos.y - 5;
      
      //println("Pos.y = " + pos.y);
      //println("Vel.y = " +  velocity.y);
      
    }
 
   
    if(checkKey(LEFT))
    {
       velocity.x = velocity.x - 5;
       theta -= 0.1f;
    }
    
    if(checkKey(RIGHT))
    {
       velocity.x = velocity.x + 5;
       theta += 0.1f;
    
    }
    
   
    accel = PVector.div(force, mass);// A = F / m
    velocity.add(PVector.mult(accel, timeDelta));// V = V + A * t
    pos.add(PVector.mult(velocity, timeDelta)); // Pos = Pos + A * t
   
    
    //slowdown
    velocity.mult(0.99f);
    
    
    if(isJumping)
    {
      applyGravity();
    }
    
    //check if player has hit the floor, reset their position on the ground
    if(pos.y > groundY - 25)
    {
        //println("HIT FLOOR");
        pos.y = groundY - 25;
        isJumping = false;
    }
    
    //hit roof
    if(pos.y < 0 )
    {
       pos.y = 0;
    }
    //hit left wall
    if(pos.x < 0 )
    {
       pos.x = 0;
    }
    //hit right wall
    
    if(pos.x > width )
    {
       pos.x = width;
    }
    
    //check for fire
     if(checkKey(' '))
     {
       //println("FIRE!");
       PVector bp = PVector.add(pos, PVector.mult(forward, 40));
       Bullet b = new Bullet(bp.x, bp.y, theta, 20, 5);
       gameObjects.add(b);
     }
  
    
    
  }
  
  void render()
  {
      fill(255,0,0);
      ellipse(pos.x, pos.y,size, size);
  }
  
  void applyGravity()
  {
    //couldnt get this working
    //velocity.add(gravity);
    pos.y = pos.y + 2;

    jumpTime = 1;
  }
  

  
}