PImage nkk1,nkk2,nkkC,nkkCsub,nkkO,op1,op2,op3,bg,chiharu;
PImage pt1,pt2,pt3,light,bg2,character,rare;
PImage[] eggs = new PImage[3];
int state,count,cSstate,sS1state,sS2state,eggSelect,eggY,eggSpeed;
int headY,sSpeed,wait,posX,rareCount,rareWait,charSelect;
int armY1,armY2;
int cCount,cState,cFlag;
String result;

void setup(){
  size(540,500);
  bg = loadImage("http://blog.cha1ra.com/etc/nkk/bg.png");
  nkk1 = loadImage("http://blog.cha1ra.com/etc/nkk/nkk1.png");
  nkk2 = loadImage("http://blog.cha1ra.com/etc/nkk/nkk2.png");
  nkkC = loadImage("http://blog.cha1ra.com/etc/nkk/nkkC.png");
  nkkCsub = loadImage("http://blog.cha1ra.com/etc/nkk/nkkCsub.png");
  nkkO = loadImage("http://blog.cha1ra.com/etc/nkk/nkkO.png");
  op1 = loadImage("http://blog.cha1ra.com/etc/nkk/op1.png");
  op2 = loadImage("http://blog.cha1ra.com/etc/nkk/op2.png");
  op3 = loadImage("http://blog.cha1ra.com/etc/nkk/op3.png");
  eggs[0] = loadImage("http://blog.cha1ra.com/etc/nkk/eggB.png");
  eggs[1] = loadImage("http://blog.cha1ra.com/etc/nkk/eggS.png");
  eggs[2] = loadImage("http://blog.cha1ra.com/etc/nkk/eggG.png");
  chiharu = loadImage("http://blog.cha1ra.com/etc/nkk/chiharu.png");
  
  bg2 = loadImage("http://blog.cha1ra.com/etc/nkk/bg2.png");
  pt1 = loadImage("http://blog.cha1ra.com/etc/nkk/pt1.png");
  pt2 = loadImage("http://blog.cha1ra.com/etc/nkk/pt2.png");
  pt3 = loadImage("http://blog.cha1ra.com/etc/nkk/pt3.png");
  light = loadImage("http://blog.cha1ra.com/etc/nkk/light.png");
  
  
  armY1 = 0;
  eggY=0;
  eggSpeed=7;
  sSpeed = 7;
  wait = 0;
  headY=height/40*13-6;
  eggSelect = int(random(3)%3);
  charSelect = int(random(2)%2);
  count=0;
  //animation state 0~7,8~
  state=0;
  sS1state=0;
  cSstate=0;
  posX=200;
  cCount=0;
  cFlag=1;
  
  result = "http://blog.cha1ra.com/etc/nkk/character/" + str(eggSelect) 
            +"-" + str(charSelect) +".png";
  character = loadImage(result);
  rare = loadImage("http://blog.cha1ra.com/etc/nkk/rare/"+str(eggSelect)+".png");
  rareCount=1;
  rareWait=0;
  
  frameRate(60);
  
}

void draw(){

  pushMatrix ( ) ;
  image(bg,0,0);
  bgMovie();
  
  switch(state){
    case 0:
      image(nkk1, 0, 0, width, height);
      armMove();
      break;
    case 1:
      image(nkk1, 0, 0, width, height);
      catchStone();
      break;
    case 2:
      swarrowStone1();
      break;
    case 3:
      swarrowStone2();
      break;
    case 4:
      zoom();
      break;
    case 5:
      openDoor();
      break;
    case 6:
      egg();
      break;
    case 7:
      fadeOut();
      break;
    case 8:
      fadeIn();
      break;
    case 9:
      lightBurst();
      break;
    case 10:
      appear();
      break;
    case 11:
      linkChar();
      break;
  }
  
  popMatrix();    
  imageMode(CORNER);
}

void bgMovie(){
}


void armMove(){
  float rad=0;
  imageMode(CENTER);
  translate(width/2,headY);
  image(nkkC, 0, 0, width, height);
  
  resetMatrix();
  if(mousePressed){
    armY2 = (pmouseY - armY1)*-1;
    if(armY2<-50)armY2=-50;
    else if(armY2>0)armY2=0;
    rad = radians(armY2);
  }
  translate(width/2,height/2);
  rotate(rad);
  image(nkk2, 0, 0, width, height);
}
void mousePressed(){
  armY1 = mouseY;
}
void mouseReleased() {
  if(armY2 <-45)state=1;
  else armY1=0;
} 


void catchStone(){
  
  //chiharu
  if(cFlag == 1){
    int chiharuX = -50+cCount;
    imageMode(CENTER);
    translate(chiharuX,sq(chiharuX-100)/300+120);
    rotate(radians(cCount));
    image(chiharu,0,0,30,30);
    cCount+=7;
    if(cCount >= 300){cFlag=0;}
  }
  resetMatrix();
  
  
  float rad = radians(count);
  if(cSstate==0){
    if(count >= 30){cSstate=1;}
    imageMode(CENTER); 
    translate(width/2,headY);
    rotate(rad);
    image(nkkO, 0, 0, width, height);
    count+=2;
  }else if(cSstate==1){
    if(count <= -20){cSstate=2;}
    imageMode(CENTER); 
    translate(width/2,headY);
    rotate(rad);
    image(nkkO, 0, 0, width, height);
    count-=2;
  }else if(cSstate==2){
    if(count >= 0){cSstate=3;}
    imageMode(CENTER); 
    translate(width/2,headY);
    rotate(rad);
    image(nkkC, 0, 0, width, height);
    count+=2;    
  }else if(cSstate==3){
    imageMode(CENTER);
    translate(width/2,headY);
    image(nkkC, 0, 0, width, height);
    state=2;
    count=0;
  }
  
  resetMatrix();
  imageMode(CORNER); 
  image(nkk2, 0, 0, width, height);
  
}

void swarrowStone1(){
  if(sS1state==0){
    if(count>=80){sS1state=1;}
    imageMode(CENTER);
    translate(width/2,height/2);
    image(nkk1, 0, 0, width, height+count);
    resetMatrix();
    translate(width/2,headY);
    image(nkkC, 0, 0, width, height+count);
    resetMatrix();
    translate(width/2,height/2);
    image(nkk2, 0, 0, width, height+count);
    count+=sSpeed;
  }else if(sS1state==1){
    if(count<=0){state=3;}
    imageMode(CENTER);
    translate(width/2,height/2);
    image(nkk1, 0, 0, width, height+count);
    resetMatrix();
    translate(width/2,headY);
    image(nkkC, 0, 0, width, height+count);
    resetMatrix();
    translate(width/2,height/2);
    image(nkk2, 0, 0, width, height+count);
    count-=sSpeed;
  }
}

void swarrowStone2(){
  if(sS2state==0){
    if(count>=80){sS2state=1;}
    imageMode(CENTER);
    translate(width/2,height/2);
    image(nkk1, 0, 0, width+count, height);
    image(nkk2, 0, 0, width, height);
    resetMatrix();
    translate(width/2,headY);
    image(nkkC, 0, 0+count/13, width, height);
    count+=sSpeed;
  }else if(sS2state==1){
    if(count<=0){state=4;count=0;}
    imageMode(CENTER);
    translate(width/2,height/2);
    image(nkk1, 0, 0, width+count, height);
    image(nkk2, 0, 0, width, height);
    resetMatrix();
    translate(width/2,headY);
    image(nkkC, 0, 0+count/13, width, height);
    count-=sSpeed;
  }
}

void zoom(){
  imageMode(CENTER);
  translate(width/2+count,height/2);
  image(nkk1, 0, 0, width+count, height+count);
  image(nkk2, 0, 0, width+count, height+count);
  image(nkkCsub, 0, 0, width+count, height+count);
  if(count<200)count+=3;
  else{
    count=posX;
    wait++;
    if(wait>40){state=5;count=0;}
  }
}

void openDoor(){
  imageMode(CENTER);
  translate(width/2+posX,height/2);
  if(count<3){
    image(op1, 0, 0, width+posX, height+posX);
  }else if(count<6){
    image(op2, 0, 0, width+posX, height+posX);
  }else{
    image(op3, 0, 0, width+posX, height+posX);
    state=6;
    count=0;
  }
  image(nkk2, 0, 0, width+posX, height+posX);
  image(nkkCsub, 0, 0, width+posX, height+posX);
  count++;
}

void egg(){

  if(count<200){
    eggY+=eggSpeed/5*4;
  }else if(count<360){
    eggSpeed=5;
    eggY-=eggSpeed/5*3;
  }else if(count<500){
    eggSpeed=4;
    eggY+=eggSpeed/5*3;
  }else{
    state=7;
  }
  
  float rad;
  imageMode(CENTER);
  translate(width/2+posX,height/2);
  image(op3, 0, 0, width+posX, height+posX);
  image(nkk2, 0, 0, width+posX, height+posX);
  image(nkkCsub, 0, 0, width+posX, height+posX);
  translate(-70-count,80+eggY);
  rad = radians(count/2*-1);
  rotate(rad);
  image(eggs[eggSelect],0,0,64,80);
  count+=eggSpeed;
  if(state==7)count=0;
}

void fadeOut(){
  imageMode(CENTER);
  translate(width/2+posX,height/2);
  image(op3, 0, 0, width+posX, height+posX);
  image(nkk2, 0, 0, width+posX, height+posX);
  image(nkkCsub, 0, 0, width+posX, height+posX);
  imageMode(CORNER);
  resetMatrix();
  noStroke();
  fill(0,0,0,count);
  rect(0,0,width,height);
  count+=10;
  if(count>=280){state=8;count=250;}
}

//state=8
void fadeIn(){
  imageMode(CENTER);
  translate(width/2,height/2);
  image(bg2, 0, 0, width, height);
  translate(-20,height/7*1);
  image(eggs[eggSelect], 0, 0, 80, 109);
  imageMode(CORNER);
  resetMatrix();
  noStroke();
  fill(0,0,0,count);
  rect(0,0,width,height);
  count-=10;
  if(count<=0){state=9;count=0;}
}

//state=9
void lightBurst(){
  //hikari no sen
  image(bg2, 0, 0, width, height);
  tint(255,count);
  image(pt1, -5, -40, width, height);
  noTint();
  tint(255,count-20);
  image(pt2, -5, -40, width, height);
  tint(255,count-40);
  image(pt3, -5, -40, width, height);
  
  tint(255,255);
  imageMode(CENTER);
  translate(width/2,height/2);
  translate(-20,height/7*1);
  image(eggs[eggSelect], 0, 0, 80, 109);
  int lCount=count-40;
  tint(255,(lCount)*5);
  rotate(radians(count*3));
  image(light, 0, 0,lCount*30,lCount*30);
  rotate(radians(45));
  image(light, 0, 0,lCount*30,lCount*30);
  tint(255,255);
  imageMode(CORNER);
  resetMatrix();
  noStroke();
  fill(255,255,255,(lCount-10)*7);
  rect(0,0,width,height);
  
  count+=2;
  
  if((lCount-10)*7>1400){state=10;count=255;}
}

void appear(){
  imageMode(CENTER);
  translate(width/2,height/2);
  image(bg2, 0, 0, width, height);
  translate(-20,height/7*1);
  image(character, 0, -30, 200, 200);
  imageMode(CORNER);
  resetMatrix();
  noStroke();
  fill(255,255,255,count);
  rect(0,0,width,height);
  count-=10;
  
  //レアの画面を表示
  imageMode(CENTER);
  if(eggSelect!=2){
    if((rareCount*15>=width/2)&&(rareWait<60)){
      image(rare,width/2,height/4,400,125);
      rareWait++;
    }else{
      image(rare,rareCount*15,height/4,400,125);
      rareCount++;
    }
  }else{
    if(800*30/rareCount <= 400){
      if(rareWait<60){
        image(rare,width/2,height/4,400,125);
      }else{
        image(rare,width/2,height/4+((rareWait-60)*15),400,125);
      }
      rareWait++;
    }else{
      image(rare,width/2,height/4,800*30/rareCount,250*30/rareCount);
      rareCount++;
    }
  }
  imageMode(CORNER);
  
  if(count <= -2000){state=11;count=0;}
}

void linkChar(){
  imageMode(CENTER);
  translate(width/2,height/2);
  image(bg2, 0, 0, width, height);
  translate(-20,height/7*1);
  image(character, 0, -30, 200, 200);
  imageMode(CORNER);
  resetMatrix();
  noStroke();
  fill(0,0,0,count);
  rect(0,0,width,height);
  count+=10;
  if(count==300){
    link("http://blog.cha1ra.com/etc/nkk/prev/result.html?q=" + str(eggSelect) + "&m=" +str(charSelect));
    //link("http://blog.cha1ra.com/etc/nkk/detail/index.html?q=" + str(eggSelect) + "-" +str(charSelect));
  }
}


  
