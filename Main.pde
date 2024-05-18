float startTime = 0;

int enemiesKilled = 0;

boolean powerupCollected = false;

String screen = "menu"; // pode ser "menu", "game" e "gameover" para saber qual tela deve renderizar

PImage img;
PImage shipImage;
PImage enemyImage;
PImage rockImage;
PImage rock2Image;
PImage PowerUP;
PImage fl_enemyImage;

Ship ship;
Enemy enemy;
Rock rock1;
Rock rock2;
PowerUP powerup;
FleeingEnemy fl_enemy;

ArrayList<Shot> shots = new ArrayList<>(); // player shots
ArrayList<Eshot> eshots = new ArrayList<>(); // enemy shots

void setup() {
  size(1024, 768); // Move a chamada de size() para fora do bloco try-catch

  try {
    img = loadImage("Menu.png");
    shipImage = loadImage("Nave Principal.png");
    enemyImage = loadImage("Nave inimiga.png");
    rockImage = loadImage("Asteroide Grande.png");
    rock2Image = loadImage("Asteroide pequeno.png");
    PowerUP = loadImage("Power-up.png");
    fl_enemyImage = loadImage("Nave Inimiga2.png");

    if (enemyImage == null) {
      println("Erro ao carregar a imagem do inimigo!");
    }

    ship = new Ship(shipImage, new PVector(50, 384), new PVector(1, 0));
    enemy = new Enemy(enemyImage, new PVector(50, 50), new PVector(1, 0));
    fl_enemy = new FleeingEnemy(fl_enemyImage, new PVector(500, 500), new PVector(1, 0));
    rock1 = new Rock(100, 100, 70, rockImage); 
    rock2 = new Rock(800, 600, 30, rock2Image);
    powerup = new PowerUP(new PVector(100, 600)); // Cria o power-up
    startTime = millis();
  } catch (Exception e) {
    println("Erro durante a inicialização:");
    e.printStackTrace();
  }
}

void draw() 
{
  float elapsedTime = (millis() - startTime) / 1000f;
  startTime = millis();
  
  background(0);
  imageMode(CORNER);  // Ensure the image is drawn from the top-left corner
  image(img, 0, 0, width, height);  
  
  update(elapsedTime);
  render();
}

void update(float et) 
{
  if (screen == "game")
  {
     print("enemies killed: " + enemiesKilled + "\n");
  
    ship.update(et);
    enemy.update(ship, et);
    fl_enemy.update(ship,et);
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
  
    Eshot eshotToRemove = null;
    print("Quantidade de tiros inimigos: " + eshots.size() + "\n");
    for (Eshot eshot: eshots) {
      if (eshot.update(et))
        eshotToRemove = eshot;
    }
    if (eshotToRemove != null) {
      eshots.remove(eshotToRemove);
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
 
}

void render() 
{
  
  if (screen == "game")
  {
    textSize(50);
    text("Life: " + ship.getLife(), 10, 45);
  
    enemy.render();
    fl_enemy.render();
    ship.render();
    rock1.render();
    rock2.render();
  
    for (Eshot eshot: eshots)
    {
      eshot.render();
    
      if (eshot.getX() >= ship.getX() - 25 && eshot.getX() <= ship.getX() + 25 && eshot.getY() >= ship.getY() - 25 && eshot.getY() <= ship.getY() + 25) {
        ship.damage();
      }
    }
  
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
  
  if (screen == "gameover")
  {
    textSize(50);
    text("Você matou " + enemiesKilled + " inimigo(s)", 250,500);
  }
  
}

void endGame()
{
  screen = "gameover";
  img = loadImage("tela de game over4.png");
}



void keyPressed() 
{
  if (screen == "game")
  {
    ship.keyP(key, keyCode);
  }
}

void keyReleased() 
{
  if (screen == "game")
  {
    ship.keyR(key, keyCode);
  }
}

void mousePressed() 
{
  if (screen == "menu")
  {
    screen = "game";
    img = loadImage("BG.png");
  }
  
  if (screen == "game")
  {
    shots.add(ship.shoot());
  }
}

void enemyShooting()
{
  if (screen == "game")
  {
    eshots.add(enemy.shoot());
  }
}
