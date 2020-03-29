float g = 9.8f;
float ropeLength = 500;
float radius = 20;

float angle = PI / 4;
float angularVelocity = 0;
float angularAcc = 0;

PVector pos;
PVector rope;
void setup() {
  size(1000, 800, P2D);
  frameRate(20);

  rope = new PVector(width / 2, 80);
  pos = new PVector(rope.x + ropeLength * (float)sin(angle), rope.y + ropeLength * (float)cos(angle));
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
  //T (torque) = I(moment of inertia) * a(angular acceleration);
  //mg * sin(angle) = mr^2 * a;
  //a = (g / r) * sin(angle);
  angularAcc = - g / ropeLength * sin(angle);
  
  angularVelocity += angularAcc;
  angle += angularVelocity;
  
  pos.x = rope.x + ropeLength * (float)sin(angle);
  pos.y = rope.y + ropeLength * (float)cos(angle);
}
