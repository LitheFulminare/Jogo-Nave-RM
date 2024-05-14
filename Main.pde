float startTime = 0;

Ship ship = new Ship(new PVector(50, 384), new PVector(1, 0));
Enemy enemy = new Enemy(new PVector(50,50), new PVector(1,0));
Rock rock = new Rock(100,100,70);

ArrayList<Shot> shots = new ArrayList<>();

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

void update(float et) 
{
  enemy.updateDirection(ship);
  enemy.update(et);
  
  ship.update(et);
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
  for (Shot shot: shots) 
  {
    shot.render();
    
    
    // shot collision with rock
    if (shot.getX() >= rock.getX() && shot.getX() <= rock.getX()+rock.getL() && shot.getY() >= rock.getY() && shot.getY() <= rock.getY()+rock.getL())
      rock.destroy();
      
    // shot collision with enemy; 25 is the enemy's radius
    if (shot.getX() >= enemy.getX()-25 && shot.getX() <= enemy.getX()+25 && shot.getY() >= enemy.getY()-25 && shot.getY() <= enemy.getY()+25)
      enemy.destroy();
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
