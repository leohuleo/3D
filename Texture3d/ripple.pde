class ripple extends GameObject{
  color colour;
  ripple(PVector pos, color colour){
    this.pos = pos;
    this.colour = colour;
    life = 30;
  }
  
  void show(){
    stroke(colour);
    strokeWeight(1);
    noFill();
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    rotateX(PI/2);
    ellipse(0,0,30-life,30-life);
    popMatrix();
    life--;
  }
  
  void act(){}
}
