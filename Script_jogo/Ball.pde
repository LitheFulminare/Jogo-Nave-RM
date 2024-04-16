class Ball {
  
  private float x;
  private float y;
  private float vel;
  private float h;
  private float d;
  private float dx;
  private float dy = 0;
  private boolean isJump = false;
  private int dir = 1;
  private int r = 25;
  private Platform p = null;
  
  Ball(float x, float y, float vel, float h, float d) {
    this.x = x;
    this.y = y;
    this.vel = vel;
    this.h = h;
    this.d = d;
  }
  
  void update(float et) {
    x += dir * vel * et;
    if (isJump) {
      dx += dir * vel * et;
      dy = calcDy(dx);
      if ((dx >= d/2 && dir == 1) || (dx <= -d/2 && dir == -1)) {
        isJump = false;
        dy = 0;
      }
    }
    else if (p != null) {
      if (x < p.getX() || x > p.getX() + p.getW()) {
        p = null;
        y = 600;
      }
    }
    if (x <= r || x >= width - r) dir = -dir;
  }
  
  void render() {
    circle(x, y - dy, r * 2);
  }
  
  void jump() {
    if (!isJump) {
      isJump = true;
      dx = dir * -d/2;
      p = null;
    }
  }
  
  void collision(Platform p) {
    isJump = false;
    dy = 0;
    y = p.getY() - r;
    this.p = p;
  }
  
  private float calcDy(float dx) {
    float dy = (-4 * h / pow(d, 2)) * pow(dx, 2) + h;
    return dy;
  }
  
  float getX() { return x; }
  float getY() { return y - dy; }
  int getR() { return r; }
  boolean down() { return isJump && (dir == 1 && dx > 0) || (dir == -1 && dx < 0); }
  //if (isJump) {
    //  //if (dir == 1 && dx > 0) 
    //  //  return true;
    //  //else if (dir == -1 && dx < 0)
    //  //  return true;
    //  //else
    //  //  return false;
    //  return (dir == 1 && dx > 0) || (dir == -1 && dx < 0);
    //}
    //else {
    //  return false;
    //}
}
