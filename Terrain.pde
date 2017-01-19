class Terrain extends GameObject
{
  float x, y;
  float scrollSpeed;
  float w;
  float h;
  
  Terrain()
  {
    w = 50;
    h = 50;
    this.x = width - 50;
    this.y = groundY - h;
    scrollSpeed = 1;
  }
  
  void update()
  {
      x = x - scrollSpeed;
      
      //move it back to the right if it goes off screen and randomise its height
    if (x < (-w))
    {
       x = width - 50;
       y = random(height / 2, height);
       h = groundY - y;
    }
  }
  
  void render()
  {
      fill(0);
      rect(x,y,w,h);
  }
  
}