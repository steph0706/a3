class Point{
  float x, y;
  String name;
  
  Point(float x, float y, String name){
      this.x = x;
      this.y = y;
      this.name = name;
  }
  
  void drawPoint(){
     strokeWeight(7);
     point(x,y); 
  }
  
  boolean intersect() {
   if (mouseX <= this.x + 1 && mouseX >= this.x - 1 && mouseY <= this.y + 5 && mouseY >= this.y-5) return true;
   
   return false;
  }
}