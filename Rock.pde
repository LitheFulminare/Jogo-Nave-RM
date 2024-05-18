class Rock {
  private float x;
  private float y;
  private float l;
  private boolean destroyed = false;
  private PImage image;
   
  Rock(float x,float y,float l, PImage image) {
    this.x = x;
    this.y = y;
    this.l = l;
    this.image = image;
  }
   
  void render() {
    if (!destroyed) {
      image(image, x, y);
    }
  }
   
  void destroy() {
    destroyed = true;
  }
   
  float getX() {
    return x;
  }
  
  float getY() {
    return y;
  }
  
  float getL() {
    return l;
  }
}
