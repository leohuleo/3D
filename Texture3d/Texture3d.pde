//pallet
color black = #000000;
color white = #FFFFFF;

boolean up, down, left,right;
final int gridSize = 10;
PVector direction = new PVector(0,-10);
PVector direction90 = new PVector(10,0);
float lx = 0,ly = height/2 + 300, lz =0;
float headAngle = 0.01;

PImage dT;
PImage dS;
PImage dB;
PImage map;
float rotX, rotY,rotZ;
void setup(){
  size(800,800,P3D);
  dT = loadImage("dirt_top.jpg");
  dS = loadImage("dirt_side.jpg");
  dB = loadImage("dirt_bottom.jpg");
  map = loadImage("map.png");
  textureMode(NORMAL);
}

void draw(){
  background(255);
  camera(lx,ly,lz,direction.x + lx,ly,direction.y + lz,0,1,0);
  direction.rotate(headAngle);
  headAngle= -(pmouseX - mouseX) * 0.01;
  direction90 = direction.copy();
  direction90.rotate(PI/2);
  if(up){
    lx += direction.x;
    lz += direction.y;
  }
  if(down){
    lz -= direction.y;
    lx -= direction.x;
  }
  if(right){
    lx += direction90.x;
    lz += direction90.y;  
  }
  if(left){
    lx -= direction90.x;
    lz -= direction90.y;
  }
  //pushMatrix();
  //rotateX(rotX);
  //rotateY(rotY);
  drawMap();
  stroke(50);
  strokeWeight(1);
  drawGround();
  //popMatrix();
}
void drawMap(){
  int mapX = 0, mapY = 0;
  int worldX = 0, worldY = height/2, worldZ = 0;
  
  while(mapY < map.height){
    color pixel = map.get(mapX,mapY);
    if(pixel == black){
      worldX = mapX * gridSize;
      worldZ = mapY* gridSize;
      textureBox(dT,dS,dB,worldX, worldY,worldZ,gridSize);
    }
    mapX++;
    if(mapX > map.width){
      mapX = 0;
      mapY++;
    }
  }
}
void drawGround(){
  int x = 0;
  int y = height/2 + gridSize;
  while(x<map.width*gridSize){
  line(x,y, 0,x,y,map.height*gridSize);
  x=x+gridSize * 2;
  }
  int z = 0;
  while(z < map.height*gridSize){
    line(0,y,z,map.width*gridSize,y,z);
    z+=gridSize * 2;
  }
}
void textureBox(PImage top, PImage side, PImage bottom, float x, float y, float z,float size){
   pushMatrix();
  translate(x,y,z);
  scale(size);
  beginShape(QUADS);
  noStroke();
  texture(side);
  //vertex(x,y,z,anchorpointx,anchorpointy)
  //FrontFace
  vertex(-1,-1,1,0,0);
  vertex(-1,1,1,0,1);
  vertex(1,1,1,1,1);
  vertex(1,-1,1,1,0);
  //BackFace
  vertex(-1,-1,-1,0,0);
  vertex(-1,1,-1,0,1);
  vertex(1,1,-1,1,1);
  vertex(1,-1,-1,1,0);
  //LeftFace
  vertex(-1,-1,-1,0,0);
  vertex(-1,1,-1,0,1);
  vertex(-1,1,1,1,1);
  vertex(-1,-1,1,1,0);
  //RightFace
  vertex(1,-1,1,0,0);
  vertex(1,1,1,0,1);
  vertex(1,1,-1,1,1);
  vertex(1,-1,-1,1,0);
  endShape();
  beginShape();
  texture(top);
  //UpperFace
  vertex(-1,-1,1,0,0);
  vertex(1,-1,1,0,1);
  vertex(1,-1,-1,1,1);
  vertex(-1,-1,-1,1,0);
  endShape();
  beginShape();
  texture(bottom);
  //LowerFace
  vertex(-1,1,1,0,0);
  vertex(1,1,1,0,1);
  vertex(1,1,-1,1,1);
  vertex(-1,1,-1,1,0);
  endShape();
  popMatrix();
}

void mouseDragged(){
  rotX = rotX + (pmouseY - mouseY) * 0.01;
  rotY = rotY + (pmouseX - mouseX) * 0.01;
}

void keyPressed(){
  if(keyCode == UP)up = true;
  if(keyCode == DOWN)down = true;
  if(keyCode == LEFT)left = true;
  if(keyCode == RIGHT)right = true;
}

void keyReleased(){
  if(keyCode == UP)up = false;
  if(keyCode == DOWN)down = false;
  if(keyCode == LEFT)left = false;
  if(keyCode == RIGHT)right = false;
}
