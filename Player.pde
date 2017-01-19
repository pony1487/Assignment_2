class Player extends GameObject
{
  int size;
  float mass = 1;
  float power = 100;
  float jumpTime = 1.0;
  boolean isJumping;
 
  
  
  Player()
  {
    size = 50;
    pos = new PVector(100, groundY - (size / 2));
    velocity = new PVector(0,0);
    force = new PVector(0,0);
    accel = new PVector(0,0);
    gravity = new PVector(0,GRAVITY);
    isJumping = false;
  
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
    
    /*
    if(checkKey(UP))
    {
      while(jumpTime > 0)
      {
        pos.y = pos.y - 5;
        jumpTime = jumpTime - 0.1;
      }

    }
    */
   // println("Pos.y = " + pos.y);
   // println("GroundY = " + groundY); 
    if(checkKey(UP))
    {
      isJumping = true;
      
      pos.y = pos.y - 5;
      
      println("Pos.y = " + pos.y);
      //println("Vel.y = " +  velocity.y);
      
    }
 
   
    if(checkKey(LEFT))
    {
       velocity.x = velocity.x - 5;
    }
    
    if(checkKey(RIGHT))
    {
       velocity.x = velocity.x + 5;
    
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
    
      if(pos.y > groundY - 25)
      {
          println("HIT FLOOR");
          pos.y = groundY - 25;
          isJumping = false;
      }
  
  
    
    
  }
  
  void render()
  {
      fill(255,0,0);
      ellipse(pos.x, pos.y,size, size);
  }
  
  void applyGravity()
  {
    //velocity.add(gravity);
    pos.y = pos.y + 2;
    println("Pos.y = " + pos.y);
    jumpTime = 1;
  }
  

  
}