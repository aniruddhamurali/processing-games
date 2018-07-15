class Brick {
  float x, y, w, h;
  color c;
  int breakCount;
  
  /** Brick()
   * This is the constructor class for the bricks
   *
   * @param none
   * @return none
   */
  Brick() {
    breakCount = 3;
  }
 
 
 
  /** setLocation()
   * This method sets the location of each brick used in the game
   *
   * @param brickX(float) - the x-coordinate of the brick
   * @param brickY(float) - the y-coordinate of the brick
   * @return none
   */
  void setLocation(float brickX, float brickY) {
    x = brickX;
    y = brickY;
    w = 75;
    h = 25;
  }
 
  
  
  /** display()
   * This method displays all the bricks used in the game
   *
   * @param none
   * @return none
   */
  void display() {
    stroke(0);
    setColor();
    fill(c);
    rectMode(CENTER);
    rect(x, y, w, h);
    
    for (int i = 1; i < 4; i++) {
      stroke(0);
      strokeWeight(1);
      line(x-w/2, y + i * h/3 - h/2, x+w/2, y + i * h/3 - h/2);
      
      if (i % 2 == 1) {
        line(x - w/2 + w/3, y - h/2, x - w/2 + w/3, y + h/3 - h/2);
        line(x + w/2 - w/3, y - h/2, x + w/2 - w/3, y + h/3 - h/2);
        line(x - w/2 + w/6, y - h/2 + h/3, x - w/2 + w/6, y + h/2 - h/3);
        line(x, y - h/2 + h/3, x, y + h/2 - h/3);
        line(x + w/2 - w/6, y - h/2 + h/3, x + w/2 - w/6, y + h/2 - h/3);
        line(x - w/2 + w/3, y + h/2 - h/3, x - w/2 + w/3, y + h/2);
        line(x + w/2 - w/3, y + h/2 - h/3, x + w/2 - w/3, y + h/2);
        line(x - w/2, y - h/2, x + w/2, y - h/2);
        line(x + w/2, y - h/2, x + w/2, y + h/2);
        line(x - w/2, y + h/2, x + w/2, y + h/2);
        line(x - w/2, y - h/2, x - w/2, y + h/2);
      } 
    }

  }
  
  
  
  /** setColor()
   * This method sets the color of each brick according to their breakCount
   *
   * @param none
   * @return none
   */
  void setColor() {
    switch(breakCount) {
    case 1:
      c = color(255, 0, 0);
      break;
    case 2:
      c = color(0, 0, 255);
      break;
    case 3:
      c = color(0, 255, 0);
      break;
    }
  }

  
  
  /** setbreakCount()
   * This method displays the ball with random color
   *
   * @param count - the amount times it takes to break the brick
   * @return none
   */
  void setbreakCount(int count) {
    breakCount = count;
  }
 
  
  
  /** brickBallCollision()
   * This method checks the collision between a brick and the ball
   *
   * @param Ball b - the ball that is associated with hitting a brick
   * @return bool - returns whether the ball has collided with a brick or not
   */
  boolean brickBallCollision(Ball b) {
    boolean bool = false;
    if (b.y >= y - h/2 && b.y <= y + h/2 && b.x >= x - w/2 && b.x <= x + w/2) {
      
      if (b.ellipseY_upward == true) {
        if (b.y - b.radius >= y - h/2 && b.y - b.radius <= y + h/2) {
          ball.y = y + h/2;
          bool = true;
        }
      }
      else if (b.ellipseY_upward == false) {
        if (b.y + b.radius >= y - h/2 && b.y + b.radius >= y + h/2) {
          ball.y = y - h/2;
          bool = true;
        }
      }  
      
      else if (b.ellipseX_forward == true) {
        if (b.x + b.radius >= x - w/2 && b.x + b.radius <= x + w/2) {
          ball.x = x - w/2;
          bool = true;
        }
      }
      else if (b.ellipseX_forward == false) {
        if (b.x - b.radius >= x - w/2 && b.x - b.radius <= x + w/2) {
          ball.x = x + w/2;
          bool = true;
        }
      }
      
      else bool = false;
    }
    else bool = false;
    
    return bool;
  }
  
}

