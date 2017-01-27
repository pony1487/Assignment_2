class Enemy extends GameObject
{
  int health;
  float size;
  //float speed;
  
  
  Enemy(float x, float y)
  {
    this.pos = new PVector(x, y);
    this.size = 20;
    //this.speed = 1;
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
         
         
         if( dist(b.pos.x, b.pos.y, this.pos.x, this.pos.y) < size/2 )
         {
             gameObjects.remove(this);
             //this is global. Is there a better way to do this so it updates variable of player object instead
             playerScore++;
             //how do access the points varaible in player without making it gloabl
             
         }
        
      }
    }//end for
  }
  
  void render()
  {
    fill(0);
    ellipse(pos.x,pos.y, size, size);
  }
  
}