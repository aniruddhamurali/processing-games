class Laser {
  float x, y, v, angle;
  color c;
  boolean visible;
  
  
  /** Laser()
   * This is the constructor class for the lasers
   *
   * @param ix(float) - initial x-coordinate of the laser
   * @param iy(float) - initial y-coordinate of the laser
   * @param iv(float) - initial velocity of the laser
   * @param iangle(float) - angle of the laser
   * @param icolor(color) - color of the laser
   * @return none
   */
  Laser(float ix, float iy, float iv, float iangle, color icolor) {
    x = ix;
    y = iy;
    v = iv;
    angle = iangle;
    c = icolor;
    visible = true;
  }
  
  
  
  /** move()
   * This method moves the laser according to the angle
   *
   * @param none
   * @return none
   */
  void move() {
    x = x + v*sin(angle*PI/180.); 
    y = y + v*cos(angle*PI/180.);
  }
  
  
  /** drawLaser()
   * This method draws the laser
   *
   * @param none
   * @return none
   */
  void drawLaser() {
    stroke(c);  
    strokeWeight(5);
    line(x, y, x + 20*sin(angle*PI/180.), y + 20*cos(angle*PI/180.));
  }
  
}
