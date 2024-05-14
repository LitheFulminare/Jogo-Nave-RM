float startTime = 0;

Ship ship = new Ship(new PVector(50, 384), new PVector(1, 0));

Enemy enemy = new Enemy(new PVector(50,50), new PVector(1,0));

Rock rock = new Rock(100,100,70);
Rock rock2 = new Rock(800,600,30);

PowerUP powerup = new PowerUP(new PVector(100,600));

ArrayList<Shot> shots = new ArrayList<>();

void setup() 
{
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

void update(float et) 
{
  //print(powerup.getPos().x);
  //print(powerup.getPos().y);
  ship.update(et);

  enemy.updateDirection(ship);
  enemy.update(et);
  
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
  //if shot
}

void render() 
{
  enemy.render();
  ship.render();
  rock.render();
  rock2.render();
  for (Shot shot: shots) 
  {
    shot.render();
    
    
    // shot collision with rock
    if (shot.getX() >= rock.getX() && shot.getX() <= rock.getX()+rock.getL() && shot.getY() >= rock.getY() && shot.getY() <= rock.getY()+rock.getL())
    {
      rock.destroy();
    }
      
    if (shot.getX() >= rock2.getX() && shot.getX() <= rock2.getX()+rock2.getL() && shot.getY() >= rock2.getY() && shot.getY() <= rock2.getY()+rock2.getL())
    {
      rock2.destroy();
    }
            
    // shot collision with enemy
    if (shot.getX() >= enemy.getX()-25 && shot.getX() <= enemy.getX()+25 && shot.getY() >= enemy.getY()-25 && shot.getY() <= enemy.getY()+25)
    {
      enemy.destroy();      
    }
      
  }
  // ship collision with powerup
  if (ship.getX() >= powerup.getX() - 35 && ship.getX() <= powerup.getX() + 35 && ship.getY() >= powerup.getY() - 35 && ship.getY() <= powerup.getY() + 35)
  {
    powerup.destroy(); 
    ship.powerup();
  }
}

void keyPressed() 
{
  ship.keyP(key, keyCode);
}

void keyReleased() 
{
  ship.keyR(key, keyCode);
}

void mousePressed() 
{
  shots.add(ship.shoot());
}
