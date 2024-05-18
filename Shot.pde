class Shot {
  
  private PVector pos;
  private PVector dir;
  private float vel = 700f;
  
  Shot(PVector pos, PVector dir) {
    this.pos = pos;
    this.dir = dir;
  }
  
  boolean update(float et) {
    PVector m = PVector.mult(dir, vel * et);
    pos.add(m);
    return pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height;
  }
  
  void render() {
    circle(pos.x, pos.y, 5);
  }
  
  float getX()
  {
    return pos.x; 
  }
  float getY()
  {
     return pos.y; 
  }
}
