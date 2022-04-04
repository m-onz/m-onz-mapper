
/*

  vertical lines - m-onz 2022
  
  toggle control panel with the "e" key

  projection mapping installation code.
  consisting of any number of lines.
  intended to eventually run on raspberry pi's using processing. 3.5  
  
*/

JSONObject json;
ArrayList<Line> lines;

void setup() {
  fullScreen();
  lines = new ArrayList<Line>();
  smooth();
  colorMode(HSB);
  loadData(); 
  controlSetup();
  //setupOSC ();
  noCursor();
}

void draw() {
  strokeWeight(globalStrokeWeight);
  if (millis() % 66000 < 33000) {
    background(globalBackgroundColor);
  } else if (!configurationMode) {
    fill (0, noise(frameCount * PI / 300)*11);
    noStroke();
    rect(0, 0, width, height);
  } else {
    background(globalBackgroundColor);  
  }
  
  for (int i = lines.size()-1; i >= 0; i--) { 
    Line line = lines.get(i);
    line.display();
  }
  
  if (configurationMode == true) {
    stroke(255);
    line(0, mouseY, width, mouseY);
    line(mouseX, 0, mouseX, height);
  }
}

void mousePressed() {
  for (int i = lines.size()-1; i >= 0; i--) { 
    Line line = lines.get(i);
    line.mousePressed();
  }
  //testOSC();
}

void mouseDragged() {
  for (int i = lines.size()-1; i >= 0; i--) { 
    Line line = lines.get(i);
    line.mouseDragged();
  }
}

void mouseReleased() {
  for (int i = lines.size()-1; i >= 0; i--) { 
    Line line = lines.get(i);
    line.mouseReleased();
  }
}

void loadData () {
  json = loadJSONObject("lines.json");
  JSONArray lineData = json.getJSONArray("lines");
  int i = 0;
  for (; i < lineData.size(); i++) {
    JSONObject line = lineData.getJSONObject(i); 
    int x1 = line.getInt("x1");
    int y1 = line.getInt("y1");
    int x2 = line.getInt("x2");
    int y2 = line.getInt("y2");
    lines.add(new Line(this, x1, y1, x2, y2, i));
  }
  //lines.add(new Line(this, (int)random(width), (int)random(height), (int)random(width), (int)random(height), i++));
}
