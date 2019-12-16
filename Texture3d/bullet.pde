class Bullet extends GameObject{
  
  
  Bullet(float x, float z,float vx,float vz){
    int y = height/2 ;
    pos = new PVector(x,y,z);
    velocity = new PVector(vx,vz);
  }
  
  void show(){ 
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    fill(0);
    stroke(0);
    box(10);
    popMatrix();
  }
  
  void act(){
    pos.x += velocity.x;
    pos.z += velocity.y;
  }
}
