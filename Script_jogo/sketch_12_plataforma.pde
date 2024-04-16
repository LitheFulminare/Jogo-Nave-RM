float startTime = 0;
Ball ball = new Ball(100, 600, 150, 250, 200);
Platform p = new Platform(650, 450, 250, 30);

void setup() {
  size(1024, 768);
  startTime = millis();
}

void draw() {
  float elapsedTime = (millis() - startTime) / 1000f;
  startTime = millis();
  
  background(0);
  update(elapsedTime);
  render();
}

void update(float et) {
  ball.update(et);
  p.update(et);
  p.verifyCollision(ball);
}

void render() {
  ball.render();
  p.render();
}

void mousePressed() {
  ball.jump();
}
