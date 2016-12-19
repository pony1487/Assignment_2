abstract class GameObject
{
   PVector pos;
   
  GameObject()
  {
  }
   
  abstract void update();    
  abstract void render();
  
}