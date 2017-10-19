
class MyChart {
  String xTitle, yTitle; 
  String[] names;
  int[] values;
  int yMin, yMax, xNum; 
  float padding = 0.15; 
  float barFill = 0.8; 

  MyChart(String xTitle, String yTitle, String[] names, int[] values) {
    this.xTitle = xTitle;
    this.yTitle = yTitle;
    this.names = names;
    this.values = values;
    this.yMin = min(values);
    this.yMax = max(values); 
    this.xNum = names.length; 
  }

  void render(float xPos, float yPos) {
    fill(255); 
    rect(0, 0, width, height); 
    fill(0); 
    line(padding*width, (1 - padding)*height, (1 - padding)*width, (1 - padding)*height); 
    line(padding*width, padding*height, padding*width, (1 - padding)*height);    
    
    //spacing 
    float spacing = (width - 2*padding*width)/xNum; 
    float barWidth = barFill*spacing;
    float xStart = width*padding; 
    float yStart = height*(1-padding); 
    float ySpacing = (height - 2*padding*height) / (yMax - yMin);  
   
    for (int i = 0; i < xNum; i++) {
        float x, y; 
        x = xStart + spacing * i; 
        y = yStart; 
        float barHeight = values[i]*ySpacing; 
        
        /* try rotating text */
        pushMatrix();
        translate(x, y); //change origin 
        rotate(PI/2); //rotate around new origin 
        fill(0);
        text(" " + names[i], 0, 0); //put text at new origin 
        popMatrix();
        /* end rotate text */
        
        //textAlign(CENTER,TOP); 
        //text(names[i], x, y);   
        if (xPos >= x && xPos <= x + barWidth 
                      && yPos >= y - barHeight && yPos <= y) {
         fill(0, 255, 0); 
         text(names[i], 0, 0);
        } else {
          fill(color(0, 0, 255)); 
        }
        rect(x, y - barHeight, barWidth, barHeight); 
        
    } 
    // for (int i = 0; i < ; i++) {
    //   text(names[i], xStart + spacing * i, yStart);   
   // }
  }
}