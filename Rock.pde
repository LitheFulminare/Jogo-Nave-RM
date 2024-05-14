class Rock
{
   private float x;
   private float y;
  private float l;
   
   Rock(float x,float y,float l)
   {
     this.x = x;
     this.y = y;
     this.l = l;
   }
   
   void render()
   {
     square(x, y, l);
   }
}
