abstract class GameObject
{
   PVector pos;
   PVector velocity;
   PVector force;
   PVector accel;
   PVector gravity;
   
  GameObject()
  {
  }
   
  abstract void update();    
  abstract void render();
  
}