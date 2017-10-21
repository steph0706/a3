 class Bar {
  color c1, c2, currColor;
  color[] colours;
  String name;
  float value;
  float x, y;
  float w, h;
  
  
  Bar(float w, float h, String name, float x, float y) {
    this.name = name;   
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
    c1 = color(158, 220, 229);
    c2 = color(55, 206, 229);
    currColor = c1; 

  }
  
  void drawBar() {
    if (intersect()) {
      currColor = c2;
    } else {
      currColor = c1;
    }
    stroke(0);
    fill(currColor);
    rect(x, y, w, h);
  }
    
  boolean intersect() {
    if (mouseX >= this.x && mouseX <= this.w + this.x && 
          mouseY > this.y  && mouseY < this.y + this.h) {
      return true;
    } else {
      return false;
    }
  }
  
  void changeHeight(float change) {
    this.h += change;
  }
  
  void changeWidth(float change) {
   this.w += change;
  }
}