class Animation {
  BarChart bc;
  LineChart lc;
  PieChart pc;
  float weight = 1;
  float lineConst = 1.01;
  float xConst = 1;
  Animation(BarChart bc, LineChart lc, PieChart pc) {
   this.bc = bc;
   this.lc = lc;
   this.pc = pc;
 }
 
 void b2l() {
   if(changeH()){
        if(changeW()){
          drawDots(weight);
          if(drawLines()){
             this.lc.render(); 
          }
          if(weight <= 6) weight += 0.1;
     }
   }
   
   else changeH();
 }

boolean doneWithBars(){
   if(changeH() && changeW()) return true;
   
   return false;
}

boolean doneB2L(){
  if(changeH() && changeW() && drawLines()) return true; 
  
  return false;
}

boolean changeW(){
     boolean allZero = true;
     for (Bar bar : bc.bars) {
      if(bar.w > 1){
          bar.changeWidth(-1); 
      }
      
      if (bar.w < 1){
        allZero = allZero && true;
      } else{
       allZero = allZero && false;
     }
     }
      
     return allZero;

}

boolean changeH(){
     boolean allZero = true;
     for (Bar bar : bc.bars) {
        if(bar.h > 1){
            bar.changeHeight(-1); 
        }
        if (bar.h < 1){
          allZero = allZero && true;
        } else {
          allZero = false;
        }
     }
     
     return allZero;

}

void drawDots(float weight){
  for (Bar bar : bc.bars) {
    stroke(color(55, 206, 229));
    strokeWeight(weight);
    point(bar.x + 10,bar.y);
  }
}

boolean drawLines(){
   for(int i = 0; i < bc.bars.length - 1; i++){
     PVector p1 = new PVector(bc.bars[i].x + 10, bc.bars[i].y);
     PVector p2 = new PVector(bc.bars[i+1].x + 10, bc.bars[i+1].y);
     PVector dir;
     dir = PVector.sub(p2,p1);
     dir.normalize();
          if(i == 7){
            print(p1);
            print(p2);
            println(dir);
          }

     strokeWeight(1);
     stroke(0);

     if ((bc.bars[i].x + 10 + (dir.x * xConst) < bc.bars[i+1].x + 10)) {
      line(bc.bars[i].x+10, bc.bars[i].y, bc.bars[i].x+10 + (dir.x * xConst), (bc.bars[i].y) + (dir.y * xConst));
      xConst += 0.01;
     } else {
       line(bc.bars[i].x+10, bc.bars[i].y, bc.bars[i+1].x + 10, (bc.bars[i+1].y));
       return true;
     }
   }
   
   return false;
}
 
 void l2b(LineChart lc) {
   
 }
  
}