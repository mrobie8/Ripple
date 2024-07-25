AEC aec;
float timer;
ArrayList<Ripple> pond;
HashMap<Integer, Integer> lengthInSpace = new HashMap<>(); //trackID and seconds
ArrayList<Integer> people;
ArrayList<Circle> giantRipple;
int giantRippleX = 35;
int giantRippleY = 13;


//water variables
int waterHeight = 120;        // Initial height of the water
float fillSpeed =1.5;          // Speed at which water fills up
float waveFrequency = 0.05; // Frequency of the waves
float waveAmplitude = 18;  // Amplitude of the waves
float waveOffset = 0;      // Offset for animating waves
float ticks;

int crestHeight = 120;        // Initial height of the water
float crestfillSpeed =5;          // Speed at which water fills up
float crestFrequency = 0.05; // Frequency of the waves
float crestAmplitude = 18;  // Amplitude of the waves
float crestOffset = 0;      // Offset for animating waves
float crestticks;




//VARIABLES
color RippleColor = color(130, 220, 245); //color of rippes
int frequency = 40; //frequency of ripples normally my frames
int distCluster = 100; //distance required to form a cluster
float rippleWeight = 0.7; //strokeWeight of the ripples

void setup() {
  frameRate(25);
  size(1200, 400);
  
  aec = new AEC();
  aec.init();
  setupPharus();
  
  timer = 0;
  pond = new ArrayList();
  giantRipple = new ArrayList();
}

void draw() {
  aec.beginDraw();
  background(0,0,0);
  noStroke();
  
  drawPharus();
  
  //WATER-------------------------------
  
  // Draw the wave crests
  fill(184,214,241);          // Set the fill color to blue
  noStroke();               // No border for the water rectangle

  crestticks++;
  if (crestticks%3==0) {
    crestFrequency = random(1, 3); // Frequency of the waves changes
  }
    if (crestticks%5==0) {
    crestAmplitude = random(2, 5);  // Amplitude of the waves changes
    crestfillSpeed = random(1.9, 2);
  }

  beginShape();
  for (float x = 0; x <= width; x += 1) {
    // Calculate y position with a sine wave for the wave effect
    float y = height - crestHeight + crestAmplitude * sin(crestFrequency * x/aec.getScaleX() + crestOffset);
    vertex(x/aec.getScaleX(), y/aec.getScaleY());
  }
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);

  // Increment the crest height
  crestHeight += crestfillSpeed;

  // Stop the crest from overflowing
  if (crestHeight > height+20) {
    crestHeight = (height+20);
  }

  // Animate the wave
  crestOffset += 0.1;
  
 
  // WATER
  fill(15,57,89);          // Set the fill color to blue
  noStroke();               // No border for the water rectangle

  ticks++;
  if (ticks%3==0) {
    waveFrequency = random(.5, 1); // Frequency of the waves changes
  }
    if (ticks%5==0) {
    waveAmplitude = random(2, 3);  // Amplitude of the waves changes
    fillSpeed = random(1.25, 2);
  }

  beginShape();
  for (float x = 0; x <= width; x += 1) {
    // Calculate y position with a sine wave for the wave effect
    float y = height - waterHeight + waveAmplitude * sin(waveFrequency * x/aec.getScaleX() + waveOffset);
    vertex(x/aec.getScaleX(), y/aec.getScaleY());
  }
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);

  // Increment the water height
  waterHeight += fillSpeed;

  // Stop the water from overflowing
  if (waterHeight > height+25) {
    waterHeight = height+25;
  }

  // Animate the wave
  waveOffset += 0.05;
  
  
  
  //RIPPLES-----------------------------------
  
  if (timer >= 275) {
    if (clusterFormed()) {
      createGiantRipple();
    } else {
      giantRipple = new ArrayList();
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

  fill(255,0,100);
  rect(mouseX/aec.getScaleX(),mouseY/aec.getScaleY(),1,1);

  aec.endDraw();
  aec.drawSides();
  timer++;
}

//different ripple objects
interface Ripple {
  void draw();
  void grow();
}


void mouseClicked() {
  //version control
  /** 
  version 1 (Rippe1): 1 ring
  version 2 (Rippe2): 2 rings
  version 3 (Rippe3): 3 rings
  **/
  pond.add(new Ripple1(mouseX/aec.getScaleX(), mouseY/aec.getScaleY()));  
  
  //bug with the edges
  //version 4: realistic pixels
  //pond.add(new Ripple4(mouseX/aec.getScaleX(), mouseY/aec.getScaleY(), 75, 29, 1));
  
  println(mouseX/aec.getScaleX(), mouseY/aec.getScaleY()); 
}

void keyPressed() {
  aec.keyPressed(key);
}
