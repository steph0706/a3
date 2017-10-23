String inFile;

String[] times;
float [] values;
String[] headers;
BarChart barChart;
PieChart pc;
LineChart lineChart;
Animation anim;
void setup() {
  size(800, 600);
  background(color(255, 255, 255));
  surface.setResizable(true);
  parseData();
  println(times.length, values.length);
  pc = new PieChart(times, values);
  barChart = new BarChart(headers[0], headers[1], times, values);
  lineChart = new LineChart(headers[0], headers[1], times, values);
  anim = new Animation(barChart, lineChart, pc);
  anim.bc.render();
}

float weight = 1;
void draw() {
  background(255, 255, 255); 

   //if(!anim.doneWithBars()){
   //  anim.bc.drawGraph();
   //}
   //anim.bc.drawAxes();
   if (!anim.needToDrawArcs)anim.bc.drawGraph();
   anim.b2p();
  //lineChart.render();  
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