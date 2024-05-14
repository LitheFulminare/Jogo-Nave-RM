class PowerUP
{
  private PVector pos;
  private boolean destroyed = false;
  
  PowerUP(PVector pos)
  {
   this.pos = pos; 
  }
  
  void render()
  {
    if (!destroyed)
    {
    circle(pos.x,pos.y,70);      
    }
  }
  
  void destroy()
  {
    destroyed = true;
  }
  
  PVector getPos()
  {
    return pos;
  }
}
