class Enemy extends GameObject
{
  int health;
  float size;
  //float speed;
  float soundTimePassed;
  float soundDuration = 1.0;
  boolean isDead;
  PImage enemyDie;
  
  
  Enemy(float x, float y)
  {
    this.pos = new PVector(x, y);
    this.size = 20;
    //this.speed = 1;
    enemyDie = loadImage("ememyExplosion.png");
    this.isDead = false;
  }
  
  void update()
  {
     //make enemy fall
     pos.y = pos.y + enemySpeed;
     
     //remove enemy if it falls through floor
    if (pos.y > height)
    {
       gameObjects.remove(this);
       
       //make game too hard
       /*
       if(playerScore > 0)
       {
         playerScore--;//might note use this gameplay
       }
       */
    }
    
    //check if players bullets hit enemies and remove them and add to player score
    for(int i = 0; i < gameObjects.size();i++)
    {
      GameObject go = gameObjects.get(i);
    
     
      
      if(go instanceof Bullet)
      {
         Bullet b = (Bullet)go;
         
         
         if( dist(b.pos.x, b.pos.y, this.pos.x, this.pos.y) < size )
         {
             this.isDead = true;
              
             gameObjects.remove(this);
             //image(enemyDie, this.pos.x - 50,this.pos.y);//This should be in render
             
             enemyExplosion.play();
             //this is global. Is there a better way to do this so it updates variable of player object instead
             playerScore++;
             //how do access the points varaible in player without making it gloabl
             
         }
        
      }
    }//end for
    
     soundTimePassed += timeDelta;//used to reset the sounds
         //rest Enemy getting hit sound
     if(soundTimePassed > soundDuration)
     {  
       enemyExplosion.rewind();
       enemyExplosion.pause();
        
        soundTimePassed = 0; 
     } 
     
     //this works here but should be in render() i think
     if(isDead)
    {
        image(enemyDie, this.pos.x - 50,this.pos.y); 
      
    }
  }
  
  void render()
  {
    fill(0);
    ellipse(pos.x,pos.y, size, size);
    
    
    //This does not work here???
    if(isDead)
    {
        //image(enemyDie, 0,0); 
        println("Is dead");
      
    }
    
  }
  
}