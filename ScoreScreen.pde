class ScoreScreen //NOT game object
{
    String s;
    
    ScoreScreen()
    {
      
     
    }
    
    void update()
    {
        for(int i = 0; i < gameObjects.size(); i++)
        {
           GameObject go = gameObjects.get(i);
           
           if(go instanceof Player)
           {  
               Player p = (Player)go;
               s = p.getPName();
           }
        }
    }
    
    void render()
    {
       background(0);
       fill(255,0,0);
       text("YOU DIED!! ", width/2, height/2);
       text(s + "!! You scored: " + playerScore, width/2 - 50, height/2 + 50);
       
     

      
      
      
    }
    
    
  
  
}