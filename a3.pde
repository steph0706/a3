String inFile;
Chart barChart;
String[] times;
float [] values;
String[] headers;
PieChart pc;
void setup() {
  size(800, 600);
  background(color(255, 255, 255));
  surface.setResizable(true);
  parseData();
  println(times.length, values.length);
  pc = new PieChart(times, values);
}

void draw() {
  background(255, 255, 255); 

  pc.draw();
}

void parseData() {
  inFile = "./data.csv";
  String[] lines = loadStrings(inFile); 
  headers = split(lines[0],   ",");
  times = new String[lines.length   -   1]; 
  values = new float [lines.length   -   1];
  
  for(int i = 1; i < lines.length; i++) {       
    String[] data = split(lines[i], ",");
    times[i - 1] = data[0];
    values[i - 1] = float(data[1]);
  }   
  
}