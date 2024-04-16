// proporção da tela é 16x9, aumentar tamanho dos sprites em 5x  

float startTime = 0;
Ball ball = new Ball(100, 600, 150, 250, 200);
Platform p = new Platform(650, 450, 250, 30);

void setup() 
{
  size(1280, 720);
  startTime = millis();
}

void draw() 
{
  float elapsedTime = (millis() - startTime) / 1000f;
  startTime = millis();
  
  background(0);
  update(elapsedTime);
  render();
}

void update(float et) 
{
  ball.update(et);
  p.update(et);
  p.verifyCollision(ball);
}

void render() 
{
  ball.render();
  p.render();
}

void keyPressed() 
{
  if (keyCode == 32 || key == 'W' || key == 'w') //código da barra de espaço
  {
    ball.jump();
  }
  if (key == 'A' || key == 'a')
  {
    ball.jump();
  }
}
