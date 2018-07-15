class Paddle {
  float x;
  float y;
  float w;
  float h;
  
  
  /** Paddle()
   * This is the constructor class for the paddle
   *
   * @param paddleX(float) - x-coordinate of the paddle
   * @param paddleY(float) - y-coordinate of the paddle
   * @return none
   */
  Paddle(float paddleX, float paddleY) {
    w = 120;
    h = 30;
    x = paddleX;
    y = paddleY;
  }
  
  
  
  /** display()
   * This method displays the paddle
   *
   * @param none
   * @return none
   */
  void display() {
    stroke(0);
    fill(0, 0, 255);
    rectMode(CENTER);
    rect(x, y, w, h);
  }
  
  
  
  /** paddleBallCollision()
   * This method checks the collision between the paddle and the ball
   *
   * @param Ball b - the ball that is associated with hitting the paddle
   * @return num - if -1, the ball bounces to the left, if 1, the ball bounces to the right
   */
  int paddleBallCollision(Ball b) {
    int num = 0;
    if (b.y-4 >= y - h/2 && b.y-4 <= y + h/2) {
      if (b.x - 4 >= x - w/2 && b.x - 4 <= x) num = -1 ;    // if the ball hits the left side of the paddle, move the ball towards the left
      else if (b.x - 4 > x && b.x - 4 <= x + w/2) num = 1;  // if the ball hits the right side of the paddle, move the ball towards the right
    }
    else num = 0;
    
    return num;
  }
 
}
