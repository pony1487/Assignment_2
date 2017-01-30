class Score//NOT game object
{
    int score;
    String name;
    
    
    Score(int score, String name)
    {
        this.score = score;
        this.name = name;
     
    }
    
    void update()
    {
    
    }
    
    void render()
    {
       text("Name: " + name,  100,100);
    }
 
    
    
  
  
}