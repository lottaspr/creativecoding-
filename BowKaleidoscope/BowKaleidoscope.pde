// Hello Kitty Bow Kaleidoscope
// 8-fold rotational symmetry with mirrored segments and HSB color cycling

final int SEGS = 8;
float t = 0;

void setup() {
  size(800, 800);
  smooth();
  strokeJoin(ROUND);
  strokeCap(ROUND);
  colorMode(HSB, 360, 100, 100, 100);
}

void draw() {
  // Semi-transparent overlay creates motion trails
  noStroke();
  fill(300, 80, 7, 22);
  rect(0, 0, width, height);

  translate(width/2, height/2);
  rotate(t * 0.2);

  // Primary layer: 4 rings of bows, 8-fold symmetry
  for (int i = 0; i < SEGS; i++) {
    pushMatrix();
    rotate(TWO_PI * i / SEGS);
    if (i % 2 == 1) scale(-1, 1);  // mirror every other slice

    for (int r = 0; r < 4; r++) {
      float dist = 48 + r * 118;
      float sz   = map(r, 0, 3, 1.45, 0.36);
      float hue  = (t * 38 + i * (360.0 / SEGS) + r * 30) % 360;
      pushMatrix();
      translate(dist, 0);
      scale(sz);
      bow(hue);
      popMatrix();
    }
    popMatrix();
  }

  // Counter-rotating outer ring at offset angle
  rotate(-t * 0.4);
  for (int i = 0; i < SEGS; i++) {
    pushMatrix();
    rotate(TWO_PI * i / SEGS + PI / SEGS);
    if (i % 2 == 0) scale(1, -1);
    pushMatrix();
    translate(200, 0);
    scale(0.45);
    float hue = (t * 52 + i * (360.0 / SEGS) + 180) % 360;
    bow(hue);
    popMatrix();
    popMatrix();
  }

  // Center bloom
  noStroke();
  for (int i = 6; i >= 0; i--) {
    fill((t * 70 + i * 12) % 360, 75, 100 - i * 8);
    ellipse(0, 0, 18 + i * 9, 18 + i * 9);
  }

  t += 0.004;
}

// Draw one bow with glow layers
void bow(float hue) {
  // Outer glow
  noFill();
  stroke(hue, 50, 100, 15);
  strokeWeight(24);
  wings();

  // Inner glow
  stroke(hue, 65, 100, 32);
  strokeWeight(12);
  wings();

  // Solid body
  fill(hue, 55, 12);
  stroke(hue, 88, 100);
  strokeWeight(5);
  wings();

  // Center knot
  ellipse(0, 0, 40, 40);
}

// Draw both bow wings as bezier shapes
void wings() {
  // Left wing
  beginShape();
  vertex(-6, -13);
  bezierVertex(-22, -82, -108, -82, -120, -3);
  bezierVertex(-110, 55, -25, 82, -6, 13);
  endShape(CLOSE);

  // Right wing (mirror of left)
  beginShape();
  vertex(6, -13);
  bezierVertex(22, -82, 108, -82, 120, -3);
  bezierVertex(110, 55, 25, 82, 6, 13);
  endShape(CLOSE);
}
