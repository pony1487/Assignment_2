class Player extends GameObject
{
  int size;
  float mass = 1;
  float power = 100;
  float jumpTime = 1.0;//mot used here, might be useful in future
  boolean isJumping;
  float theta;
  PShape shape;
  PImage sprite;
  int health;
  
  float fireRate = 2;
  float fireRatePerSec = 1.0 / fireRate;
  float timePassed;
  
  String name;
  
  int pointsScored = 0;//cant figure out how to get the enemy to let player know it has been hit. Used global in main
  float EffectTimePassed = 0;
  
  Player(String name)
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
    create();
    sprite = loadImage("player.png");//not working yet
    health = 100;
    this.name = name;
  
  }
  
  Player()
  {
     this.name = "Default"; 
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
  
  //bryans shape: temporary
  void create()
  {
    shape = createShape();
    shape.beginShape();
    shape.stroke(255);
    shape.noFill();
    shape.strokeWeight(2);
    shape.vertex(-(size/2), size/2);
    shape.vertex(0, - (size/2));
    shape.vertex((size/2), (size/2));
    shape.vertex(0, 0);
    shape.endShape(CLOSE);
  }
  
  void update()
  {
    forward.x = sin(theta);
    forward.y  = -cos(theta);
    
    if(checkKey(UP))
    {
      isJumping = true;
      
      pos.y = pos.y - 5;
      //theta = -1; //Not working
      
      //println("Pos.y = " + pos.y);
      //println("Vel.y = " +  velocity.y);
      
    }
 
   
    if(checkKey(LEFT))
    {
       velocity.x = velocity.x - 5;
       //theta = -1.5; //works when theta is not set to -1 when up is pressed
    }
 
    
    if(checkKey(RIGHT))
    {
       velocity.x = velocity.x + 5;
     
      // theta = 1.5; //works when theta is not set to -1 when up is pressed
       
    
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
       
       if(timePassed > fireRatePerSec)
       {
       PVector bp = PVector.add(pos, PVector.mult(forward, 40));
       Bullet b = new Bullet(bp.x, bp.y, theta, 20,2);
       //Bullet b = new Bullet(pos.x, pos.y, 0,20);
       gameObjects.add(b);
       timePassed = 0;
       }
     }
     
     //check if player hits terrain
     for(int i = 0; i < gameObjects.size();i++)
     {
       GameObject go = gameObjects.get(i);
       
       if(go instanceof Terrain)
       {
           
           Terrain temp = (Terrain)go;
           
           //println("T.x = " + temp.x);
           //println("T.y = " + temp.y);
          //println("PlayerX:" +  pos.x);
           
           
           if( ((pos.x + size/2) >= temp.x  && (pos.x - size/2) <= temp.x) && (pos.y + size) >= temp.y)
           {
               health--;
               //println("health:" + health);
           }
          
       }
     }//end check if player hits terrain
     
     //check if player hits enemies
     for(int i = 0; i < gameObjects.size();i++)
     {
       GameObject eo = gameObjects.get(i);
       
       if(eo instanceof Enemy)
       {
          Enemy temp_enemy = (Enemy)eo;
          //(pos.y + size) >= temp_enemy.pos.y && pos.y + size <= temp_enemy.pos.y) 
           if( ((pos.x + size/2) >= temp_enemy.pos.x && (pos.x - size/2) <= temp_enemy.pos.x) && ( (pos.y + size/2) >= temp_enemy.pos.y && (pos.y - size/2) <= temp_enemy.pos.y))
           {
               health--;
               //println("health:" + health);
           }
           
           
       }//end if Enemy
     
     }//end for
     
     //check if player hits powerup
      for(int i = 0; i < gameObjects.size();i++)
     {
       GameObject go = gameObjects.get(i);
       
       if(go instanceof BerzerkPowerUp)
       {
         BerzerkPowerUp temp_berzerk = (BerzerkPowerUp)go;
         if( ((pos.x + size/2) >= temp_berzerk.pos.x && (pos.x - size/2) <= temp_berzerk.pos.x) && ( (pos.y + size/2) >= temp_berzerk.pos.y && (pos.y - size/2) <= temp_berzerk.pos.y))
          {
               temp_berzerk.applyTo(this);
               //println("health:" + health);
          }
          
           
       }//end if Enemy
     
     }//end for
     
      //check if player hits Slow done powerup
      for(int i = 0; i < gameObjects.size();i++)
     {
       GameObject go = gameObjects.get(i);
       
       if(go instanceof SlowDownPowerUp)
       {
         SlowDownPowerUp temp_slow = (SlowDownPowerUp)go;
         if( ((pos.x + size/2) >= temp_slow.pos.x && (pos.x - size/2) <= temp_slow.pos.x) && ( (pos.y + size/2) >= temp_slow.pos.y && (pos.y - size/2) <= temp_slow.pos.y))
          {
               temp_slow.slowDown();
                   
               //println("health:" + health);
          }
          
           
       }//end if slowDown
     
     }//end for
     
     
     
     //increment time passed
     timePassed += timeDelta;
     //println(timePassed);
     
     
     //check for Death/GameOver
     if(health <= 0)
     {
        mode = 4; 
     }
   
  
  }//end update()
  
  void render()
  {
    text("Score: " + playerScore, 30,20);
    text("Name: " + name, 30,50);
    pushMatrix(); // Stores the current transform
    translate(pos.x, pos.y);
    text("Health" + health,50,-0);
    displayName();
   
    //rotate(theta);    
    // Use a PShape();
    shape(shape, 0, 0);
    //image(sprite,width/2, height/2); // Not working, fix it
    popMatrix(); // Restore the transform
  }
  
   //reset speed variables
  void resetSpeed()
  {
      enemySpeed = 1; //default is 1
      terrainSpeed = 3; //default is 3 
  }
  
  void applyGravity()
  {
    //couldnt get this working
    //velocity.add(gravity);
    pos.y = pos.y + 2;

    jumpTime = 1;
  }
  
  float getPlayerX()
  {
     return pos.x; 
  }
  
  void setPlayerName(String s)
  {
    this.name = s;
  }
  
  void displayName()
  {
     System.out.println("Player: " + name); 
  }
  
  String getPName()
  {
     return name; 
  }
  
  
  

  
}