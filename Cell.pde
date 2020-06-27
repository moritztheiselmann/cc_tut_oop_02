class Cell {
  int x;
  int y;
  int w;
  int h;
  PGraphics tex;
  float xoff = 0;
  boolean shouldRotate = false;
  float rot;
  float probability;
  int maxRot;
  float rotSpeed;
  boolean drawSolid = false;
  
  Cell(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.xoff = random(0, 90);
    this.rot = 0;
    this.probability = random(0, 0.025);
    this.rotSpeed = random(0.1, 0.2);
    this.maxRot = 360;
    
    this.tex = createGraphics(this.w, this.h, P2D);
  }
  
  void updateTexture(PGraphics texture) {
    
    int sx = this.x/2;
    int sy = this.y/2;
    int sw = this.w/2;
    int sh = this.h/2;
    
    this.tex.beginDraw();
    this.tex.copy(texture, sx, sy, sw, sh, 0, 0, this.w, this.h);
    this.tex.noFill();
    this.tex.stroke(20);
    this.tex.strokeWeight(0.5);
    this.tex.rect(0, 0, this.w, this.h);
    this.tex.endDraw();
  }
  
  //void update() {
  //  if(this.shouldRotate) {
  //    if(this.rot < this.maxRot-1) {  
  //      this.rot = lerp(this.rot, this.maxRot, this.rotSpeed);
  //    }
  //    else {
  //      this.shouldRotate = false;
  //      this.rot = 0;
  //    }
  //  }
  //}
  
  void checkForFace(Rectangle face) {
    PVector fc = getCenter(face.x, face.y, face.width, face.height);
    PVector cc = getCenter(this.x, this.y, this.w, this.h);
    
    fc.x *= 2;
    fc.y *= 2;
    
    float d = dist(fc.x, fc.y, cc.x, cc.y);
    if (d < face.width) {
      shouldRotate = true;
    }
    else {
      shouldRotate = false;
    }
  }
  
  PVector getCenter(int x, int y, int w, int h) {
    return new PVector(x + w / 2, y + h / 2);
  }
  
  void show() {
    pushMatrix();
    translate(this.x+this.w/2, this.y+this.h/2);
    if (shouldRotate) {
      //rotate(radians(this.rot));
      this.rot += 90;
      rotate(radians(rot));
    }
    translate(-(this.x+this.w/2), -(this.y+this.h/2));
    image(this.tex, this.x, this.y);
    popMatrix();
  }
}
