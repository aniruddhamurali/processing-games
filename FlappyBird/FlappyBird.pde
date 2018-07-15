import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer backgroundMusic;

ArrayList<Pipe> pipes = new ArrayList<Pipe>();

float xStep = 300;
float rand, rand2;

float score = 0;
float highscore = 0;
int screen = 1;

PImage img;
PImage img2;
PImage img3;

PFont f;

Bird flappy = new Bird();


void setup() {
  size(1280, 720);
  f = createFont("Calibiri", 30, true);
  
  minim = new Minim(this);
  backgroundMusic = minim.loadFile("overworld.mp3");
  backgroundMusic.play();
  backgroundMusic.loop();
  
  img = loadImage("flappy.gif");
  img2 = loadImage("tube.png");
  img3 = loadImage("tube2.png");
  
  flappy.y = height/2;
  
  for (int i = 0; i <= 1000; i++) {
    float rand = random(300, 650); 
    float rand2 = rand + random(80, 100);
    
    Pipe p = new Pipe(width + xStep*i, 0, width + xStep*i + 80, rand, "Top");
    Pipe pipe = new Pipe(width + xStep*i, height, width + xStep*i + 80, rand2, "Bottom");
    
    pipes.add(p);
    pipes.add(pipe);
  }
}



void draw() {
  background(112, 196, 206);
  
  if (screen == 1) {
    flappy.drawBird();
    flappy.y += 4;
    
    if (keyPressed) {
      if (key == ' ') flappy.flap();
    }
    
    for (Pipe p : pipes) {
      p.drawPipe();
      p.movePipe();
      if (flappy.checkCollision(p) == true) screen = 2;
      if (p.x2 == width/8) score += 0.5;
    } 
    
    if (flappy.y > height) screen = 2;
    
    textAlign(CENTER, CENTER);
    textFont(f, 25);
    fill(0);
    text("Score: " + str(int(score)), width - 100, height - 50);
  }
  
  else if (screen == 2) gameOver();
  
}



void gameOver() {
  background(112,196,206);
  textAlign(CENTER, CENTER);
  textFont(f, 50);
  fill(255);
  text("GAME OVER", width/2, height/2 - 200);
  
  textSize(36);
  text("Score: " + str(int(score)), width/2, height/2 - 100);
  
  if (score > highscore) {
    highscore = score;
    fill(random(0,255), random(0,255), random(0,255));
    text("New High Score! ", width/2, height/2 + 100);
  }
  fill(255);
  text("High Score: " + str(int(highscore)), width/2, height/2  - 25);
  
  text("Press 'r' to play again", width/2, height/2 + 90);
  
  if (keyPressed && key == 'r') reset();
}



void reset() {
  flappy.y = height/2;
  score = 0;
  
  pipes.clear();
  
  
  for (int i = 0; i <= 1000; i++) {
    
    float rand = random(300, 650); 
    float rand2 = rand + random(80, 100);
    
    Pipe p = new Pipe(width + xStep*i, 0, width + xStep*i + 80, rand, "Top");
    Pipe pipe = new Pipe(width + xStep*i, height, width + xStep*i + 80, rand2, "Bottom");
    
    pipes.add(p);
    pipes.add(pipe);
  }
  
  screen = 1;
}
