
import garciadelcastillo.dashedlines.*;

class Line {
  DashedLines dash;
  float bx;
  float by;
  float bx2;
  float by2;
  int boxSize = 3;
  boolean overBox = false;
  boolean locked = false;
  float xOffset = 0.0; 
  float yOffset = 0.0; 
  boolean overBox2 = false;
  boolean locked2 = false;
  float xOffset2 = 0.0; 
  float yOffset2 = 0.0; 
  float distAccum = 1;
  float dist = 0;
  float seed = 0;
  float dashSpeed = 0;
  int index = 0;
  
  Line (PApplet theParent, int x1, int y1, int x2, int y2, int _index) {
    dash = new DashedLines(theParent);
    dash.pattern(5, 175);
    bx = x1;
    by = y1;
    bx2 = x2;
    by2 = y2;
    seed = random(10000);
    dashSpeed = random(250) / 1000;
    rectMode(RADIUS);
    index = _index;
  }
  
  void display () {
    
    if (mouseX > bx-boxSize && mouseX < bx+boxSize && 
      mouseY > by-boxSize && mouseY < by+boxSize) {
      overBox = true;  
      if(!locked) { 
        stroke(255); 
        fill(153);
      } 
    } else {
      stroke(153);
      fill(153);
      overBox = false;
    }
    
    if (mouseX > bx-boxSize && mouseX < bx+boxSize && 
      mouseY > by-boxSize && mouseY < by+boxSize) {
      overBox = true;  
      if(!locked) { 
        stroke(255); 
        fill(153);
      } 
    } else {
      stroke(153);
      fill(153);
      overBox = false;
    }
    if (mouseX > bx2-boxSize && mouseX < bx2+boxSize && 
      mouseY > by2-boxSize && mouseY < by2+boxSize) {
      overBox2 = true;  
      if(!locked2) { 
        stroke(255); 
        fill(153);
      } 
    } else {
      stroke(153);
      fill(153);
      overBox2 = false;
    }

    if (configurationMode) {
      rect(bx, by, boxSize, boxSize);
      rect(bx2, by2, boxSize, boxSize);
      stroke(255);
      line(bx, by, bx2, by2);
      return; 
    }
    
    if (millis() % 66000 > 33000) {
      if (random(100)>50) {
        stroke(noise(frameCount*PI/3000 + seed) * 255);
      } else { stroke(255); }
    } else {
      stroke(noise(frameCount * PI /90+seed) * 255, noise(frameCount * PI /9000-seed) * 255, 255);
    }
    if (millis() % 66000 > 33000) {
      if (random (100) > noise(frameCount*PI/200) * 5 + 95) {
        stroke(255);
        line(bx, by, bx2, by2); 
      }
    } else {
      dash.line(bx, by, bx2, by2);
    }
    dash.offset(dist);
    dist += 0.001 + (distAccum * dashSpeed);
    if (random(100) > 99 && random(100) > 99) {
      dash.pattern((int) random(50), (int) random(50));
    }
    if (random(100) > 99) {
      dash.pattern((int) 1+random(30), (int) 1+random(30));
    }
    if (random(100) > 99) dashSpeed = random(500) / 1000;
    distAccum += (noise(frameCount * PI / 2000 + seed) * 0.001);
  }
  
  void mousePressed() {
    if(overBox) { 
      locked = true; 
      fill(255, 255, 255);
    } else {
      locked = false;
    }
    xOffset = mouseX-bx; 
    yOffset = mouseY-by; 
    
    if(overBox2) { 
      locked2 = true; 
      fill(255, 255, 255);
    } else {
      locked2 = false;
    }
    xOffset = mouseX-bx; 
    yOffset = mouseY-by;
    xOffset2 = mouseX-bx2; 
    yOffset2 = mouseY-by2; 
  }
  
  void mouseDragged() {
    if(locked) {
      bx = mouseX-xOffset; 
      by = mouseY-yOffset; 
    }
    if(locked2) {
      bx2 = mouseX-xOffset2; 
      by2 = mouseY-yOffset2; 
    }
  }
  
  void mouseReleased() {
    locked = false;
    locked2 = false;
    
    json = loadJSONObject("lines.json");
    JSONArray lineData = json.getJSONArray("lines");
    JSONObject newLine = new JSONObject();
    newLine.setInt("x1", (int) bx);
    newLine.setInt("y1", (int) by);
    newLine.setInt("x2", (int) bx2);
    newLine.setInt("y2", (int) by2);
    lineData.setJSONObject(index, newLine);
    saveJSONObject(json, "data/lines.json");
  }
}
