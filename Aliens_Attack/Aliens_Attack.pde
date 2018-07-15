PImage enemy;
Hero player;
ArrayList<Bolt> lasers = new ArrayList<Bolt>();
ArrayList<Bolt> enemylasers = new ArrayList<Bolt>();
ArrayList<Nemesis> enemies = new ArrayList<Nemesis>();
boolean gameover = false;
int score = 0, time = 0, step;

// Minim Libraries
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

// Minim objects
Minim minim;
AudioOutput out;


void setup() {

  player = new Hero();
  enemy = loadImage("http://orig00.deviantart.net/52f3/f/2015/208/d/6/d68f432f406cb5889abefbf4269a8dc9-d92ziiw.png");
  step = 20;
  minim = new Minim(this);

  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();

  size(500, 400);
  //noCursor();
}


void draw() {
  background(255);


  player.display();

  // increase number of enemies as the game progresses
  if (frameCount%100==0) step--;
  if (step<4) step = 4;
  if (frameCount%step==0) {
    enemies.add(new Nemesis(random(0, width), 0, random(1, 2)));
  }

  // have enemy ships fire lasers
  if (frameCount%step==0) {
    int i = int(random(0, enemies.size()-1));
    enemylasers.add(new Bolt(enemies.get(i).x+15, enemies.get(i).y, enemies.get(i).v*3, 0., color(0, 20, 20)));
  }

  // add a new death blossom every 15 seconds
  if (frameCount%900==0) player.numDeathBlossoms++;


  // loop through the enemy ships  
  for (Nemesis n : enemies) {

    // check if any of the good laser bolts have hit an enemy ship
    for (Bolt b : lasers) {
      if (n.checkCollision(b.x, b.y) == true) score++;
    }

    // check if an enemy has collided with the good ship
    if (n.checkCollision(mouseX, mouseY) == true) gameover=true;

    // move and display the enemies
    n.move();
    n.display();
  }

  // check if enemy lasers have hit the good ship
  for (Bolt b : enemylasers) {
    if (player.checkCollision(b.x, b.y) == true) {
      gameover = true;
    }
  }

  // move the good lasers
  for (Bolt b : lasers) {
    b.move();
    b.draw();
  }

  // move the enemy lasers
  for (Bolt b : enemylasers) {
    b.move();
    b.draw();
  }


  // remove lasers and ships that have left the screen
  for (int i = 0; i < lasers.size(); i++) if (lasers.get(i).visible == false) lasers.remove(i);
  for (int i = 0; i < enemies.size(); i++) if (enemies.get(i).visible == false) enemies.remove(i);
  for (int i = 0; i < enemylasers.size(); i++) if (enemylasers.get(i).visible == false) enemylasers.remove(i);


  if (score < 0) gameover = true;

  fill(0);
  textAlign(CENTER, CENTER);
  textSize(20);
  String printMe = "Score: " + score;
  text(printMe, 0.1*width, 0.9*height);

  fill(0);
  textAlign(CENTER, CENTER);
  textSize(20);
  printMe = "Death Blossoms: " + player.numDeathBlossoms;
  text(printMe, 0.8*width, 0.9*height);

  time = int(frameCount / 30.);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(15);
  printMe = "Elapsed Time: " + time;
  text(printMe, 0.85*width, 0.05*height);


  if (gameover==true) {
    background(255);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(50);
    printMe = "Game Over!";
    text(printMe, width/2., height*0.5);
    textAlign(CENTER, RIGHT);
    textSize(30);
    printMe = "Total Time: " + time + " seconds";
    text(printMe, width/2., height*0.65);
    noLoop();
  }
}


void mousePressed() {

  if (mouseButton==LEFT) {
    lasers.add(new Bolt(mouseX+5, mouseY+15, -5, 0., color(255, 0, 0))); 
    lasers.add(new Bolt(mouseX+25, mouseY+15, -5, 0., color(255, 0, 0))); 
    out.playNote("F2");
    out.playNote("E2");
    out.playNote("D2");
  }

  if (mouseButton==RIGHT && player.numDeathBlossoms>0) {
    for (int i = 0; i < 250; i++) {
      lasers.add(new Bolt(mouseX+15, mouseY+15, random(-10, -15), random(0, 359), color(205, 80, 0)));
    }
    out.playNote("F6");
    out.playNote("E6");
    out.playNote("D6");
    player.numDeathBlossoms--;
  }
}



class Bolt {
  float x, y, l, v, angle;
  color c;
  boolean visible;

  Bolt(float ix, float iy, float iv, float iangle, color ic) {
    x = ix;
    y = iy;
    v = iv;
    angle = iangle;
    l = 10;
    c = ic;
    visible = true;
  }

  void move() {
    x = x + v*sin(angle*PI/180.); 
    y = y + v*cos(angle*PI/180.);
    if (y<=0) visible = false; 
    if (y>=height) visible = false;
  }

  void draw() {
    stroke(c);  
    strokeWeight(5);
    line(x, y, x + l*sin(angle*PI/180.), y + l*cos(angle*PI/180.));
  }
}



class Nemesis {
  float x, y, v; 
  boolean visible;

  Nemesis(float ix, float iy, float iv) {
    x = ix;
    y = iy;
    v = iv;
    visible = true;
  }

  void move() {
    y = y + v; 
    if (y >= height) {
      visible = false; 
      score-=1;
    }
  }

  void display() {
    image(enemy, x, y, 30, 30);
  }

  boolean checkCollision(float inputx, float inputy) {
    float separation;
    separation = pow( pow(x-inputx, 2.) + pow(y-inputy, 2.), 0.5);
    if (separation < 20 && visible==true) {
      visible = false; 
      return true;
    }
    return false;
  }
}



class Hero {
  PImage ship;
  int numDeathBlossoms;  
  boolean alive;

  Hero() {
    ship = loadImage("http://i46.tinypic.com/6rm4ns.png");
    numDeathBlossoms = 5;
    alive = true;
  }

  void display() {
    image(ship, mouseX, mouseY, 30, 30);
  }

  boolean checkCollision(float inputx, float inputy) {
    float separation;
    separation = pow( pow(mouseX+15-inputx, 2.) + pow(mouseY+15-inputy, 2.), 0.5);
    if (separation < 20) {
      return true;
    }
    return false;
  }
}
