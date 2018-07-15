/** BrickBreaker
 * User gets to play a game of BrickBreaker
 *
 * @author Aniruddha Murali
 */


// sound
// Minim Libraries
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

// Minim objects
Minim minim;
AudioPlayer backgroundMusic;
AudioPlayer player2;
AudioPlayer gameOverMusic;
AudioPlayer lostLifeMusic;
AudioPlayer clearMusic;
AudioPlayer laserMusic;
AudioPlayer breakBlockMusic;
AudioOutput out;

int WindowWidth = 1280;
int WindowHeight = 720;

Ball ball;
Paddle paddle;
int screen = 0;        // keeps track of current screen
int laserCount = 5;    // there are 5 lasers
int lives = 3;         // there are 3 lives
int score = 0;         // keeps track of score
int highScore = 0;     // keeps track of the high score
boolean arrowControl;  // if true, arrows control the paddle
boolean mouseControl;  // if false, mouse controls the paddle

PFont f;

// buttons
Button playButton = new Button(WindowWidth*2/3 - 180, WindowHeight/2, 350, 75, "PLAY");
Button instructionsButton = new Button(WindowWidth/3 - 180, WindowHeight/2, 350, 75, "INSTRUCTIONS");

// ArrayLists for bricks and lasers
ArrayList<Brick> bricks = new ArrayList<Brick>();
ArrayList<Laser> lasers = new ArrayList<Laser>();


/** setup()
 * This method sets up the program
 *
 * @param none
 * @return none
 */
void setup() {
  size(1280, 720);
  frameRate(30);

  rectMode(CENTER);
  ball = new Ball(width/2, height-100, 9, int(random(-5, -2)), int(random(5, 8)));
  
  // music
  minim = new Minim(this);
  backgroundMusic = minim.loadFile("09 Dire, Dire Docks.mp3", 2048);
  gameOverMusic = minim.loadFile("game_over.wav", 2048);
  lostLifeMusic = minim.loadFile("player-down.mp3", 2048);
  clearMusic = minim.loadFile("castle_clear.wav", 2048);
  laserMusic = minim.loadFile("power-up.wav", 2048);
  breakBlockMusic = minim.loadFile("break_block.wav", 1024);
  backgroundMusic.play();
  backgroundMusic.loop();

  f = createFont("Calibiri", 30, true);
  
  
  // add bricks
  for (int i = 1; i < 12; i++) {
    Brick b = new Brick();
    b.setLocation((WindowWidth*i/12), 100);
    b.setbreakCount(3);
    bricks.add(b);
  }
  for (int i = 1; i < 12; i++) {
    Brick b = new Brick();
    b.setLocation((WindowWidth*i/12), 260);
    b.setbreakCount(3);
    bricks.add(b);
  }

  paddle = new Paddle(mouseX, height-70);
}



/** draw()
 * This method is the main method that executes the whole program
 *
 * @param none
 * @return none
 */
void draw() {
  if (screen == 0) homeScreen();  // if screen = 0, go to home screen
                                   // if screen = 1, go to instructions
  else if (screen == 1) {
    //background(0);
    instructions();
    fill(2505, 128, 0);
    text("Continuing in:  " + str(25 - (frameCount % 750)/30), width/2, height - 50);
    if (frameCount % 750 == 0) screen = 0;
  } 
  else if (screen == 2) {      // if screen = 2, go to play screen
    //backgroundMusic.unmute();
    playScreen();
  } 
  else if (screen == 3) gameOverScreen();  // if screen = 3, go to game over screen
  else if (screen == 4) win();             // if screen = 4, go to te 'winning' screen
    
}



/** homeScreen()
 * This method displays the home screen and the play and instruction buttons
 *
 * @param none
 * @return none
 */
void homeScreen() {
  background(0);
  textFont(f,48);
  textAlign(CENTER, CENTER);
  fill(255, 0, 0);
  text("BRICK BREAKER", width/2, height/4);
  
  playButton.drawButton();
  instructionsButton.drawButton();
  fill(255);
  textSize(22);
  text("Click this button to play", width*2/3 - 5, height/2 + 90);
  text("Click this button to see instructions", width/3 - 5, height/2 + 90);

  if (playButton.pressed() == true) screen = 2;
  else if (instructionsButton.pressed() == true) screen = 1;
}


/** instructions()
 * This method displays the instructions for the game
 *
 * @param none
 * @return none
 */
void instructions() {
  background(0);
  //backButton.drawButton();
  textAlign(CENTER, CENTER);
  textFont(f,40);
  fill(255,128,0);
  text("Welcome to Brick Breaker!", width/2, height/12);
  
  textSize(28);
  fill(0,150,255);
  text("The objective of this game is to break all the bricks using the ball that \n can bounce off the bricks, the walls, and the paddle that you control."
   + "\n You are given 3 lives and 5 lasers that you can use.", width/2, height/12 + 100);
  text("Here are the controls:", width/2, height/12 + 190);
  fill(255,0,0);
  text("Left: Move the mouse left, press the left arrow, or press 'a'\n Right: Move the mouse right, press the right arrow, or press 'd'" +
  "\n Lasers: Press 'l' or 'f'", width/2, height/12 + 290);
  fill(0,200,0);
  text("Tips: The ball will move faster when you use the mouse, and it will move slower \n when you use the keys. Use this to help you break certain bricks." + 
  "\n Also, your lasers can break all the bricks in one column. Even more, no matter what color \n brick they hit, each hit scores 15 points. " + 
  "However, you only have 5, \n so use them wisely!", width/2, height/12 + 450);

}


/** playScreen()
 * This method displays and executes the BrickBreaker game
 *
 * @param none
 * @return none
 */
void playScreen() {
  background(0);
  
  // if the lost life music is playing, mute the background music
  if (lostLifeMusic.isPlaying() == true) backgroundMusic.mute();
  else backgroundMusic.unmute();
  
  // if the backgroundMusic stopped playing, rewind it
  if (backgroundMusic.isPlaying() == false) backgroundMusic.rewind();
  backgroundMusic.play();
  
  ball.move();
  ball.display();
  
  if (keyPressed == true) {  
    arrowControl = true;
    mouseControl = false;
    if (key == 'a'|| keyCode == LEFT) paddle.x -= 15;  // if the a or LEFT key is pressed, move the paddle left
    if (key == 'd'|| keyCode == RIGHT) paddle.x += 15; // if the d or RIGHT key is pressed, move the paddle right
    if ((key == 'f'|| key == 'l') && laserCount > 0) { // if the f or l key is pressed, shoot a laser
      laserMusic.rewind();
      laserMusic.play();
      lasers.add(new Laser(paddle.x, paddle.y - paddle.h/2, -5, 0, color(255, 190, 0)));
      laserCount = laserCount - 1;
    }
  } 
  
  if (mouseX - pmouseX > 0) {
    mouseControl = true;
    arrowControl = false;
  }
  
  if (mouseControl == true) paddle.x = mouseX;
  
  paddle.display();
  
  if (paddle.x < 0) paddle.x = 0 ;
  if (paddle.x > width-80) paddle.x = width-80;
  
  if (paddle.paddleBallCollision(ball) == -1) {
    ball.setXDirection(false);
    ball.setYDirection(true);
    if (mouseControl == true) { ball.xStep = 12; ball.yStep = 12; } 
    else if (arrowControl == true) { ball.xStep = 7; ball.yStep = 7; }
  } 

  if (paddle.paddleBallCollision(ball) == 1) {
    ball.setXDirection(true);
    ball.setYDirection(true);
    if (mouseControl == true) { ball.xStep = 12; ball.yStep = 12; } 
    else if (arrowControl == true) { ball.xStep = 7; ball.yStep = 7; }
  }

  for (int i = 0; i < bricks.size (); i++) {
    Brick b = bricks.get(i);
    b.display();

    if (b.brickBallCollision(ball) == true) {
      breakBlockMusic.rewind();
      breakBlockMusic.play();
      
      score += 5; // for every time the ball hits a brick, add 5 points

      if (ball.ellipseY_upward == true) ball.setYDirection(false); // if the ball went upward, bounce the ball downward
      else ball.setYDirection(true);                               // if the ball went downward, bounce the ball upward
      b.breakCount -= 1; // it will take one less hit to break the brick

      if (b.breakCount == 0) bricks.remove(b); // if the brick's breakCount is 0, remove the brick
      else b.setColor();                       // else set the color according to the breakCount of the brick
    }

    for (Laser l : lasers) {
      if (dist(l.x, l.y, b.x, b.y) < 40){
        score += 15;      // add 15 points whenever a laser hits a brick, no matter the breakCount
        bricks.remove(b); // remove the brick
      }
    }
  }
  
  // moves each laser 
  for (Laser l : lasers) {
    l.move();
    l.drawLaser();
  }
  
  textAlign(CENTER, CENTER);
  textFont(f, 20);
  fill(255);
  text("Laser Count: " + str(laserCount), width - 100, height - 160);
  text("Lives: " + str(lives), width - 100, height - 130);
  text("Score: " + str(score), width - 100, height - 100);
  
  // if there are no more bricks, the user wins
  if (bricks.size() == 0) screen = 4;
  
  
  if (ball.y > height) {
    // if the user lost all of their lives, game over
    if (lives == 1) {
      screen = 3;
      gameOverMusic.rewind();
    } 
    // else the user loses one life
    else {
      lives -= 1;
      lostLifeMusic.rewind();
      lostLifeMusic.play();
      
      ball.x = width/2;
      ball.y = height*2/3;
      ball.ellipseY_upward = true;
    }
  }
  
}


/** mouseClicked()
 * This method shoots a laser and time the mouse is clicked on the play screen
 *
 * @param none
 * @return none
 */
void mouseClicked() {
  if (screen == 2 && laserCount > 0) {
    laserMusic.rewind();
    laserMusic.play();
    lasers.add(new Laser(mouseX, paddle.y - paddle.h/2, -5, 0, color(255, 190, 0)));
    laserCount = laserCount - 1;
  }
}


/** gameOverScreen()
 * This method displays the game over screen and displays the score and high score
 *
 * @param none
 * @return none
 */
void gameOverScreen() {
  background(0);

  backgroundMusic.mute();
  lostLifeMusic.mute();
  gameOverMusic.play();

  textAlign(CENTER, CENTER);
  textFont(f, 50);
  if (score > highScore) {
    highScore = score;
    String[] highScoreList = {str(highScore)};
    saveStrings("highScore.txt", highScoreList);
    fill(random(0,255), random(0,255), random(0,255));
    text("New High Score!", width/2, height*3/4);
  }
  
  fill(255);
  textSize(40);
  text("GAME OVER", width/2, height/2 - 250);
  text("Score: " + str(score), width/2, height/2);
  String[] highScoreString = loadStrings("highScore.txt");
  text("High Score: " + highScoreString[0], width/2, height/2 + 50);
}


/** homeScreen()
 * This method displays the winning screen if the user beat the game
 *
 * @param none
 * @return none
 */
void win() {
  backgroundMusic.mute();
  lostLifeMusic.mute();
  laserMusic.mute();
  clearMusic.play();
  
  background(0);
  textAlign(CENTER, CENTER);
  textFont(f, 50);
  fill(random(0,255), random(0,255), random(0,255));
  text("You win!", width/2, height/2 - 50);
  textSize(36);
  fill(255);
  text("Score: " + str(score), width/2, height/2 + 100);
  String[] highScoreString = loadStrings("highScore.txt");
  if (score > highScore) text("High Score: " + str(score), width/2, height/2 + 150);
  else text("High Score: " + highScoreString[0], width/2, height/2 + 150);
}

