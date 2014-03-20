// Press [SPACE] to cycle through color schemes
// Press [+] to add a new bubble
// Press [-] to remove a bubble
// Press '[' to reduce radius
// Press ']' to increase radius

import java.util.*; 

ArrayList points = new ArrayList();
Random die = new Random(); // for movement
float[][] distlookup; // optimize distance calculations
public int BUBBLES = 160;
float R = 50.0; // radius of metaballs
float THRESHOLDVAL = 50.0; // threshold for inside/outside set
final int RES = 2; //size of one metaball "pixel", bigger is faster but rougher

// colors
int mode = 0; // color modes
color[][] palette;

// screen values
int w = 1000;
int h = 1000;
int halfW = (int)Math.round(w/2);
int halfH = (int)Math.round(h/2);
int diag = (int)Math.round(Math.sqrt( w*w + h*h ));

void setup() 
{
  size(w, h);
  noStroke();
  
  // pre-compute distances up to the max window diagonal
  distlookup = new float[diag][diag]; 
  for (int i = 0; i < diag; i++) {
    for (int j = 0; j < diag; j++) {
      distlookup[i][j]=(float)Math.sqrt(Math.pow(i,2) + Math.pow(j,2));
    }
  }
  println("setup lookup table");
  
  for (int i = 0; i < BUBBLES; i++) {
    points.add(new Attractor());    
  };
  // different colour schemes
  palette = new color[][]{
    {color(0), color(255)},
    {color(255, 0, 0), color(0, 255, 0)},
    {color(255, 255, 0), color(0, 0, 255)}
  };
}

//float y = 100;

void draw() 
{ 
  background(0);   // Set the background to black
  fill(255);
  
  for (int x = 0; x < halfW; x += RES) {
    for (int y = 0; y < halfH; y += RES) {
      int nearest = 0;
      float disst = 0.0;
      for (int p = 0; p < points.size(); p++) {
        Attractor a = (Attractor)points.get(p);
        disst += R * (1.0/a.distanceTo(x, y));
      }
      fill(palette[mode][0]);
      if (disst > THRESHOLDVAL) {
        fill(palette[mode][1]);
      }
      rect(x<<1, y<<1, 1, 1);
    }
  }
  
  for (int i = 0; i < points.size(); i++) {
    Attractor a = (Attractor)points.get(i);
    a.move();
  }
  
  if (frameCount%30 == 0) {
    // uncomment following line to check frameRate 
    print(frameRate + " fps\n") ;
  }
}

void keyPressed() {
  if (key == ' ') {
    // SPACE : cycle through display modes
    mode = (mode + 1)%3;
  }
  if (key == '+' || key == '=') {
    // + key to add a new bubble
    points.add(new Attractor());       
  }
  if (key == '-' || key == '_') {
    // - key to remove a bubble
    if (points.size() > 1) points.remove(points.get(points.size() - 1));
  }
  if (key == ']' || key == '}') {
    // increase radius
    R = R + 1.0;
  }
  if ((key == '[' || key == '{') && R > 5.0) {
    // decrease radius
    R = R - 1.0;
  }
}
