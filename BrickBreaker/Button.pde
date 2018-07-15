
// This is the button class definition
class Button {
  float x, y, w, h;    // stores the location and geometry of the button
  String label;        // stores the label to printinside the button
  boolean pressed;     // stores a boolean (true or false) for if the button is being pressed
  
  
  /** Button()
   * This is the constructor class for the buttons
   *
   * @param ix(float) - the x-coordinate of the button
   * @param iy(float) - the y-coordinate of the button
   * @param iw(float) - the width of the button
   * @param ih(float) - the height of the button
   * @param ilabel(String) - the string printed on the button
   * @return none
   */
  Button(float ix, float iy, float iw, float ih, String ilabel) {
   x = ix;
   y = iy;
   w = iw;
   h = ih;
   label = ilabel;
   pressed = false; 
  }
  
  
  
  /** drawButton()
   * This method draws the buttons
   *
   * @param none
   * @return none
   */
  void drawButton() {
    rectMode(CORNER);
    rect(x,y,w,h);
    
    if (pressed == false) {
      fill(10,200,245);
    }
    
    if (pressed == true) {
      fill(255,190,0);
    }
    
    rectMode(CORNER);
    rect(x,y,w,h);
    
    // print the label
    fill(0);
    textAlign(CENTER, CENTER);
    textFont(f,35);
    text(label, x+w/2., y+h/2.-1.); 
  }
  
  
  
  /** pressed()
   * This method checks whether or not a button has been pressed
   *
   * @param none
   * @return true/false - returns whether the button was pressed
   */
  boolean pressed() {
    float mx = mouseX;
    float my = mouseY;
    if (mx >= x && mx <= x+w && my >= y && my <= my+h && mousePressed == true) {
      this.pressed = true;
      return true;
    } 
    else {
     this.pressed = false; 
     return false;
    } 
  }
  
} 
