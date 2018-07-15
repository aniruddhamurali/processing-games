
class Pipe {
  float x, y, x2, y2;
  String pos;
  
  Pipe(float ix, float iy, float ix2, float iy2, String ipos) {
     x = ix;
     y = iy;
     x2 = ix2;
     y2 = iy2;
     pos = ipos;  
  } 
  
  
  
  void drawPipe() {
    imageMode(CORNERS);

    if (pos == "Top") image(img2, x, y, x2, y2);
    else if (pos == "Bottom") image(img3, x, y, x2, y2);
  }
 
 
  
  void movePipe() {
    x -= 3;
    x2 -= 3;
  } 
  
}
