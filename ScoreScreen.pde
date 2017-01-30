class ScoreScreen //NOT game object
{
    String s;
    
    ScoreScreen()
    {
      
     
    }
    
    void update()
    {
       
    }
    
    void render()
    {
       background(0);
       fill(255,0,0);
       text("YOU DIED!!", width/2, height/2);
       text("You scored: " + playerScore, width/2, height/2 + 50);
       
     

      
      
      
    }
    
    
  
  
}