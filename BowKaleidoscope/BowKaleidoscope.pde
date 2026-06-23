// Hello Kitty Bow Kaleidoscope
// Hot pink bow character, 8-fold symmetry, breathing + spinning motion

final int SEGS = 8;
final color PINK = color(255, 105, 180);
float t = 0;

void setup() {
  size(800, 800);
  smooth();
  strokeJoin(ROUND);
  strokeCap(ROUND);
  frameRate(60);
}

void draw() {
  background(0);
  translate(width/2, height/2);

  // Breathing: whole composition inhales and exhales
  float breathe = 1.0 + 0.16 * sin(t * 1.5);
  scale(breathe);

  // Slow continuous spin
  rotate(t * 0.22);

  // 8-fold kaleidoscope: mirror every other slice
  for (int i = 0; i < SEGS; i++) {
    pushMatrix();
    rotate(TWO_PI * i / SEGS);
    if (i % 2 == 1) scale(-1, 1);

    // Three rings, each with a slight breathing phase offset for depth
    for (int r = 0; r < 3; r++) {
      float dist      = 72 + r * 128;
      float sz        = map(r, 0, 2, 1.3, 0.44);
      float ringPulse = 1.0 + 0.06 * sin(t * 1.5 + r * 0.9);

      pushMatrix();
      translate(dist, 0);
      scale(sz * ringPulse);
      drawBow();
      popMatrix();
    }

    popMatrix();
  }

  // Center ornament — glowing pink core
  noStroke();
  fill(255, 105, 180, 30);
  ellipse(0, 0, 90, 90);
  fill(255, 105, 180, 70);
  ellipse(0, 0, 54, 54);
  fill(PINK);
  ellipse(0, 0, 28, 28);

  t += 0.015;
}

// Single bow character: hot pink fill, black outline, soft pink halo
void drawBow() {
  // Soft pink glow behind the bow
  noFill();
  stroke(255, 105, 180, 45);
  strokeWeight(18);
  bowShape();

  // Bow body
  fill(PINK);
  stroke(0);
  strokeWeight(4);
  bowShape();
  ellipse(0, 0, 40, 40);
}

// Two bezier wings + the function is reused for glow and fill passes
void bowShape() {
  // Left wing
  beginShape();
  vertex(-6, -13);
  bezierVertex(-22, -82, -108, -82, -120, -3);
  bezierVertex(-110, 55, -25, 82, -6, 13);
  endShape(CLOSE);

  // Right wing
  beginShape();
  vertex(6, -13);
  bezierVertex(22, -82, 108, -82, 120, -3);
  bezierVertex(110, 55, 25, 82, 6, 13);
  endShape(CLOSE);
}
