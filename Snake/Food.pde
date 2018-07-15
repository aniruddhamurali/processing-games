
class Food {
  float foodX;
  float foodY;
  boolean check = false;
  
  Food(float x, float y) {
    foodX = x;
    foodY = y;
  }
  
  
  void drawfood(){
    fill(255, 0, 0);
    rect(foodX, foodY, 20, 20);    
  }
  
  
  void ateFood(snake s){
    if (abs(dist(foodX, foodY, s.snakeX, s.snakeY)) <= 12) {
      check = true;
      s.snakeSize += 1;
    }
  }
  
  
  void snakeFoodCollision(snake s) {
    while (check) {
      int x = int(random(1,windowSize/10));
      int y = int(random(1,windowSize/10)); 
      
      foodX = x*10;
      foodY = y*10;
       
      for (int i = 0; i < s.snakeSize; i++){
         if (x == s.snakesXList[i] && y == s.snakesYList[i]){
           check = true;
           i = s.snakeSize;
         }
         
         else {
           check = false;
         }
      }
       
    }
  }
  
}
