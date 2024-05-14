class PowerUP
{
  private PVector pos;
  
  PowerUP(PVector pos)
  {
   this.pos = pos; 
  }
  
  void render()
  {
    circle(pos.x,pos.y,70);
  }
  
  PVector getPos()
  {
    return pos;
  }
}
