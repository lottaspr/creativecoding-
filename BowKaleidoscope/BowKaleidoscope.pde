// Flower Spiral — Fibonacci / sunflower arrangement
// Color waves ripple outward along spiral arms as the whole thing rotates

float t = 0;

final int   N            = 380;
final float GOLDEN_ANGLE = radians(137.508);
final float SPREAD       = 13.5;
final int   PETALS       = 6;

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
  rotate(t * 0.18);

  for (int n = 0; n < N; n++) {
    float baseAngle  = n * GOLDEN_ANGLE;
    float baseRadius = SPREAD * sqrt(n);

    // Ripple wave pulses outward along the spiral — main trippy effect
    float ripple = sin(t * 2.5 + baseRadius * 0.055) * 16;
    float radius  = baseRadius + ripple;

    float x = cos(baseAngle) * radius;
    float y = sin(baseAngle) * radius;

    float r   = map(n, 0, N, 5, 19);         // small at center, large at edge
    float hue = (t * 45 + n * 0.9) % 360;   // rainbow crawls along arms over time
    float sat = 72 + 22 * sin(n * 0.5 + t * 3.0);   // saturation ripple
    float bri = 85 + 15 * sin(n * 0.7 + t * 2.3);   // brightness ripple

    pushMatrix();
    translate(x, y);
    rotate(t * 1.8 + n * 0.15);  // each flower spins on its own axis

    // Glow halo
    fill(hue, sat, bri, 18);
    ellipse(0, 0, r * 3.6, r * 3.6);

    // Petals
    fill(hue, sat, bri);
    for (int p = 0; p < PETALS; p++) {
      pushMatrix();
      rotate(TWO_PI * p / PETALS);
      ellipse(0, -r * 0.62, r * 0.5, r * 0.96);
      popMatrix();
    }

    // Bright center
    fill(hue, 28, 100);
    ellipse(0, 0, r * 0.72, r * 0.72);

    popMatrix();
  }

  t += 0.011;
}
