import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;

Movie myMovie;
PGraphics pg;
ArrayList<Cell> cells;
int cNum = 20;

OpenCV opencv;


void setup() {
  size(1280, 720, P2D);
  
  // setup opencv
  opencv = new OpenCV(this, width/2, height/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 
  
  // setup video
  myMovie = new Movie(this, "output.mov"); //<>//
  myMovie.loop();
  myMovie.play();
  
  // setup pgraphics
  pg = createGraphics(width/2, height/2, P2D);
  cells = new ArrayList<Cell>();
  
  // define grid, create cell objects and store in arraylist
  int cellSize = width / cNum;
  for(int y = 0; y < cNum; y++) {
    int yoff = cellSize * y;
    for(int x = 0; x < cNum; x++) {
      int xoff = cellSize * x;
      Cell c = new Cell(xoff, yoff, cellSize, cellSize);
      c.updateTexture(pg);
      cells.add(c);
    }
  }

}

void draw() {
  background(20);
  // get latest frame from video
  myMovie.read();
 
  // draw latest frame to pgraphics
  pg.beginDraw();
  pg.background(20);
  pg.image(myMovie, 0, 0);
  pg.endDraw();
  
  
  // update opencv and try to detect face
  opencv.loadImage(pg);
  Rectangle[] faces = opencv.detect();
  
  // pass latest frame to each cell
  // and draw cell to canvas
  for(Cell c : cells) {
    c.updateTexture(pg);
    //c.update();
    c.show();
  }
  
  for(Cell c : cells) {
    if(faces.length == 1) {
      c.checkForFace(faces[0]);
    }
  }
 
  // draw rect at face center
  //for(int i = 0; i < faces.length; i++) {
  //  noFill();
  //  stroke(255, 0, 0);
  //  rect(faces[i].x*2, faces[i].y*2, faces[i].width*2, faces[i].height*2);
  //}
  
  // print framerate to console
  println(frameRate);
}
