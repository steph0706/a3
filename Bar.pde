 class Button1 {
  color C1, C2, currC;
  color[] colours;
  String[] text;
  String T1, T2, currT;
  int w, h, cx, cy, currState, currWidth, currHeight, numStates, currDiv;
  
  
  Button1(int width, int height, String[] initText, int x, int y) {
       
    w = width;
    h = height;
    cx = x;
    cy = y;

    currC = colours[currState];
    currT = text[currState];
  }
  
  void drawButton() {
    //rectMode(CENTER);
    fill(currC);
    rect(cx, cy - height, width, height); 
    //rect(cx, cy, currWidth, currHeight);
    fill(0, 0, 0);
    //textAlign(CENTER);
    //text(currT, cx, cy);
  }
  
  void updateState() {
    //int temp = currState % numStates;
    //currC = colours[temp];
    //currT = text[temp];
    //if (temp == 0) {
    //  currDiv = 2;
    //} else {
    //  currDiv++;
    //}
   
    //currWidth = w/currDiv;
    //currHeight = h/currDiv;
    
    //currState++;

  }
  
  boolean intersectButton(int x, int y) {
    if (x > cx - width/2 && x < cx + width/2 && 
          y > cy - height/2 && y < cy + height/2) {
      return true;
    } else {
      return false;
    }
  }
}