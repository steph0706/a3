
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
    
    float xAxisLen = (width - 2 * xMargin);
    float yAxisLen = (height - 2 * yMargin);
    //spacing 

    float xStart = xMargin; 
    float yStart = yMargin; 
    float ySpacing = (yAxisLen) / this.yMax;  
    
   
    for (int i = 0; i < xNum; i++) {
        float x, y; 
        float barHeight = this.data[i] * ySpacing; 
        x = xStart + this.spacing * i; 
        y = (yAxisLen - barHeight) + yMargin;
        Bar bar = new Bar(this.barWidth, barHeight, names[i], x, y);
        bar.drawBar();
        bars[i] = bar;
        /* try rotating text */
        pushMatrix();
        translate(x + (textAscent() + textDescent()), y + barHeight); //change origin 
        rotate(PI/2); //rotate around new origin 
        fill(0);
        text(" " + this.data[i], 0, 0); //put text at new origin 
        popMatrix();
        /* end rotate text */
        
        textAlign(CENTER,TOP); 
        text(names[i], x, y);   
        if (bar.intersect()) {
         fill(0, 255, 0); 
         text(this.names[i], 0, 0);
        } else {
          fill(color(0, 0, 255)); 
        }
        //rect(x, y - barHeight, barWidth, barHeight); 
        
    }
    strokeWeight(1);
    stroke(0);
    fill(255); 
    line(xMargin, yMargin, xMargin, height - yMargin);
    line(xMargin, height - yMargin, width - xMargin, height - yMargin);
  }
}