class Attractor {
  
  public int x;
  public int y;
  public int dx;
  public int dy;
  public float r, g, b;
  
  public Attractor() {
    this.x = die.nextInt(halfW);
    this.y = die.nextInt(halfH);
    this.dx =- 2 + die.nextInt(4);
    this.dy =- 2 + die.nextInt(4);
    this.r = (float)die.nextInt(255);
    this.g = (float)die.nextInt(255);
    this.b = (float)die.nextInt(255);
  }
  
  public void move() {
    // move bubble
    // makes it a bit more lava-lampy by emphasising dy
    this.x += 1.0 * this.dx;
    this.y += 4.0 * this.dy; 
    if (this.x < 0 || this.x > halfH) this.dx =- this.dx;
    if (this.y < 0 || this.y > halfW) this.dy =- this.dy;
  }
  
  public float distanceTo(int xx, int yy) {
    // Euclidian Distance 
      return distlookup[Math.abs(xx - this.x)][Math.abs(yy - this.y)];
  }
}
