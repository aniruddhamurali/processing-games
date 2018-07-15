 
/*int dx = 0;
int dy = 0;
int snakeX = 0;
int snakeY = 0;
int foodX = -1;
int foodY = -1;
boolean check = true;
int []snakesXList;
int []snakesYList;
int snakeSize = 1;*/
int windowSize = 300;
boolean gameOver = false;
PFont Font = createFont("Calibiri",20, true);

snake gameSnake = new snake(width/2, height/2);
Food food = new Food(0,0);

void setup(){
  size(int(windowSize), int(windowSize),P3D);
   
  background(0);
  //rectMode(CENTER);
  
  /*snakesXList = new int[100];
  snakesYList = new int[100];
   
  snakeX = width/2;
  snakeY = height/2;
  foodX = -1;
  foodY = -1;
  gameOver = false;
  check = true;
  snakeSize =1;*/
}
  
void draw(){
  frameRate(20);
  background(0);
  noStroke();

  food.drawfood();
  food.snakeFoodCollision(gameSnake);
  gameSnake.drawSnake();
  gameSnake.snakeMove();
  food.ateFood(gameSnake);
  gameSnake.checkCollision();
  
  //if (gameSnake.checkCollision() == true) gameOver = true;
  if (gameSnake.snakeX < 0 || gameSnake.snakeX > width || gameSnake.snakeY < 0 || gameSnake.snakeY > height && gameSnake.snakeSize > 1) gameOver = true;
  
  /*if (gameOver == true) {
    background(0);
    textAlign (CENTER);
    textFont(Font, 40);
    fill(255);
    text("GAME OVER",width/2,height/2);
  }*/
}


/*void reset(){
  snakeX = width/2;
  snakeY = height/2;
  gameOver = false;
  check = true;
  snakeSize =1;
  dy = 0;
  dx = 0;
}*/

/*void checkCollision(){
   for (int i = 1; i < snakeSize; i++){
       if (snakeX == snakesXList[i] && snakeY== snakesYList[i]){
          gameOver = true;
      }
   } 
}


void ateFood(){
  if (abs(dist(foodX, foodY, snakeX, snakeY)) <= 12) {
    check = true;
    snakeSize++;
  }
}


void drawfood(){
  fill(255, 0, 0);
  rect(foodX, foodY, 20, 20);    
}


void snakeFoodCollision() {
  while(check){
    int x = int(random(1,windowSize/10));
    int y = int(random(1,windowSize/10)); 
    
    foodX = x*10;
    foodY = y*10;
     
    for(int i = 0; i < snakeSize; i++){
       if (x == snakesXList[i] && y == snakesYList[i]){
         check = true;
         i = snakeSize;
       }
       
       else {
         check = false;
       }
    }
     
  }
}


void drawSnake(){
  fill(0, 255, 0);
 
  for(int i = 0; i < snakeSize; i++) {
    int X = snakesXList[i];
    int Y = snakesYList[i];
    rect(X,Y,20,20);
  }
   
  for(int i = snakeSize; i > 0; i--){
    snakesXList[i] = snakesXList[i-1];
    snakesYList[i] = snakesYList[i-1];
  }
}
 
void snakeMove(){
  snakeX += dx;
  snakeY += dy;
  if (snakeX > windowSize-5 || snakeX < 5||snakeY > windowSize-5||snakeY < 5){
     gameOver = true;
  }
  snakesXList[0] = snakeX;
  snakesYList[0] = snakeY;
   
}*/
  
void keyPressed() {
  if (keyCode == UP) {  
    if (gameSnake.snakesYList[1] != gameSnake.snakesYList[0]-10) {
      gameSnake.dy = -10; 
      gameSnake.dx = 0;
    }
  }
  
  if (keyCode == DOWN) {  
    if (gameSnake.snakesYList[1] != gameSnake.snakesYList[0]+10) {
      gameSnake.dy = 10; 
      gameSnake.dx = 0;
    }
  }
  
  if (keyCode == LEFT) { 
    if (gameSnake.snakesXList[1] != gameSnake.snakesXList[0]-10) {
      gameSnake.dx = -10; 
      gameSnake.dy = 0;
    }
  }
  
  if (keyCode == RIGHT) { 
    if (gameSnake.snakesXList[1] != gameSnake.snakesXList[0]+10) {
      gameSnake.dx = 10; 
      gameSnake.dy = 0;
    }
  }
  
  //if (keyCode == 'R') reset();
}

