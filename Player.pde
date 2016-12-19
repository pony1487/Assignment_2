class Player extends GameObject
{
  int size;
  
  Player()
  {
    size = 50;
    pos = new PVector(100, groundY - (size / 2));
  
  }
  
  
  void update()
  {
  }
  
  void render()
  {
      fill(255,0,0);
      ellipse(pos.x, pos.y,size, size);
  }
  
}