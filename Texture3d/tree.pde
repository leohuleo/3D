class tree extends GameObject{
  ArrayList<Float> layers;
  int timer;
  tree(float x, float y, float z,float bulkHeight){
    pos = new PVector(x,y,z);
    size = bulkHeight;
    layers = new ArrayList<Float>();
    layers.add(pos.x);
    layers.add(pos.y-size);
    layers.add(pos.z);
    layers.add(100f);
    life = 1;
    timer=0;
  }
  
  void show(){
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    fill(#A7640C);
    box(15,size,15);
    popMatrix();
    for(int i = 0;i<layers.size();i+=4){    
      drawLeaf(layers.get(i),layers.get(i+1),layers.get(i+2),layers.get(i+3));
    }
  }
  
  void drawLeaf(float x,float y, float z, float s){
    pushMatrix();
    translate(x,y,z);
    fill(#0CA712);
    box(s);
    popMatrix();
  }
  
  void act(){
    if(timer%100==0){
      int a = (int)random(0,2);
      boolean b;
      if(a==0)b=false;
      if(a==1)b=true
      b?layers.add(pos.x+50):layers.add(pos.x-50);
    }
    timer++;
  }
}
