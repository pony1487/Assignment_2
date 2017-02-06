class Terrain extends GameObject
{
  float x, y;
  //float speed;
  float w;
  float h;
  PImage tImage;
  
  Terrain()
  {
    w = 50;
    h = 50;
    this.x = width - 50;
    this.y = groundY - h;
    tImage = loadImage("marioPipes.png");
    
  }
  
  void update()
  {
      x = x - terrainSpeed;
      
      //move it back to the right if it goes off screen and randomise its height
    if (x < (-w))
    {
       x = width - 50;
       y = random(height / 2, height);
       h = groundY - y;
    }
    
    //image cant be resized if zero.
    if(w > 0 && h > 0)
    {
      tImage.resize((int)w,(int)h);
    }
  }
  
  void render()
  {
      fill(0);
      rect(x,y,w,h);
      image(tImage,x,y);
  }
  
}