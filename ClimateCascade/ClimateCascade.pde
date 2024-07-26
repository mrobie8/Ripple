
AEC aec;
float timer;
ArrayList<Ripple> pond;

color RippleColor = color(255); //color of rippes
int frequency = 40; //frequency of ripples normally my frames
int distCluster = 100; //distance required to form a cluster
float rippleWeight = 0.7; //strokeWeight of the ripples
int waterFinalHeight = 3; // default is 1, make greater if want water to go to top for fish bowl

void setup() {
  frameRate(25);
  size(1200, 400);
  
  aec = new AEC();
  aec.init();
  setupPharus();
  
  timer = 0;
  pond = new ArrayList();
  giantRipple = new ArrayList();
  colorMode(RGB, 255);
}

void draw() {
  aec.beginDraw();
  background(0,0,0);
  noStroke();
  
  drawPharus();
  
  water();
  
  if (timer >= 280) {
    if (clusterFormed()) {
      createGiantRipple();
    } else {
      giantRipple = new ArrayList();
      giantRippleColor = color(255);
      for (int i = 0; i < pond.size(); i++) {
        pond.get(i).draw();
        pond.get(i).grow();
      }
      for (Integer key : lengthInSpace.keySet()) {
        lengthInSpace.put(key, lengthInSpace.get(key) + 1);
      }
    }
  }
  
  //grid lines
  stroke(0, 255, 0);
  strokeWeight(0.15);
  line(10, 0, 10, 30);
  line(20, 0, 20, 30);
  line(30, 0, 30, 30);
  line(55, 0, 55, 30);
  line(60, 0, 60, 30);
  strokeWeight(1);
  fill(255);
  rect(mouseX/aec.getScaleX(),mouseY/aec.getScaleY(),1,1);

  aec.endDraw();
  aec.drawSides();
  timer++;
}


void mouseClicked() {
  pond.add(new Ripple(mouseX/aec.getScaleX(), mouseY/aec.getScaleY()));  
  
  println(mouseX/aec.getScaleX(), mouseY/aec.getScaleY()); 
}

void keyPressed() {
  aec.keyPressed(key);
}
