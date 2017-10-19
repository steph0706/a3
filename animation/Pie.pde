class Pie {
  String name;
  int value, x, y;
  float diameter, angle1, angle2;
  color c1, c2, currColor;
  boolean ifPie;
  
  Pie(String name, int value, float startA, float endA, float diameter, boolean ifPie) {
    this.name = name;
    this.value = value;
    this.angle1 = startA;
    this.angle2 = endA;
    this.diameter = diameter;
    c1 = color(169, 134, 214);
    c2 = color(125, 92, 168);
    currColor = c1; 
    this.ifPie = ifPie;
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
       if (ifPie == false){
         if (distFromCenter < diameter/4){
           return false;
         }
       }
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
    float padding = 10;
    fill(190, 219, 219);
    strokeWeight(0);
    float textSize = diameter/20;
    textSize(textSize);
    textAlign(CENTER,TOP);
    float textBoxWidth = (float)(name.length())*textSize*0.6;
    rect(mx+padding, my+padding, textBoxWidth, textSize*1.2);
    fill(54, 63, 63);
    text(name + ", " + str(value), mx + padding+textBoxWidth/2, my+padding);
  }




}