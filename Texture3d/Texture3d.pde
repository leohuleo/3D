//pallet
color black = #000000;
color white = #FFFFFF;

boolean up, down, left,right;

float lx = 0,ly = 0, lz = 0;
PImage dT;
PImage dS;
PImage dB;
PImage map;
float rotX, rotY,rotZ;
final int gridSize = 10;
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
  camera(lx,ly,lz,0,0,-1,0,1,0);
  if(up)lz -= 10;
  if(down)lz += 10;
  
  //pushMatrix();
  //rotateX(rotX);
  //rotateY(rotY);
  drawMap(map);
  stroke(50);
  drawGround();
  //popMatrix();
}
void drawMap(PImage map){
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
  int x = gridSize;
  while(x<map.width*gridSize){
  line(x,height/2 + gridSize, 0,x,height/2 + gridSize,map.height*gridSize-gridSize);
  x=x+gridSize * 2;
  }
  int z = 0;
  while(z < map.height*gridSize){
    line(0,height/2 + gridSize,z,map.width*gridSize - gridSize,height/2 + gridSize,z);
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
