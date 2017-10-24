import processing.sound.*;
SoundFile file;
String inFile;
Button[] buttons;
Button barButt;
Button lineButt;
Button pieButt;
String[] times;
float [] values;
String[] headers;
BarChart barChart;
PieChart pc;
LineChart lineChart;
Animation anim;
boolean clicked = false;
String currChart = "Bar chart";
String nextChart = "";
color[] colorz;

void setup() {
  file = new SoundFile(this, "evolve.mp3");

  size(800, 600);
  background(color(255, 255, 255));
  surface.setResizable(true);
  parseData();
  pc = new PieChart(times, values);
  barChart = new BarChart(headers[0], headers[1], times, values);
  lineChart = new LineChart(headers[0], headers[1], times, values);
  barChart.calcStuff();
  lineChart.calcStuff();
  anim = new Animation(barChart, lineChart, pc);
  colorz = anim.colors.clone();
  background(255, 255, 255); 
  buttons = new Button[3];
  String barText = "Bar chart";
  String lineText = "Line chart";
  String pieText = "Pie chart";
  float maxLen = max(textWidth(barText), textWidth(lineText), textWidth(pieText)) + 10;
  float textX = width - maxLen - 10;
  float buttonY = textAscent() + textDescent() + 30;
  barButt = new Button(maxLen, textAscent() + textDescent() + 10, barText, textX, buttonY);
  lineButt = new Button(maxLen, textAscent() + textDescent() + 10, lineText, textX, buttonY * 2);
  pieButt = new Button(maxLen, textAscent() + textDescent() + 10, pieText, textX, buttonY * 3);
  buttons[0] = barButt;
  buttons[1] = lineButt;
  buttons[2] = pieButt;

}

float weight = 1;

void draw() {
  background(255, 255, 255); 
  rectMode(CORNER);
  textAlign(LEFT);
  if(currChart == "Bar chart" && nextChart == "Line chart"){
     if(anim.b2l()) {
       currChart = "Line chart"; 
       nextChart = "";
       file.stop();
     }
  }
  
  if(currChart == "Line chart" && nextChart == "Bar chart"){
     if(anim.l2b()) {
       currChart = "Bar chart"; 
       nextChart = "";
       file.stop();
     }
  }
  
  if(currChart == "Bar chart" && nextChart == "Pie chart"){
     if(anim.b2p()) {
       currChart = "Pie chart"; 
       nextChart = "";
       file.stop();
     }
  }
  
  if(currChart == "Pie chart" && nextChart == "Bar chart"){
     if(anim.p2b()) {
       currChart = "Bar chart"; 
       nextChart = "";
       file.stop();
     }
  }
  
  if(currChart == "Pie chart" && nextChart == ""){
     anim.pc.draw(); 
     lineButt.grey = true;
  }
  
  if(currChart == "Line chart" && nextChart == ""){
         anim.lc.render(); 
         anim.bc.drawAxes();
         pieButt.grey = true;
  }
  
  if(currChart == "Bar chart" && nextChart == ""){
     anim.bc.drawAxes();
     anim.bc.drawGraph();
     pieButt.grey = false;
     lineButt.grey = false;
  }
  
  barButt.drawButton();
  lineButt.drawButton();
  pieButt.drawButton();
   //if(!anim.doneWithBars()){
   //  anim.bc.drawGraph();
   //}
   //anim.bc.drawAxes();
   //if (!anim.needToDrawArcs)anim.bc.drawGraph();
   //anim.b2p();
  //lineChart.render();  
  //anim.lc.render();
  //anim.l2b();
  //anim.b2l();
  //anim.b2p();
  //anim.p2b();
  //anim.pc.draw();
}

void parseData() {
  inFile = "./data.csv";
  String[] lines = loadStrings(inFile); 
  headers = split(lines[0], ",");
  times = new String[lines.length   -   1]; 
  values = new float [lines.length   -   1];

  for (int i = 1; i < lines.length; i++) {       
    String[] data = split(lines[i], ",");
    times[i - 1] = data[0];
    values[i - 1] = float(data[1]);
  }
}

void mouseClicked() {
  file.stop();
 for (Button b : buttons) {
  if (b.intersect()) {
      pc = new PieChart(times, values);
      barChart = new BarChart(headers[0], headers[1], times, values);
      lineChart = new LineChart(headers[0], headers[1], times, values);
      barChart.calcStuff();
      lineChart.calcStuff();
      anim = new Animation(barChart, lineChart, pc);
      anim.colors = colorz.clone();
      anim.setColors();
      file.play();

     if (b.text == "Bar chart" && currChart == "Line chart"){
       nextChart = "Bar chart";
     }
     
     if (b.text == "Bar chart" && currChart == "Pie chart"){
       nextChart = "Bar chart";
     }
     
     if (b.text == "Line chart" && currChart == "Bar chart"){
       nextChart = "Line chart";
     }
   
   //if (b.text == "Line chart" && currChart == "Pie chart"){
   //  anim.p2b();
   //  currChart = "Bar chart";
   //}
   
   if (b.text == "Pie chart" && (currChart == "Bar chart" || currChart == "default")){
     nextChart = "Pie chart";
   }
   
   //if (b.text == "Bar chart" && currChart == "Pie chart"){
   //  anim.p2b();
   //  currChart = "Bar chart";
   //}
   
  }
 }
}