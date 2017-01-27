abstract class GameObject
{
   PVector pos;
   PVector velocity;
   PVector force;
   PVector accel;
   PVector gravity;
   PVector forward;
   
   //float speed;
   
   
  GameObject()
  {
  }
   
  abstract void update();    
  abstract void render();
  
}