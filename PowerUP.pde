class PowerUP {
  private PVector pos;
  private boolean destroyed = false;
  
  PowerUP(PVector pos) {
    this.pos = pos; 
  }
  
  void render() {
    if (!destroyed) {
      // Renderiza o power-up na tela
      image(PowerUP, pos.x, pos.y);
    }
  }
  
  void destroy() {
    destroyed = true;
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
}
