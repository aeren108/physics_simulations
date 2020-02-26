Projectile p;
float gravityAcc = 9.8f;
boolean isLaunched = false;
double angle = 0;
PVector xAxis = new PVector(1, 0);

void setup() {
   size(1280, 480, P2D);
   p = new Projectile(20);
   frameRate(8);
   
   angle = Math.round(degrees(PVector.angleBetween(p.velocity, xAxis)));
}

void draw() {
  background(100);
  
  p.draw();
  if (isLaunched) {
    p.update();
  } 
  
  stroke(0, 255, 0);
  line(p.position.x, p.position.y, p.velocity.x + p.position.x, p.velocity.y + p.position.y);
  stroke(0, 0, 255);
  line(p.position.x, p.position.y, p.velocity.x + p.position.x, p.position.y);
  stroke(255, 0, 0);
  line(p.position.x, p.position.y, p.position.x, p.velocity.y + p.position.y);
  
  fill(255, 0, 255);
  text("Angle: " + angle, p.position.x + 5, p.position.y - 5);
  
}

void keyPressed() {
  if (!isLaunched) {
    if ((key == 'w' || key == 'W') && angle < 90 && angle >= 0) {
      p.velocity.rotate(radians(-5));
      angle = Math.round(degrees(PVector.angleBetween(p.velocity, xAxis)));
    } else if ((key == 's' || key == 'S') && angle > 0 && angle <= 90) {
      p.velocity.rotate(radians(5));
      angle = Math.round(degrees(PVector.angleBetween(p.velocity, xAxis)));
    } else if (key == ' ')
      launch();
      
    float magnitude = p.velocity.mag();
    if (key == '+') {
      p.velocity.setMag(magnitude + 5);
    } else if (key == '-') {
      p.velocity.setMag(magnitude - 5);
    }
  } else {
    if (key == 'R' || key == 'r')
      reset();
  }
}

void launch() {
  isLaunched = true;
  PVector gravity = new PVector(0, gravityAcc);
  p.acc.add(gravity);
}

void reset() {
  p.position.x = p.radius;
  p.position.y = height - p.radius;
  
  p.acc.x = 0; p.acc.y = 0;
  p.velocity.x = 1; p.velocity.y = -1;
  
  isLaunched = false;
}

class Projectile {
  public PVector position;
  public PVector velocity;
  public PVector acc;
  public float radius;
  
  public Projectile(float radius) {
    position = new PVector(radius, height - radius);
    velocity = new PVector(1, -1);
    acc = new PVector(0, 0);
    this.radius = radius;
  }
  
  public void update() {
    if (position.y + radius - 1 < height) {
      velocity.add(acc);
      position.add(velocity);
    }
  }
  
  public void draw() {
    stroke(255, 20, 120);
    fill(255);
    circle(position.x, position.y, radius * 2); 
  }
  
}
