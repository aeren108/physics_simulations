float gravityAcc = 9.8f;
float mass = 5;
float ropeLength = 500; //centimeters
float radius = 20;
float period;
float angularVelocity;
float elongation; //distance from the center
float angle = 45;

PVector acc;
PVector pos;
PVector rope;
PVector velocity;

void setup() {
  size(600, 800, P2D);
  frameRate(20);
  
  period = TWO_PI * (float)Math.sqrt((ropeLength / 1000) / gravityAcc);
  angularVelocity = TWO_PI / period;
  
  velocity = new PVector(0, 0);
  acc = new PVector(0, 0);
  rope = new PVector(width / 2, 80);
  pos = new PVector(rope.x + ropeLength * (float)Math.sin(angle), rope.y + ropeLength * (float)Math.cos(angle));
}

void draw() {
  background(100);
  
  stroke(255);
  line(rope.x, rope.y, pos.x, pos.y);
  stroke(0, 255, 0);
  circle(pos.x, pos.y, radius);
  
  update();
}

void update() {
  setAcc();
  velocity.add(acc);
  pos.add(velocity);
  
  PVector len = new PVector(pos.x - rope.x, pos.y - rope.y);
  if (len.mag() > ropeLength)
    len.setMag(ropeLength);
    
  pos.x = len.x + rope.x;
  pos.y = len.y + rope.y;
}

void setAcc() {
  PVector t = new PVector(-pos.x + rope.x, pos.y - rope.y);
  PVector g = new PVector(0, gravityAcc);
  //T = m*v^2 / r;

  t.setMag(-1*velocity.mag() * velocity.mag() / ropeLength / 1000);
  acc.x = 0; acc.y = 0;
  acc.add(t);
  acc.add(g);
}
