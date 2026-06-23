// Star Spiral — 5 arms winding outward from center
// Each arm is a curving line of flowers that grows from tiny at the core to large at the tip

float t = 0;

final int   ARMS   = 5;
final int   STEPS  = 75;    // flowers per arm
final float TURNS  = 1.5;   // how many times each arm winds around
final float MAX_R  = 365.0;
final int   PETALS = 6;

void setup() {
  size(900, 900);
  smooth();
  noStroke();
  colorMode(HSB, 360, 100, 100, 100);
}

void draw() {
  background(0, 0, 0);
  translate(width/2, height/2);

  float breathe = 1.0 + 0.08 * sin(t * 1.3);
  scale(breathe);
  rotate(t * 0.2);   // whole star slowly spins

  for (int arm = 0; arm < ARMS; arm++) {
    float armOffset = arm * (TWO_PI / ARMS);
    float armMaxR   = MAX_R + 25 * sin(t * 1.2 + arm * 1.1);  // tips extend and retract

    for (int s = 0; s < STEPS; s++) {
      float frac  = (float)s / (STEPS - 1);
      float angle = frac * TURNS * TWO_PI + armOffset;
      float r     = frac * armMaxR;

      // Snake wave along each arm — wiggles side to side over time
      float wiggle = sin(t * 2.8 + frac * 7.0 + arm * 1.4) * 13;
      float px = cos(angle) * r + -sin(angle) * wiggle;
      float py = sin(angle) * r +  cos(angle) * wiggle;

      float flowerR = map(s, 0, STEPS - 1, 4, 21);    // tiny at center, big at tip
      float hue     = (t * 42 + arm * (360.0 / ARMS) + frac * 110) % 360;
      float sat     = 75 + 22 * sin(t * 2.5 + frac * 6 + arm);
      float bri     = 83 + 17 * sin(t * 2.0 + frac * 5);
      float spin    = t * 2.1 + frac * 9;

      flower(px, py, flowerR, spin, hue, sat, bri);
    }
  }

  // Glowing center core
  for (int i = 5; i >= 0; i--) {
    fill((t * 60 + i * 18) % 360, 65, 100 - i * 7);
    ellipse(0, 0, 14 + i * 9, 14 + i * 9);
  }

  t += 0.011;
}

void flower(float x, float y, float r, float spin, float h, float s, float b) {
  pushMatrix();
  translate(x, y);
  rotate(spin);

  // Glow halo
  fill(h, s, b, 18);
  ellipse(0, 0, r * 3.6, r * 3.6);

  // Petals
  fill(h, s, b);
  for (int p = 0; p < PETALS; p++) {
    pushMatrix();
    rotate(TWO_PI * p / PETALS);
    ellipse(0, -r * 0.62, r * 0.5, r * 0.96);
    popMatrix();
  }

  // Bright center dot
  fill(h, 25, 100);
  ellipse(0, 0, r * 0.72, r * 0.72);

  popMatrix();
}
