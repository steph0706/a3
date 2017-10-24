class Button {
 String text;
 
 float w, h, cx, cy;
 color currColor, c1, c2;
 boolean grey;
 
 Button(float w, float h, String text, float x, float y) {
  this.w = w;
  this.h = h;
  this.text = text;
  this.cx = x;
  this.cy = y;
  this.c1 = color(158, 220, 229);
  this.c2 = color(55, 206, 229);
  currColor = c1;
  grey = false;
 }
 
 void drawButton() {
  rectMode(CORNER);
  strokeWeight(0);
  stroke(0);
  if(grey){
    currColor= color(134,134,134);
  }
  else if (intersect()) {
    currColor = c2;
  } else {
    currColor = c1;
  }
  
  fill(currColor);
  rect(cx, cy, w, h);
  fill(255);
  textAlign(CENTER);
  text(text, cx + 35, cy + 15);
  
 }
 
 boolean intersect() {
  if (mouseX >= cx && mouseX <= cx + w && mouseY >= cy && mouseY <= cy + h) return true;
  
  return false;
 }
 
}