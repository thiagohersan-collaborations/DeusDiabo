/* @pjs preload="deusdiaboQDD.jpg, http://tec.marginalialab.com/files/2012/11/deusdiabo02.jpg"; */

/********* HTML code:
<!---
<script type="text/javascript" src="processing.js"></script>
<canvas data-processing-sources="DeusDiaboProcessing.pde"></canvas>
--->
*****/


PImage img0, img1;
PGraphics tri, sem;

float rt, rc;

boolean needsUpdate;

void setup() {
  size(341, 520);
  //smooth();
  noStroke();

  //img0 = loadImage("http://tec.marginalialab.com/files/2012/11/deusdiabo02.jpg");
  img0 = loadImage("deusdiaboQDD.jpg");
  img1 = createImage(img0.width, img0.height, ARGB);

  rt = rc = 0;
  needsUpdate = true;

  tri = createGraphics(width, height);
  sem = createGraphics(width, height);
}

void draw() {
  if (needsUpdate) {
    update();
  }
  image(img1, 0, 0);
}

void update() {
  sem.beginDraw();
  sem.smooth();
  sem.background(255, 255);
  sem.stroke(255, 255, 0, 255);
  sem.noStroke();
  sem.fill(255, 255, 0, 255);
  sem.pushMatrix();
  sem.translate(width/2, height/2);
  sem.rotate(rc);
  sem.arc(0, 0, min(width, height), min(width, height), 0, PI);
  //sem.ellipse(0,0,min(width, height), min(width, height));
  sem.popMatrix();
  sem.endDraw();

  tri.beginDraw();
  tri.smooth();
  tri.background(255, 255);
  tri.stroke(255, 0, 255, 255);
  tri.noStroke();
  tri.fill(255, 0, 255, 255);
  tri.pushMatrix();
  tri.translate(width/2, height/2);
  tri.rotate(rt);
  tri.triangle(0, -min(width, height)/2, 0.75*min(width, height)/sqrt(3), min(width, height)/4, -0.75*min(width, height)/sqrt(3), min(width, height)/4);
  tri.popMatrix();
  tri.endDraw();

  //sem.blend(tri, 0, 0, tri.width, tri.height, 0, 0, width, height, DARKEST);
  //blend(sem, 0, 0, sem.width, sem.height, 0, 0, width, height, DARKEST);
  //image(img0, 0, 0);

  img1.copy(img0, 0, 0, img0.width, img0.height, 0, 0, img1.width, img1.height);
  img1.blend(sem, 0, 0,  sem.width,  sem.height, 0, 0, img1.width, img1.height, DARKEST);
  img1.blend(tri, 0, 0,  tri.width,  tri.height, 0, 0, img1.width, img1.height, DARKEST);
}

void mouseDragged() {
  if (mouseButton == LEFT) {
    rt += atan2(mouseY-height/2, mouseX-width/2) - atan2(pmouseY-height/2, pmouseX-width/2);
    needsUpdate = true;
  }
  else if (mouseButton == RIGHT) {
    rc += atan2(mouseY-height/2, mouseX-width/2) - atan2(pmouseY-height/2, pmouseX-width/2);
    needsUpdate = true;
  }
}

