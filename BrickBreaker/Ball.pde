

class Ball {
  float x, y, radius, xStep, yStep;
  boolean ellipseX_forward = true;
  boolean ellipseY_upward = true;
  color c;
  
 /** Ball()
  * This is the constructor class for the ball
  *
  * @param ix(float) - the initial x coordinate of the ball
  * @param iy(float) - the initial y coordinate of the ball
  * @param r(float) - the radius of the ball
  * @param dx(float) - the change in the x-coordinate of the ball
  * @param dy(float) - the change in the y-coordinate of the ball
  * @return none
  */
  Ball(float ix, float iy, float r, float dx, float dy) {
    x = ix;
    y = iy;
    radius = r;
    xStep = dx;
    yStep = dy;
  }
  
  
  
  /** display()
   * This method displays the ball with random color
   *
   * @param none
   * @return none
   */
  void display() {
    stroke(0);
    c  = color(random(0,255), random(0,255), random(0,255));
    fill(c);
    ellipse(x, y, 2*radius, 2*radius);
  }
  
  
  
  /** move()
   * This method moves the ball
   *
   * @param none
   * @return none
   */
  void move() {
    
    if (ellipseX_forward == true) x = x + xStep*(1+random(0,1));
    else if (ellipseX_forward == false) x = x - xStep*(1+random(0,1));
     
    if (ellipseY_upward == true) y = y - yStep*(1+random(0,1));
    else if (ellipseY_upward == false) y = y + yStep*(1+random(0,1));
    
    if (x + radius/2 >= width) ellipseX_forward = false;    
    else if (x - radius/2 <= 0) ellipseX_forward = true;
    
    else if (y - radius/2 <= 0) ellipseY_upward = false;
  }
  
  
  
  /** setXDirection()
   * This method sets the horizontal direction of the ball
   *
   * @param none
   * @return none
   */
  void setXDirection(boolean forwardTrue) {
    if (forwardTrue == true) ellipseX_forward = true;
    else if (forwardTrue == false) ellipseX_forward = false;
  }
  
  
  
  /** setYDirection()
   * This method sets the vertical direction of the ball
   *
   * @param none
   * @return none
   */
  void setYDirection(boolean upwardTrue) {
    if (upwardTrue == true) ellipseY_upward = true;
    else if (upwardTrue == false) ellipseY_upward = false;
  }
  
}
