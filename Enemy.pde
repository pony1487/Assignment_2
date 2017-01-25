class Enemy extends GameObject
{
  int health;
  float size;
  
  
  Enemy(float x, float y)
  {
    this.pos = new PVector(x, y);
    this.size = 20;
  }
  
  void update()
  {
     //make enemy fall
     pos.y = pos.y + 1;
     
     //remove enemy if it falls through floor
    if (pos.y > height)
    {
       gameObjects.remove(this);
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
         }
        
      }
    }//end for
  }
  
  void render()
  {
    ellipse(pos.x,pos.y, size, size);
  }
  
}