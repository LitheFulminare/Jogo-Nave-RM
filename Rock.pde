class Rock
{
   private float x;
   private float y;
   private float l;
   private boolean destroyed = false;
   
   Rock(float x,float y,float l)
   {
     this.x = x;
     this.y = y;
     this.l = l;
   }
   
   void render()
   {
     if (!destroyed)
     {
       square(x, y, l);      
     }
   }
   
   void destroy()
   {
     destroyed = true;
   }
   
   float getX()
   {
     return x;
   }
   float getY()
   {
     return y;
   }
   float getL()
   {
     return l;
   }
}
