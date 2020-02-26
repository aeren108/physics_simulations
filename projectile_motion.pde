
class Entity {
  public PVector position;
  public PVector velocity;
  public PVector acc;
  public float radius;
  public float mass;
  
  public Entity(float radius) {
    position = new PVector(radius, height - radius);
    velocity = new PVector(1, -1);
    acc = new PVector(0, 0);
    this.radius = radius;
    mass = PI * radius * radius / 100;
  }
  
  public void update() {
    if (position.y - radius < height) {
      velocity.add(acc);
      position.add(velocity);
    }
  }
  
  public void draw() {
    stroke(255, 20, 120);
    circle(position.x, position.y - 1, radius * 2); 
  }
  
}

Entity e;
float gravityAcc = 9.8f;
float angle = 45;
boolean isLaunched = false;

void setup() {
   size(1280, 480, P2D);
   e = new Entity(20);
   frameRate(30);
}

void draw() {
  background(100);
  translate(width / 2 + e.position.x / 2, 0);
  
  e.draw();
  if (isLaunched) {
    e.update();
  } else {
    stroke(0, 255, 0);
    line(e.position.x, e.position.y, e.velocity.x + e.position.x, e.velocity.y + e.position.y);
  }
  
}

void keyPressed() {
  if (!isLaunched) {
    if (key == 'w' || key == 'W') {
      angle++;
      e.velocity.rotate(radians(-1));
    }
    else if (key == 's' || key == 'S') {
      angle--;
      e.velocity.rotate(radians(angle));
    }
    else if (key == ' ')
      launch();
      
    float magnitude = e.velocity.mag();
    if (key == '+')
      e.velocity.setMag(magnitude + 1);
    else if (key == '-')
      e.velocity.setMag(magnitude - 1);
  } else {
    if (key == 'R' || key == 'r')
      reset();
  }
}

void launch() {
  isLaunched = true;
  PVector gravity = new PVector(0, gravityAcc);
  e.acc.add(gravity);
}

void reset() {
  e.position.x = e.radius;
  e.position.y = height - e.radius;
  
  e.acc.x = 0; e.acc.y = 0;
  e.velocity.x = 1; e.velocity.y = -1;
  
  isLaunched = false;
}
