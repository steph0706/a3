class Animation {
  BarChart bc;
  LineChart lc;
  PieChart pc;
  float weight = 1;
  float lineConst = 1.01;
  float xConst = 1;
  float smallScale = 1;
  PVector[] bar_end_points;
  float[] angles;
  float [] currAngles;
  boolean needToDrawArcs = false;
  boolean needToCalcPoints= true;
  PVector[] arc_end_points;
  PVector[] arc_points;
  float c = 0.9;
  

  
  Animation(BarChart bc, LineChart lc, PieChart pc) {
   this.bc = bc;
   this.lc = lc;
   this.pc = pc;
   this.bar_end_points = new PVector[this.bc.bars.length];
   this.arc_end_points = new PVector[this.bc.bars.length * 2];
   this.arc_points = new PVector[this.bc.bars.length * 2];
   this.angles = new float [this.bc.bars.length];
   this.currAngles = new float[this.bc.bars.length];
 }
   
  void b2l() {
     if(changeH()){
          if(changeW()){
            drawDots(weight);
            if(drawLines()){
               this.lc.render(); 
            }
            if(weight <= 6) weight += 0.;
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
            bar.changeWidth(-0.1); 
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
 
  //void l2b() {
  //   if(reverseH()){
  //        if(reverseW()){
  //          reverseDots(weight);
  //          if(reverseLines()){
  //             this.lc.render(); 
  //          }
  //          if(weight <= 6) weight -= 0.1;
  //     }
  //   }
     
  //   else changeH();
  // }
  
  void b2p(){
    //1. color x-axes labels
    //2. color bars from bottom to top
    //3. remove axes
    //4. shrink first position bars in a stack
    //5. start curving bars into a circle
    //6. extends lines splitting bars apart into the circle
    calcBarEndY();
    calcArcEnd();
    if (needToCalcPoints){
      calcArcPoints();
      calcAngles();
    }
    if(shrinkBars()){
      if(moveBarsY()){
         if (changeW()) {
           needToDrawArcs = true;
           needToCalcPoints = false;
           //drawArcs();
           if(movePoints()){
                drawArcs();
           }
         }
      }
    }
  }
 
  boolean movePoints()
  {
      boolean done = true;
      for(int i = 0; i < arc_points.length; i++){
        float diff_y = arc_end_points[i].y - arc_points[i].y;
        float diff_x = arc_end_points[i].x - arc_points[i].x;
        PVector change;
        float newX = arc_points[i].x;
        float newY = arc_points[i].y;

        //newX = arc_points[i].x;
        //newY = arc_points[i].y;
        if(Math.abs(diff_y) > 0.5){
             newY = (diff_y > 0 ? arc_points[i].y + 0.6 : arc_points[i].y - 0.6);
             if (i == 0) {
                 println("helakd     " + arc_points[i].y);
                 println(newY);
             }
             done = false;
         }
       
        if(Math.abs(diff_x) > 0.5){
            //println("hello");
             newX = (diff_x > 0 ? arc_points[i].x + 0.5 : arc_points[i].x - 0.5);
             done = false;
         }
         else done = done && true;
         change = new PVector(newX, newY);
         arc_points[i] = change;
                   if (i ==0) println(change);

          if (i ==0) println(arc_points[i]);
          

         strokeWeight(3);
         point(arc_points[i].x, arc_points[i].y);
      }
      return done;
  }
  
  void drawArcs(){
    //for(PVector pt : arc_end_points){
    //  point(pt.x,pt.y);
    //}
     boolean done = true; //me rn
     float diameter = 2 * (height * 0.9) / TWO_PI; 
      strokeWeight(1);
     for (int i = 0; i < angles.length; i++) {
       if (currAngles[i] <= angles[i]) {
         done = false;
         fill(color(158, 220, 229));
         currAngles[i] = currAngles[i] + radians(0.1);
         if(i == 0){
           arc(width/2, height/2, diameter, diameter, 0, currAngles[i],PIE);
         }
         else arc(width/2, height/2, diameter, diameter, angles[i-1], currAngles[i],PIE);
       } else {
         if(i == 0){
           arc(width/2, height/2, diameter, diameter, 0, angles[i],PIE);
         }
         else arc(width/2, height/2, diameter, diameter, angles[i-1], angles[i],PIE);
       }
   }
   
   if(done){
         pc.draw();
       }
  }
  
  void calcAngles(){
     float sum = 0;
      for(Bar bar: bc.bars){
        sum += bar.h; 
       }
       
      for(int i = 0; i < bc.bars.length; i++){
         float angle = TWO_PI * (bc.bars[i].h / sum);
         if(angle > TWO_PI) print("fck");
         if(i == 0){
           angles[i] = angle; 
         }
         else angles[i] = angle + angles[i-1];
      }
      
      for (int i = 0; i < angles.length; i++) {
       if (i == 0) currAngles[i] = 0;
       else {
         currAngles[i] = angles[i-1]; 
       }
      }
    
  }
  boolean moveBarsY(){
      boolean done = true;
      for(int i = 0; i < bc.bars.length; i++){
        float diff = bar_end_points[i].y - bc.bars[i].y;
        if(Math.abs(diff) > 0.5){
             bc.bars[i].y = (diff > 0 ? bc.bars[i].y + 0.5 : bc.bars[i].y - 0.5);
             done = false;
         }
         else done = done && true;
      }
      return done;
  }
 
  boolean moveBarsX(){
      boolean done = true;
      for(int i = 0; i < bc.bars.length; i++){
         float diff = bar_end_points[i].x - bc.bars[i].x;
         if(Math.abs(diff) > 0.25){
             bc.bars[i].x = (diff > 0 ? bc.bars[i].x + 0.25 : bc.bars[i].x - 0.25);
             done = false;
         }
         
         else done = done && true;
      }
      
      return done;
  }
  
  void calcBarEndY(){
    for (int i = 0; i < bc.bars.length; i++) {
      if(i == 0){
         PVector p = new PVector(width/2, 10);
         bar_end_points[i] = p;
      }
      
      else{
         PVector p = new PVector(width/2, bc.bars[i-1].h + bar_end_points[i-1].y);
         bar_end_points[i] = p;
      }
    }
  }
  
  void calcArcPoints(){
    for(int i = 0; i < bc.bars.length; i++){
      float x1,x2,y1,y2;
      x1 = bc.bars[i].x;
      x2 = bc.bars[i].x;
      y1 = bc.bars[i].y;
      y2 = bc.bars[i].y + bc.bars[i].h;
      
      PVector p1 = new PVector(x1,y1);
      PVector p2 = new PVector(x2,y2);
      arc_points[i * 2] = p1;
      arc_points[(i * 2) +1] = p2;
    }
  }
  
  void calcArcEnd(){
    float r = (height * 0.9) / TWO_PI;
    for(int i = 0; i < bc.bars.length; i++){
      float angle = angles[i];
      float x1, x2, y1, y2;
      if(i == 0){
        x1 = r * cos(0) + width/2;
        y1 = r * sin(0) + height/2;
        x2 = r * cos(angle) + width/2;
        y2 = r * sin(angle) + height/2;
      }
      
      else{
        float prev_angle = angles[i-1];
        x1 = r * cos(prev_angle) + width/2;
        y1 = r * sin(prev_angle) + height/2;
        x2 = r * cos(angle) + width/2;
        y2 = r * sin(angle) + height/2; 
      }
      
      PVector p1 = new PVector(x1,y1);
      PVector p2 = new PVector(x2,y2);
      arc_end_points[i * 2] = p1;
      arc_end_points[(i * 2) +1] = p2;
    }
  }

  
  boolean shrinkBars(){
     boolean done = true;
     float scale = calcShrinkScale();
     if(smallScale > scale){
        for(Bar bar: bc.bars){
            bar.h = bar.h * smallScale;
         }
         
         smallScale -= 0.0001;
         done = false;
     }
     else done = done && true;
     return done;
  }
  
  float calcShrinkScale(){
     float sum = 0;
     
     for(Bar bar: bc.bars){
        sum += bar.h; 
     }
     
     float scale = (height * 0.9) / sum;             // sum * scale <= height 
     return scale;
  }
  //void changeColors(){
    
    
  //}
}