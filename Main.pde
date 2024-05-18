float startTime = 0;
boolean powerupCollected = false;
PImage img;
PImage shipImage;
PImage enemyImage;
PImage rockImage;
PImage rock2Image;
PImage PowerUP;

Ship ship;
Enemy enemy;
Rock rock1;
Rock rock2;
PowerUP powerup;

ArrayList<Shot> shots = new ArrayList<>();

void setup() {
  size(1024, 768); // Move a chamada de size() para fora do bloco try-catch

  try {
    img = loadImage("BG.png");
    shipImage = loadImage("Nave Principal.png");
    enemyImage = loadImage("Nave inimiga.png");
    rockImage = loadImage("Asteroide Grande.png");
    rock2Image = loadImage("Asteroide pequeno.png");
    PowerUP = loadImage("Power-up.png");

    if (enemyImage == null) {
      println("Erro ao carregar a imagem do inimigo!");
    }

    ship = new Ship(shipImage, new PVector(50, 384), new PVector(1, 0));
    enemy = new Enemy(enemyImage, new PVector(50, 50), new PVector(1, 0));
    rock1 = new Rock(100, 100, 70, rockImage);
    rock2 = new Rock(800, 600, 30, rock2Image);
    powerup = new PowerUP(new PVector(100, 600)); // Cria o power-up
    startTime = millis();
  } catch (Exception e) {
    println("Erro durante a inicialização:");
    e.printStackTrace();
  }
}

void draw() {
  float elapsedTime = (millis() - startTime) / 1000f;
  startTime = millis();
  
  background(0);
  imageMode(CORNER);  // Ensure the image is drawn from the top-left corner
  image(img, 0, 0, width, height);  
  
  update(elapsedTime);
  render();
}

void update(float et) {
  ship.update(et);
  enemy.update(ship, et);
  powerup.render();
  
  Shot shotToRemove = null;
  print("Quantidade de tiros: " + shots.size() + "\n");
  for (Shot shot: shots) {
    if (shot.update(et))
      shotToRemove = shot;
  }
  if (shotToRemove != null) {
    shots.remove(shotToRemove);
  }
  
  // Detecção de colisão com o power-up
  if (ship.getX() >= powerup.getX() - 35 && ship.getX() <= powerup.getX() + 35 && ship.getY() >= powerup.getY() - 35 && ship.getY() <= powerup.getY() + 35) {
    if (!powerupCollected) {
      powerupCollected = true;
      powerup.destroy(); // Destrua o power-up após coletá-lo
      ship.powerup(); // Realize a lógica de power-up aqui
    }
  }
}

void render() {
  textSize(50);
  text("Life: " + ship.getLife(), 10, 45);
  
  enemy.render();
  ship.render();
  rock1.render();
  rock2.render();
  
  for (Shot shot: shots) {
    shot.render();
    
    // Detecção de colisão com os asteroides
    if (shot.getX() >= rock1.getX() && shot.getX() <= rock1.getX() + rock1.getL() && shot.getY() >= rock1.getY() && shot.getY() <= rock1.getY() + rock1.getL()) {
      rock1.destroy();
    }
    
    if (shot.getX() >= rock2.getX() && shot.getX() <= rock2.getX() + rock2.getL() && shot.getY() >= rock2.getY() && shot.getY() <= rock2.getY() + rock2.getL()) {
      rock2.destroy();
    }
    
    // Detecção de colisão com o inimigo
    if (shot.getX() >= enemy.getX() - 25 && shot.getX() <= enemy.getX() + 25 && shot.getY() >= enemy.getY() - 25 && shot.getY() <= enemy.getY() + 25) {
      enemy.destroy();
    }
  }
}

void keyPressed() {
  ship.keyP(key, keyCode);
}

void keyReleased() {
  ship.keyR(key, keyCode);
}

void mousePressed() {
  shots.add(ship.shoot());
}
