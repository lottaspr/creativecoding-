// Flower Field Spinner
// Concentric rings of spinning flower shapes — like an ASCII spinner but floral

float t = 0;

final int   PETALS = 6;
final float F_R    = 17;   // flower radius (~34px across)
final float RING_D = 52;   // distance between ring centers
final int   RINGS  = 8;

void setup() {
  size(900, 900);
  smooth();
  noStroke();
}

void draw() {
  background(0);
  translate(width/2, height/2);

  // Whole composition breathes in and out
  float breathe = 1.0 + 0.09 * sin(t * 1.4);
  scale(breathe);

  // Center flower, slightly larger
  flower(0, 0, F_R * 1.5, t * 1.3);

  for (int ring = 1; ring <= RINGS; ring++) {
    float r     = ring * RING_D;
    int   count = max(1, round(TWO_PI * r / (F_R * 2.3)));
    float dir   = (ring % 2 == 0) ? 1.0 : -1.0;

    // Each ring rotates, alternating direction; outer rings slightly faster
    float ringRot = dir * t * (0.22 + ring * 0.03);

    pushMatrix();
    rotate(ringRot);
    for (int j = 0; j < count; j++) {
      float a = TWO_PI * j / count;
      // Flowers spin on their own axis, opposite to ring direction
      float selfSpin = a - dir * t * 2.2;
      flower(cos(a) * r, sin(a) * r, F_R, selfSpin);
    }
    popMatrix();
  }

  t += 0.011;
}

void flower(float x, float y, float r, float spin) {
  pushMatrix();
  translate(x, y);
  rotate(spin);

  // Soft pink halo so flowers glow against black
  fill(255, 105, 180, 20);
  ellipse(0, 0, r * 3.4, r * 3.4);

  // Petals
  fill(255, 105, 180);
  for (int p = 0; p < PETALS; p++) {
    pushMatrix();
    rotate(TWO_PI * p / PETALS);
    ellipse(0, -r * 0.62, r * 0.5, r * 0.96);
    popMatrix();
  }

  // Bright center dot
  fill(255, 218, 235);
  ellipse(0, 0, r * 0.72, r * 0.72);

  popMatrix();
}
