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
  }
  
  void render()
  {
    ellipse(pos.x,pos.y, size, size);
  }
  
}