class Platform {
  
  private float x;
  private float y;
  private float h;
  private float w;
  
  Platform(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
  }
  
  void update(float et) { 
    
  }
  
  void render() {
    rect(x, y, w, h);
  }
  
  void verifyCollision(Ball b) {
    if (b.down()) {
      if (b.getX() > x && b.getX() < x + w &&
          b.getY() + b.getR() > y && b.getY() + b.getR() < y + h) {
        b.collision(this);
      }
    }
  }
  
  float getX() { return x; }
  float getY() { return y; }
  float getW() { return w; }
}
