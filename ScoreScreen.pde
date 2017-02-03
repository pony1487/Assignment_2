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
    
    void writeToFile()
    {
      try {
        FileWriter output = new FileWriter(file, true);
        //output.write("\n");
        output.write(s + "\t");
        output.write(new Integer(playerScore).toString() + "\r\n");
        
        output.flush();
        output.close();
      }
       
      catch(IOException e) {
        println("ERROR: Could not write to file!!!");
        e.printStackTrace();
      }
      
    }
    
    void render()
    {
       background(0);
       fill(255,0,0);
       text("YOU DIED!! ", width/2, height/2);
       text(s + "!! You scored: " + playerScore, width/2 - 25, height/2 + 50);
       text("Press 'w' to write your score to leader board file",width/2 - 25, height/2 + 75);
       text("Press 'h' to return to the menu",width/2 - 25, height/2 + 85);
       
     

      
      
      
    }
    
    
  
  
}