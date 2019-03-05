PImage groundTexture, camouflageTexture;
PShape house, tree, car;
float cameraAngle, rotx, roty;

void setup() {
  size(1200, 800, P3D);
  cameraAngle = 45;
  rotx = PI/4;
  roty = PI/4;

  groundTexture = loadImage("./images/ground.jpg");
  camouflageTexture = loadImage("./images/camouflage.jpg");

  house = loadShape("./figures/house/house.obj");
  tree = loadShape("./figures/tree/tree.obj");
  car = loadShape("./figures/car/car.obj");

  car.setTexture(camouflageTexture);
}

void draw() {
  background(200);

  displayText();

  lights();
  ambientLight(24, 12, 147);

  directionalLight(95, 58, 153, -1, 0, 0);
  directionalLight(214, 95, 36, 0, 0, 1);

  pointLight(204, 23, 187, mouseX, mouseY, 550);

  if (mousePressed) {
    rotateX(rotx);
    rotateY(roty);
  } else {
    camera(cos(radians(cameraAngle)) * 900, -400, sin(radians(cameraAngle)) * 900, 0, 0, 0, 0, 1, 0);
  }

  displayGround(groundTexture, 600, 5, 600);
  displayHouse();
  displayTree();
  displayRoad();
  displayCar();

  if (keyPressed) {
    if (key == 'e' || key == 'E') {
      cameraAngle -= 5;
    } else if (key == 'q' || key == 'Q') {
      cameraAngle += 5;
    }
  }
}

void displayHouse() {
  pushMatrix();
  pushStyle();

  emissive(124, 65, 24);
  rotateY(radians(180));
  rotateX(radians(180));
  translate(250, 0, -250);
  scale(75);
  specular(0, 50, 100);
  shininess(10);
  shape(house);

  popStyle();
  popMatrix();
}

void displayTree() {
  pushMatrix();
  pushStyle();

  emissive(142, 69, 36);
  rotateY(radians(180));
  rotateX(radians(180));
  translate(-200, 0, -250);
  scale(10);
  specular(36, 95, 78);
  shininess(100);
  shape(tree);

  popStyle();
  popMatrix();
}

void displayCar() {
  pushMatrix();
  pushStyle();

  emissive(90, 255, 69);
  rotateY(radians(90));
  rotateX(radians(180));
  translate(-150, 0, -200);
  scale(1.5);
  specular(97, 64, 255);
  shininess(150);
  shape(car);

  popStyle();
  popMatrix();
}

void displayRoad() {
  pushMatrix();

  translate(-600, -6, 100);
  rotateX(radians(90));

  fill(0);
  rect(0, 0, 1200, 250);

  translate(0, 0, 1);
  fill(255);
  for (int i = 0; i < 1200; i+=100)
    rect(i, 120, 100, 20);

  popMatrix();
}

void mouseDragged() {
  float rate = 0.01;
  rotx += (pmouseY-mouseY) * rate;
  roty += (mouseX-pmouseX) * rate;
}

void displayGround(PImage texture, int groundWidth, int groundHeight, int groundDeep) {
  beginShape(QUADS);
  texture(texture);

  // +Z "front" face
  vertex(-groundWidth, -groundHeight, groundDeep, 0, 0);
  vertex( groundWidth, -groundHeight, groundDeep, groundHeight, 0);
  vertex( groundWidth, groundHeight, groundDeep, groundHeight, groundHeight);
  vertex(-groundWidth, groundHeight, groundDeep, 0, groundHeight);

  // -Z "back" face
  vertex( groundWidth, -groundHeight, -groundDeep, 0, 0);
  vertex(-groundWidth, -groundHeight, -groundDeep, groundHeight, 0);
  vertex(-groundWidth, groundHeight, -groundDeep, groundHeight, groundHeight);
  vertex( groundWidth, groundHeight, -groundDeep, 0, groundHeight);

  // +Y "bottom" face
  vertex(-groundWidth, groundHeight, groundDeep, 0, 0);
  vertex( groundWidth, groundHeight, groundDeep, groundWidth, 0);
  vertex( groundWidth, groundHeight, -groundDeep, groundWidth, groundWidth);
  vertex(-groundWidth, groundHeight, -groundDeep, 0, groundWidth);

  // -Y "top" face
  vertex(-groundWidth, -groundHeight, -groundDeep, 0, 0);
  vertex( groundWidth, -groundHeight, -groundDeep, groundWidth, 0);
  vertex( groundWidth, -groundHeight, groundDeep, groundWidth, groundWidth);
  vertex(-groundWidth, -groundHeight, groundDeep, 0, groundWidth);

  // +X "right" face
  vertex( groundWidth, -groundHeight, groundDeep, 0, 0);
  vertex( groundWidth, -groundHeight, -groundDeep, groundWidth, 0);
  vertex( groundWidth, groundHeight, -groundDeep, groundWidth, groundWidth);
  vertex( groundWidth, groundHeight, groundDeep, 0, groundWidth);

  // -X "left" face
  vertex(-groundWidth, -groundHeight, -groundDeep, 0, 0);
  vertex(-groundWidth, -groundHeight, groundDeep, groundWidth, 0);
  vertex(-groundWidth, groundHeight, groundDeep, groundWidth, groundWidth);
  vertex(-groundWidth, groundHeight, -groundDeep, 0, groundWidth);

  endShape();
}


void displayText() {
  pushMatrix();
  pushStyle();

  translate(-300, -300, 0);
  textSize(40);
  fill(0);
  text("Press q/e to rotate camera right/left", -200, -100, 0);
  text("Drag the mouse to see another perspective of the scene", -200, -50, 0);

  popStyle();
  popMatrix();
}
