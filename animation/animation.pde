String inFile;
Chart barChart;
String[] times;
float [] values;
String[] headers;
void setup() {
   size(1024, 768);
  background(color(255, 255, 255));
  surface.setResizable(true);
}

void draw() {
  parseData();
  barChart = new Chart(headers[0], headers[1], times, values);
  barChart.render(0, 0);
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