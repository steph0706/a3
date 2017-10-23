class PieChart {
  String[] names;
  float[] data;
  float radius;
  Pie [] pies;
  
  PieChart(String[] names, float[] data) {
    this.names = names;
    this.data = data;    
    pies = new Pie[names.length];
  }
  
  void draw() {
   calcPie(); 
   for(Pie p: pies){
     if (p.intersect()){
       p.hoverText(mouseX, mouseY);
     }
    }
}
  
  void calcPie() {
    float currAngle = radians(0);
    float sum = calcSum();
    for (int i = 0; i < data.length; i++) {
      float p = (data[i]/sum) * 360;
      p = radians(p);
      radius = 2 * (height * 0.9) / TWO_PI; 
      Pie pie = new Pie(names[i], data[i], currAngle, currAngle + p, radius);
      pie.drawPie();
      pies[i] = pie;
      currAngle += p;
    }

  }
  
  float calcSum() {
    float sum = 0;
    for (int i = 0; i < data.length; i++) {
      sum += data[i];
    }
    return sum;
  }
  
}