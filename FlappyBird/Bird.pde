
class Bird {
  float x, y, w, h;
  
  Bird () {
    y = height/2;
    w = 90;
    h = 72;
    x = width/8;
  }
  
  
  
  void drawBird() {
    imageMode(CENTER);
    image(img, width/8, y, w, h);
  }
  
  
  
  void flap() {
    y -= 9;
    if (y < h/2 + 5) y = h/2;
  }
  
  
  
  boolean checkCollision(Pipe p) {
    boolean bool = false;
    
    if (p.pos == "Top") {
      if (width/8 >= p.x && width/8 <= p.x2 && y >= p.y && y <= p.y2) bool = true;
    }
    
    else if (p.pos == "Bottom") {
      if (width/8 >= p.x && width/8 <= p.x2 && y <= p.y && y >= p.y2) bool = true;
    }
    
    else bool = false;
    
    return bool; 
  }
  
}
