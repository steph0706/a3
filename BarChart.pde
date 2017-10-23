
class BarChart {
  String[] names;
  float[] data;
  Bar [] bars;
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


  BarChart(String xTitle, String yTitle, String[] days, float [] values) {
    this.xTitle = xTitle;
    this.yTitle = yTitle;
    this.names = days;
    this.data = values;
    this.yMin = min(values);
    this.yMax = max(values); 
    this.xNum = days.length; 
    bars = new Bar[this.xNum];
    this.spacing = (width - 2 * xMargin)/xNum; 
    this.barWidth = this.barFill * spacing;
  }

  void render() { 
    
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
        Bar bar = new Bar(this.barWidth, barHeight, names[i], x, y);
        bar.drawBar();
        bars[i] = bar;
        
        if (bar.intersect()) {
         fill(0, 255, 0); 
         text(this.names[i], 0, 0);
        } else {
          fill(color(0, 0, 255)); 
        }        
    }
  
  //drawAxes();
  }
  
void drawAxes(){
       for(int i = 0; i < data.length; i++){
        float x, y; 
        float barHeight = this.data[i] * ySpacing; 
        x = xMargin + this.spacing * i; 
        y = (yAxisLen - barHeight) + yMargin;
        /* try rotating text */
        pushMatrix();
        translate(x + 5, y + barHeight); //change origin 
        rotate(PI/2); //rotate around new origin 
        fill(0);
        text(" " + this.names[i], 0, 0); //put text at new origin 
        popMatrix();
        /* end rotate text */
     }
     
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

  void drawGraph(){
     for(Bar bar : bars){
        bar.drawBar(); 
     }
    
     //drawAxes();

  }
}