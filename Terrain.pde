class Terrain extends GameObject
{
  float x, y;
  float scrollSpeed;
  float size;
  
  Terrain()
  {
    size = 50;
    this.x = width - 50;
    this.y = groundY - size;
    scrollSpeed = 2;
  }
  
  void update()
  {
      x = x - scrollSpeed;
      
      //move it back to the right if it goes off screen and randomise its height
    if (x < (-size))
    {
       x = width - 50;
       size = random(size, height / 4);
    }
  }
  
  void render()
  {
      fill(0);
      rect(x,y,size,size);
  }
  
}