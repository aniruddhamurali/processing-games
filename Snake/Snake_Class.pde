
class snake {
  float snakeX;
  float snakeY;
  
  float dx;
  float dy;
  int snakeSize;
  
  float[] snakesXList = new float[100];
  float[] snakesYList = new float[100];
  
  snake(float x, float y) {
    snakeX = x;
    snakeY = y;
    dx = 0;
    dy = 0;
    snakeSize = 1;
  }
  
  void drawSnake(){
    fill(0, 255, 0);
   
    for(int i = 0; i < snakeSize; i++) {
      float X = snakesXList[i];
      float Y = snakesYList[i];
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
    //if (snakeX > width || snakeX < 0 || snakeY > height || snakeY < 0) gameOver = true;
    
    snakesXList[0] = snakeX;
    snakesYList[0] = snakeY;
     
  }
  
  void checkCollision(){
    boolean bool = false;
    
    for (int i = 1; i < snakeSize; i++) {
      if (snakeX == snakesXList[i] && snakeY== snakesYList[i]) {
        gameOver = true; //bool = true;
      }
      //else bool = false;
    } 
    
    //return bool;
  }
  
  
}
