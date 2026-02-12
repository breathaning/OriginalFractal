color FILL_COLOR = color(255, 255, 0);
color STROKE_COLOR = color(0, 0, 0);
int RESOLUTION = 100;

double zoom = 1;
double cameraX = 0;
double cameraY = 0;

float faceSize = 400;
float eyeSize = 50;

void setup() {
  size(500, 500);
}

void draw() {
  background(STROKE_COLOR);
  drawSmile(width / 2 - (float)(cameraX * zoom), height / 2 - (float)(cameraY * zoom), faceSize * (float)zoom, RESOLUTION);
}

void mouseWheel(MouseEvent event) {
  double speed = Math.pow(0.9, event.getCount());
  zoom *= speed;
  cameraX += (1 - 1 / speed) * (mouseX - width / 2) / zoom;
  cameraY += (1 - 1 / speed) * (mouseY - height / 2) / zoom;
}

void mouseDragged() {
  cameraX += (pmouseX - mouseX) / zoom;
  cameraY += (pmouseY - mouseY) / zoom;
}

void drawSmile(float x, float y, float size, int depth) {
  if (size <= 0.1) {
    return;
  }

  fill(FILL_COLOR);
  stroke(STROKE_COLOR);
  strokeWeight(Math.max(size / 40, 1));
  ellipse(x, y, size, size);
  arc(x, y, size * 2 / 3, size * 2 / 3, 0, PI);

  float drawSize = size * eyeSize / faceSize;

  if (depth > 0) {
    drawSmile(x + size / 5, y - size / 5, drawSize, depth - 1);
    drawSmile(x - size / 5, y - size / 5, drawSize, depth - 1);
    return;
  }

  fill(STROKE_COLOR);
  noStroke();
  ellipse(x + size / 5, y - size / 5, drawSize, drawSize);
  ellipse(x - size / 5, y - size / 5, drawSize, drawSize);
}
