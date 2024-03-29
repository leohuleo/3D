//pallet
color black = #000000;
color white = #FFFFFF;

boolean up, down, left,right,space;
final int gridSize = 10;
PVector direction = new PVector(0,-10);
PVector direction90 = new PVector(10,0);
float lx = 0,ly = height/2 + 325, lz =0;
float headAngle = 0.01;
ArrayList<Bullet> bullets;
ArrayList<GameObject> particles;
PImage dT;
PImage dS;
PImage dB;
PImage map;
float rotX, rotY,rotZ;
tree t;
void setup(){
  size(800,800,P3D);
  dT = loadImage("dirt_top.jpg");
  dS = loadImage("dirt_side.jpg");
  dB = loadImage("dirt_bottom.jpg");
  map = loadImage("map.png");
  textureMode(NORMAL);
  bullets = new ArrayList<Bullet>();
  particles = new ArrayList<GameObject>();
}

void draw(){
  background(0);
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
  if(space){
    particles.add(new firework(250,375,250,0,-10,0,true,5));
  }
  //pushMatrix();
  //rotateX(rotX);
  //rotateY(rotY);
  drawMap();
  stroke(50);
  strokeWeight(1);
  drawGround();
  //popMatrix();
  int i = 0;
  while(i<bullets.size()){
    Bullet b = bullets.get(i);
    b.show();
    b.act();
    i++;
  }
    particles.add(new rain(random(0,500),100f,random(0,500),0.001,0,0.001,3));
  int j=0;
  while(j<particles.size()){
    GameObject object = particles.get(j);
    if(object.life == 0){
      if(object instanceof rain){
      particles.add(new ripple(object.pos,#0086ad));
      }
      if(object instanceof firework){
        firework f = (firework)object;
         if(f.explode){
      for(int k = 0;i<10;i++){
      particles.add(new firework(object.pos.x,object.pos.y,object.pos.z,random(-8,8),random(-5,5),random(-8,8),false,5));
        }
      }
      }
      particles.remove(j);
    }else{
    object.show();
    object.act();
    j++;  
  }
    
  }
  particles.add(new tree(250,375,250,100));
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
  //rotX = rotX + (pmouseY - mouseY) * 0.01;
  //rotY = rotY + (pmouseX - mouseX) * 0.01;
}

void keyPressed(){
  if(keyCode == UP)up = true;
  if(keyCode == DOWN)down = true;
  if(keyCode == LEFT)left = true;
  if(keyCode == RIGHT)right = true;
  if(key ==' ')space = true;
}

void keyReleased(){
  if(keyCode == UP)up = false;
  if(keyCode == DOWN)down = false;
  if(keyCode == LEFT)left = false;
  if(keyCode == RIGHT)right = false;
  if(key == ' ')space = false;
}

void mouseClicked(){
  bullets.add(new Bullet(lx,lz,direction.x * 5,direction.y * 5));
}
