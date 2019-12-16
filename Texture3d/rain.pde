class rain extends GameObject{
  rain(float x, float y, float z, float vx, float vy, float vz,float s){
     pos = new PVector(x,y,z);
     velocity = new PVector(vx,vy,vz);
     life = 1;
     size = s;
  }
  
  void show(){
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    fill(#0086ad);
    noStroke();
    box(size);
    popMatrix();
  }
  
  void act(){
    velocity.y+=0.05;
    pos.add(velocity);
    if(pos.y>400){
      life = 0;
    }
  }
}
