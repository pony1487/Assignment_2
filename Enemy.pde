class Enemy extends GameObject
{
  int health;
  float size;
  
  
  Enemy()
  {
    this.pos = new PVector(width/2, 100);
    this.size = 20;
  }
  
  void update()
  {
  }
  
  void render()
  {
    ellipse(pos.x,pos.y, size, size);
  }
  
}