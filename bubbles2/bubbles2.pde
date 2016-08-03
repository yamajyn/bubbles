int numBalls = 50;
float spring = 0.05;
float gravity = 0.0;
float friction = -0.9;
PVector dir = new PVector(0,0);
Ball[] balls = new Ball[numBalls];

int counter =0;
void setup() {
  size(640, 360);
  //smooth(8);
  
  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(random(width-100), random(height*2.5), random(20, 70), i, balls);
  }
  noStroke();
  
}

void draw() {
  background(20,40,100);
  dir.x = sin(PI*counter/30);
  dir.y = -sin(PI*counter/90);
  for (Ball ball : balls) {
    ball.collide();
    ball.move();
    ball.display();  
  }
  counter++;
}

class Ball {
  
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  Ball[] others;
 
  Ball(float xin, float yin, float din, int idin, Ball[] oin) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
  } 
  
  void collide() {
    for (int i = id + 1; i < numBalls; i++) {
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * spring;
        float ay = (targetY - others[i].y) * spring;
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
      }
    }   
  }
  
  void move() {
    vy += gravity;
    x += vx + dir.x;
    y += vy + dir.y*10;
    if (x + diameter/2 > width+20) {
      x = width - diameter/2+20;
      vx *= friction; 
    }
    else if (x - diameter/2 < -20) {
      x = diameter/2-20;
      vx *= friction;
    }
    if (y + diameter/2 > height*2) {
      y = height*2 - diameter/2;
      vy *= friction; 

    } 
    else if (y - diameter/2 < -height*2) {
      y = diameter/2-height*2;
      vy *= friction;
    }
  }
  
  void display() {
    
    noFill();
    for(int i = 10; i>0; i=i-2){
    stroke(255, i*10*(diameter)/50);
    ellipse(x, y, diameter+i-10, diameter+i-10);
    }
  }
}