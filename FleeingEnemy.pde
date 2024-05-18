class FleeingEnemy {
  PImage img;
  
  private PVector pos;
  private PVector dir;
  
  private float vel = 200f; // Velocidade da nave inimiga
  
  private boolean destroyed = false;
  private boolean outOfBounds = false;
  
  private int timer = millis();
  private int deathTime = 0;
  //private int shootTime = 0;
  
  FleeingEnemy(PImage img, PVector pos, PVector dir) 
  {
    this.img = img;
    this.pos = pos;
    this.dir = dir;
  }
  
  
  
  void update(Ship ship, float et) {
    follow(ship); // Atualiza a direção da nave inimiga em relação à nave principal
    move(et); // Move a nave inimiga
    // O restante do código permanece o mesmo...
    
    if (pos.x > width || pos.x < -35 || pos.y > height || pos.y < - 35)
    {
      outOfBounds = true;
      destroy(); 
    }
    
    //if (millis() - timer >= 250)
    //{ 
      //if (!destroyed)
      //{
        //enemyShooting();
        //timer = millis();
      //}  
    //}
  }
  
  Eshot shoot() 
  {
    return new Eshot(pos.copy(), dir.copy());
  }
  
  void move(float et) {
    // Move a nave inimiga com base na sua direção e velocidade
    PVector m = PVector.mult(dir, vel * et);
    pos.add(m);
    
    // Verifica se a nave inimiga está destruída
    if (deathTime + 2 * 1000 < millis() && destroyed) {
      pos.x = 50;
      pos.y = 50;
      destroyed = false;
    }
  }
  
  void follow(Ship ship) {
    // Calcula o vetor direção entre a posição da nave inimiga e a posição da nave principal
    PVector directionToShip = PVector.sub(ship.getPos(), pos);
  
    // Normaliza o vetor direção
    dir = directionToShip.normalize();
  }
  
  void render() {
    if (!destroyed) {
      image(img, pos.x, pos.y); // Renderiza a imagem da nave inimiga
    } 
  }
  
  // Atualiza a direção da nave inimiga para apontar para a posição da nave principal
  void updateDirection(Ship ship) {
    // Calcula o vetor direção entre a posição da nave inimiga e a posição da nave principal
    PVector directionToShip = PVector.sub(ship.getPos(), pos);
  
    // Normaliza o vetor direção
    dir = directionToShip.normalize();
  }
  
  void destroy() 
  { 
    if (!destroyed)
    {
      destroyed = true; 
      deathTime = millis();
      if (!outOfBounds)
      {
        enemiesKilled += 1;
      }
    }
    outOfBounds = false;   
  }
  
  float getX() {
    return pos.x; 
  }
  
  float getY() {
    return pos.y; 
  }
}
