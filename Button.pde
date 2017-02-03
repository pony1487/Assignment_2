class Button
{
     float w,h;
     float x,y;
     color c;
     String text;
     Boolean mouseOverButton;
     
     Button(float w, float h, float x, float y, String text)
     {
         this.w = w;
         this.h = h;
         this.x = x;
         this.y = y;
         this.text = text;
         this.c = color(247, 197, 0);

     }
     
     void render()
     {
       stroke(c);
       noFill();
       rect(x,y,w,h);
       
     }
     
     void drawText()
     {
         textAlign(CENTER);
      
         text(text, x + w/2, y + h / 2);
     }
     
   
     
     void isClicked()
     {
      
      if( (mouseX > x) && (mouseX < x  + w) && (mouseY > y) && (mouseY < y + h) )
      {
          mouseOverButton = true;
          
          if(mousePressed)
          {
            if(text == "Play")
            {
               mode = 1; 
            }
            if(text == "Readme")
            {
                mode = 2;
            }
            
            if(text == "LeaderBoard")
            {
                mode = 5;
            }
            
            if(text == "Exit")
            {
                mode = 3;
            }
          }//end if
         
          
      }
      else
      {
         mouseOverButton = false; 
      }
  
     }
}