
class LineChart {
  String[] names;
  float[] data;
  Point [] points;
  String xTitle, yTitle; 
  float yMin, yMax; 
  int xNum;
  float xMargin = 0.15 * width; 
  float yMargin = 0.15 * height;
  float barFill = 0.8; 
  float barWidth, spacing;
  float xAxisLen;
  float yAxisLen;
  float ySpacing;  


  LineChart(String xTitle, String yTitle, String[] days, float [] values) {
    this.xTitle = xTitle;
    this.yTitle = yTitle;
    this.names = days;
    this.data = values;
    this.yMin = min(values);
    this.yMax = max(values); 
    this.xNum = days.length; 
    points = new Point[this.xNum];
    this.spacing = (width - 2 * xMargin)/xNum; 
    this.barWidth = this.barFill * spacing;
  }

  void calcStuff(){
    xAxisLen = (width - 2 * xMargin);
    yAxisLen = (height - 2 * yMargin);
    //spacing 

    float xStart = xMargin; 
    float yStart = yMargin; 
    ySpacing = (yAxisLen) / this.yMax;  
    
   
    for (int i = 0; i < xNum; i++) {
        float x, y; 
        float barHeight = this.data[i] * ySpacing; 
        x = xStart + this.spacing * i; 
        y = (yAxisLen - barHeight) + yMargin;
        Point pnt = new Point(x + 10, y, this.names[i]);
        points[i] = pnt;
        /* try rotating text */
        //pushMatrix();
        //translate(x + 10, y + barHeight); //change origin 
        //rotate(PI/2); //rotate around new origin 
        //fill(0);
        //text(" " + this.names[i], 0, 0); //put text at new origin 
        //popMatrix();
        /* end rotate text */
       
    }
  }
  
  void render() { 
      drawLines();

    for (int i = 0; i < xNum; i++) {
         stroke(color(55, 206, 229)); 
         fill(0);

        points[i].drawPoint();
    }
    
    for(int i = 0; i < xNum; i++) {
       Point pnt = points[i];
        if (pnt.intersect()) {
         stroke(color(158, 220, 229)); 
         fill(0);
         text(this.data[i], mouseX + 10, mouseY + 10);
        } else {
          stroke(color(55, 206, 229)); 
        }   
    }
  
  //drawAxes();
  }
  
void drawAxes(){
    strokeWeight(1);
    stroke(0);
    fill(0); 
    line(xMargin, yMargin, xMargin, height - yMargin);
    line(xMargin, height - yMargin, width - xMargin, height - yMargin);
    float y_axis_spacing = (yAxisLen / 11);

    for (int i = 0; i < 12; i++) {
      float currY = height - yMargin - i * y_axis_spacing;
      line(xMargin - 5, currY, xMargin + 5, currY);
      float val = (1/ySpacing) * (yMargin - currY) + yAxisLen * (1/ySpacing);
      text(val, xMargin - 60, currY); 
    }
  }
  
  void drawLines(){
    for(int i = 0; i < points.length -1; i++){
      stroke(color(0, 0,0)); 
      strokeWeight(1);
      line(points[i].x, points[i].y, points[i+1].x, points[i+1].y);
    }
}
}