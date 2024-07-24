AEC aec;
float timer;
int glacierCount = 0;

void setup() {
  frameRate(25);
  size(1200, 400);
  
  aec = new AEC();
  aec.init();
  timer = 0;
}

void draw() {
  aec.beginDraw();
  background(0,0,0);
  noStroke();
  
  //glaciers
  if (timer % 75 == 0) {
    glacierCount ++;
  }
  if (timer < 1400) {
    glaciers(glacierCount);
  }
  
  //glaciers(glacierCount);
  
  
  
 

  //grid lines
  //stroke(0, 255, 0);
  //strokeWeight(0.15);
  //line(10, 0, 10, 30);
  //line(20, 0, 20, 30);
  //line(30, 0, 30, 30);
  //line(55, 0, 55, 30);
  //line(60, 0, 60, 30);
  //strokeWeight(1);

  fill(255,0,100);
  rect(mouseX/aec.getScaleX(),mouseY/aec.getScaleY(),1,1);

  aec.endDraw();
  aec.drawSides();
  timer ++;
}

void glaciers(int y) {
  randomSeed(1);
  fill(255);
  //first section
  rect(0, y + 13, 10, 20);
  rect(2, y + 11, 7, 2);
  rect(3, y + 9, 4, 2);
  
 
  //second section
  rect(10,  y + 12, 7, 20);
  rect(11,  y + 11, 5, 2);
  rect(12,  y + 10, 2, 1);
  rect(17,  y + 14, 2, 20);
  rect(19,  y + 16, 2, 20);
  
  //third section
  rect(21,  y + 14, 2, 20);
  rect(23,  y + 12, 3, 20);
  rect(26,  y + 11, 3, 20);
  rect(29,  y + 8, 4, 20);
  
  //fourth section
  rect(33,  y + 7, 2, 20);
  rect(35,  y + 8, 1, 20);
  rect(36,  y + 9, 2, 20);
  rect(38,  y + 12, 2, 20);
  
  //triangles
  fill(188, 230, 242);
  triangle(0,  y + 16, 0,  y + 25, 3,  y + 25);
  triangle(3,  y + 25, 3,  y + 19, 6,  y + 25);
  triangle(6,  y + 25, 8,  y + 15, 9,  y + 25);
  triangle(7,  y + 25, 11,  y + 16, 12,  y + 25);
  triangle(12,  y + 25, 11,  y + 16, 18,  y + 25);
  triangle(30,  y + 26, 33,  y + 26, 32,  y + 18);
  triangle(32,  y + 26, 37,  y + 26, 34,  y + 12);
  triangle(36,  y + 26, 40,  y + 26, 38,  y + 20);
  rect(36, y + 12,1,1);
  rect(27, y + 17,1,1);
  rect(31, y + 16,1,1);
  rect(38, y + 20,1,1);
  
  fill(83, 189, 239);
  triangle(0,  y + 20, 0,  y + 25, 2,  y + 25);
  triangle(3,  y + 25, 3,  y + 23, 6,  y + 25);
  triangle(7,  y + 25, 8,  y + 17, 8,  y + 25);
  triangle(7,  y + 25, 11,  y + 16, 12,  y + 25);
  triangle(30,  y + 26, 33,  y + 26, 32,  y + 22);
  triangle(32,  y + 26, 37,  y + 26, 34,  y + 17);
  triangle(36,  y + 26, 39,  y + 26, 38,  y + 24);
  rect(13,y+22,1,2);
  rect(28,y+18,1,2);
  rect(37,y+13,1,1);
}



void mouseClicked() {
  println(mouseX/aec.getScaleX(), mouseY/aec.getScaleY()); 
}

void keyPressed() {
  aec.keyPressed(key);
}
