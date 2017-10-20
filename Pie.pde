class Pie {
  String name;
  float value;
  int x, y;
  float diameter, angle1, angle2;
  color c1, c2, currColor;
  
  Pie(String name, float value, float startA, float endA, float diameter) {
    this.name = name;
    this.value = value;
    this.angle1 = startA;
    this.angle2 = endA;
    this.diameter = diameter;
    c1 = color(158, 220, 229);
    c2 = color(55, 206, 229);
    currColor = c1; 
  }
  
  void drawPie() {
    if (intersect()) {
      currColor = c2;
    } else {
      currColor = c1;
    }
    strokeWeight(2);
    stroke(255);
    ellipseMode(CENTER);
    fill(currColor);
    arc(width/2, height/2, diameter, diameter, angle1, angle2, PIE);
  }
  
  boolean intersect() {
    int cX = width/2;
    int cY = height/2;   
    float distFromCenter = dist(mouseX, mouseY, cX, cY);
    if (distFromCenter > diameter/2) {
      return false;
    } else {
       float y1 = mouseY - cY ;
       float x1 = mouseX - cX;
       float ang = atan2(y1,x1);
       if (ang < 0){
         ang += 2*PI;
       }
       return ang >= angle1 && ang <= angle2;
    }
  }
  
  void hoverText(float mx, float my){
    float padding = 3;
    String text = name + ", " + str(value);
    float textW = textWidth(text) + 2*padding;
    float boxH = textAscent() + textDescent() + 2*padding;
    float boxX = mouseX;
    float boxY = mouseY - boxH - padding;
    fill (190, 219, 219);
    strokeWeight(0);
    
    rect(boxX, boxY, textW, boxH);
    fill(0);
    text(text, boxX + padding, boxY + (textAscent() + textDescent()));

  }
}