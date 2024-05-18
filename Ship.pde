class Ship {
  PImage img;
  private PVector pos;
  private PVector dir;
  
  private int life = 3;
  
  private float vel = 350f;
  private float hitTime = 0;
  private float deathTime = 0;
  
  private boolean left = false;
  private boolean right = false;
  private boolean destroyed = false;
  private boolean invincible = false;
    
  Ship(PImage img, PVector pos, PVector dir)
  {
    this.img = img;
    this.pos = pos;
    this.dir = dir;
  }
  
  void update(float et) {
    if (left) dir.rotate(-PI * 1.5 * et);
    if (right) dir.rotate(PI * 1.5 * et);
    PVector m = PVector.mult(dir, vel * et);
    pos.add(m);
    
    
    // verifica se o timer de invencibilidade acabou
    if (hitTime + 2 * 1000 < millis()) 
    {
      invincible = false;
    }
    
    if (life == 0)
    {
      destroy();
    }
    
    if (deathTime + 1 * 1000 < millis() && destroyed) 
    {
      life = 3;
      destroyed = false;
      pos.x = 300;
      pos.y = 300;
    }
  }
  
  void render() 
  {
    if (!destroyed)
    {
      pushMatrix();
      translate(pos.x, pos.y);
      float angle = atan2(dir.y, dir.x) + PI / 2;
      rotate(angle);
      imageMode(CENTER);
      image(img, 0, 0);
      popMatrix();
    }
    
  }
  
  Shot shoot() {
    return new Shot(pos.copy(), dir.copy());
  }
  
  void keyP(int k, int kc) {
    if (k == CODED) {
      if (kc == LEFT) {
        left = true;
      } else if (kc == RIGHT) {
        right = true;
      }
    }
  }
  
  void powerup() 
  {
    life += 1;
  }
  
  void damage()
  {
    if (life > 0 && !invincible)
    {
      invincible = true;
      life -= 1;
      hitTime = millis(); // começa do timer de invencibilidade
    }
    
  }
  
  void destroy()
  {
    if (!destroyed)
    {
      destroyed = true; 
      deathTime = millis();
    }
  }
  
  void keyR(int k, int kc) {
    if (k == CODED) {
      if (kc == LEFT) {
        left = false;
      } else if (kc == RIGHT) {
        right = false;
      }
    }
  }
  
  PVector getPos() {
    return pos;
  }
  
  float getX() {
    return pos.x;
  }
  
  float getY() {
    return pos.y;
  }
  
  int getLife() {
    return life;
  }
}
