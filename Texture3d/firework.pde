class firework extends GameObject{
  boolean explode;
  firework(float x,float y, float z, float vx, float vy, float vz,boolean expl, float si){
    pos = new PVector(x,y,z);
    velocity = new PVector(vx,vy,vz);
    size = si;
    explode = expl;
    life = 1;
  }
  
  void show(){
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    fill(#FA0000);
    box(size);
    popMatrix();
  }
  void act(){
    pos.add(velocity);
    velocity.y+=0.2;
    if(explode){
    if(velocity.y>0){
    println(velocity.y);
    life = 0;
    }
    }else{
      if(pos.y>500){
        life = 0;
      }
    }
  }
}
