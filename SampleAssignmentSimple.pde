
PImage mhs;
ArrayList<AnimatedObject> objs = new ArrayList<AnimatedObject>();

int SAND_HEIGHT = 70;
int fishCount=40;
int cheezCount=10;
int squidCount=7;
void setup() {
  mhs = loadImage("martin2.jpg");
  //size(mhs.width,mhs.height);
  //fullScreen();
  size(800,600);
  smooth();
  ArrayList<SchnoorObj> js=new ArrayList<SchnoorObj>();
  ArrayList<CheezObj> cs=new ArrayList<CheezObj>();
  for (int i=0; i<fishCount/2; i++)
    objs.add(new SchnoorObj());
  for (int k=0; k<squidCount; k++)
    objs.add(new SquidFish());
  for (int j=0; j<cheezCount; j++)
    objs.add(new CheezObj());
  for (int i=fishCount/2; i<fishCount; i++)
    objs.add(new SchnoorObj());
  //Add your object here.
}

void draw() {

  drawTankBackground();                    

  PVector[] locations = new PVector[objs.size()];
  for (int i=0; i<objs.size(); i++) {
    AnimatedObject obj = objs.get(i);
    if (obj!=null)
      locations[i] = new PVector(obj.getX(), obj.getY());
  }

  for (AnimatedObject ao : objs) {
    if (ao!=null)
    {
      ao.display();
      ao.move(locations);
    }
    resetMatrix();
  }
}
void mousePressed()
{
  for (int i=0; i<objs.size(); i++)
  {
    if (objs.get(i)!=null)
      if (dist(mouseX, mouseY, objs.get(i).getX(), objs.get(i).getY())<50)
      {
        objs.get(i).faster();
      }
  }
}
void drawTankBackground() {

  rectMode(CORNER);
  tint(0, 130, 237);
  image(mhs, 0, 0);
  //background(50, 50, 255);
  color topColor = color(168, 168, 50);
  color bottomColor = color(68, 68, 0);
  float rDiff = red(topColor) - red(bottomColor);
  float gDiff = green(topColor) - green(bottomColor);
  float bDiff = blue(topColor) - blue(bottomColor);
  rDiff /= SAND_HEIGHT;
  gDiff /= SAND_HEIGHT;
  bDiff /= SAND_HEIGHT;
  for (int i =0; i<SAND_HEIGHT; i++)
  {
    stroke(red(topColor)-i*rDiff, green(topColor)-i*gDiff, blue(topColor)-i*bDiff);
    line(0, height-SAND_HEIGHT+i, width, height-SAND_HEIGHT+i);
  }
  //  rect(0, height-SAND_HEIGHT, width, SAND_HEIGHT);    //sandy bottom
  //castle

  //  stroke (0);
  //  strokeWeight (1);
  //  fill (142, 137, 137,200);
  //  rectMode (CORNER);
  //  //botton part of castle
  //  rect (10, 390-80, 200, 170);
  //  //middle part of castle
  //  rect (30, 300-80, 160, 90);
  //  //top part of castle
  //  rect (50, 250-80, 120, 50);
  //  //castle flag
  //  strokeWeight (2);
  //  line (110, 250-80, 110, 210-80);
  //  fill (255, 0, 0,127);
  //  triangle (110, 210-80, 110, 230-80, 130, 220-80);
  //  //castle door
  //  noStroke ();
  //  fill (109, 190, 250,127);
  //  rect (90, 490-80, 40, 70);
  //  ellipseMode (CENTER);
  //  arc (110, 490-80, 40, 40,PI,2*PI);
  //  //castle windows
  //  stroke (0);
  //  rect (130, 330-80, 30, 30);
  //  line (145, 330-80, 145, 360-80);
  //  line (130, 345-80, 160, 345-80); 
  //  rect (60, 330-80, 30, 30);
  //  line (75, 330-80, 75, 360-80);
  //  line (60, 345-80, 90, 345-80);
}
abstract class AnimatedObject
{
  abstract void display();
  void move()
  {
  }
  void move(PVector[] locs)
  {
    move();
  }
  void faster()
  {
  }
  abstract float getX();
  abstract float getY();
}
class CheezObj extends AnimatedObject
{
  float x, y, xspeed, yspeed, fCount, r, g, b;
  CheezObj()
  {
    x=random(width);
    y=random(height);
    while (xspeed<3 || yspeed==0)
    {
      xspeed=random(5);
      yspeed=random(13)-7;
    }
    fCount=0;
    r=random(50)+215;
    g=random(50)+205;
    b=random(50)+115;
    //240,230,140
  }
  void display()
  {
    fCount++;
    if (fCount>60)
      fCount=0;
    if (fCount<15 || (fCount<45 && fCount>=30))
      costume1();
    else if (fCount>=15 && fCount<30)
      costume2();
    else if (fCount>=45)
      costume3();
  }
  void costume1()
  {
    stroke(255);
    fill(r, g, b);
    triangle(x, y, x-80, y-60, x-80, y+60);
    ellipse(x, y, 80, 100);
    fill(255);
    ellipse(x+30, y-15, 20, 20);
    fill(0);
    ellipse(x+30, y-15, 10, 10);
  }
  void costume2()
  {   
    stroke(255);
    fill(r-30, g-30, b-30);
    triangle(x, y+10, x-70, y-80, x-70, y+40);
    fill(r, g, b);
    ellipse(x, y, 80, 100);
    fill(255);
    ellipse(x+30, y-10, 20, 20);
    fill(0);
    ellipse(x+30, y-10, 10, 10);
  }
  void costume3()
  {
    stroke(255);
    fill(r+15, g+15, b+15);
    triangle(x, y-5, x-75, y-40, x-75, y+80);
    fill(r, g, b);
    ellipse(x, y, 80, 100);
    fill(255);
    ellipse(x+30, y-20, 20, 20);
    fill(0);
    ellipse(x+30, y-20, 10, 10);
  }
  float getX()
  {
    return x;
  }
  float getY()
  {
    return y;
  }
  void move()
  {
    x+=xspeed;
    y+=yspeed;
    if (x>width+100)
      x=-100;
    //xspeed=-random(6);
    if (y>height)
      yspeed=-random(4);
    if (y<0)
      yspeed=random(4);
  }
  void faster()
  {
    xspeed*=2;
  }
  void move(PVector[] locs)
  {
    move();
  }
}
class SchnoorObj extends AnimatedObject
{
  float x, y, xspeed, yspeed, fCount, r, g, b;
  SchnoorObj()
  {
    x=random(width);
    y=random(height);
    while (xspeed<3 || yspeed==0)
    {
      xspeed=random(11);
      yspeed=random(7)-3;
    }
    fCount=0;
    r=random(50)+205;
    g=random(50)+140;
    b=random(50);
    //  255-165-0
  }
  void display()
  {
    fCount++;
    if (fCount>60)
      fCount=0;
    if (fCount<15 || (fCount<45 && fCount>=30))
      costume1();
    else if (fCount>=15 && fCount<30)
      costume2();
    else if (fCount>=45)
      costume3();
  }
  void costume1()
  {
    stroke(0);
    fill(r, g, b);
    triangle(x, y, x-35, y-35, x-35, y+35);
    ellipse(x+20, y, 75, 50);
    fill(0);
    ellipse(x+40, y-10, 10, 10);
    fill(97, 97, 97);
    ellipse(x+35, y+15, 20, 15);
  }
  void costume2()
  {
    stroke(0);
    fill(r, g+10, b);
    triangle(x+5, y+5, x-30, y-45, x-30, y+25);
    fill(r, g, b);
    ellipse(x+20, y, 75, 50);
    fill(0);
    ellipse(x+40, y-10, 10, 10);
    fill(97, 97, 97);
    ellipse(x+35, y+15, 20, 15);
  }
  void costume3()
  {
    stroke(0);
    fill(r, g-10, b);
    triangle(x-5, y-5, x-30, y-25, x-30, y+45);
    fill(r, g, b);
    ellipse(x+20, y, 75, 50);
    fill(0);
    ellipse(x+40, y-10, 10, 10);
    fill(97, 97, 97);
    ellipse(x+35, y+15, 20, 15);
  }
  float getX()
  {
    return x;
  }
  float getY()
  {
    return y;
  }
  void faster()
  {
    xspeed*=2;
  }
  void move()
  {
    x+=xspeed;
    y+=yspeed;
    if (x>width+50)
      x=-50;
    //xspeed=-random(6);
    if (y>height)
      yspeed=-random(4);
    if (y<0)
      yspeed=random(4);
  }
  void move(PVector[] locs)
  {
    move();
  }
}
class SquidFish extends AnimatedObject
{
  float x, y, xspeed, yspeed, fCount, r, g, b;
  SquidFish()
  {
    x=random(width);
    y=random(height);
    while (xspeed<1 || yspeed==0)
    {
      xspeed=random(3);
      yspeed=random(5)-3;
    }
    fCount=0;
    r=random(50)+215;
    g=random(50)+0;
    b=random(50)+215;
    //255,0,255
  }
  void display()
  {
    fCount++;
    if (fCount>60)
      fCount=0;
    if (fCount<15 || (fCount<45 && fCount>=30))
      costume1();
    else if (fCount>=15 && fCount<30)
      costume2();
    else if (fCount>=45)
      costume3();
  }
  void costume1()
  {
    stroke(0);
    fill(r, g, b);
    triangle(x, y-35, x-200, y-5, x-100, y-65);
    triangle(x, y+35, x-100, y+65, x-200, y+5);
    ellipse(x, y, 140, 140);
    fill(0, 255, 0);
    ellipse(x+30, y-15, 20, 20);
    fill(0);
    ellipse(x+30, y-15, 10, 10);
  }
  void costume2()
  {   
    stroke(0);
    fill(r, g, b);
    triangle(x, y-35, x-200, y-30, x-100, y-85);
    triangle(x, y+35, x-100, y+85, x-200, y+30);
    ellipse(x, y, 140, 140);
    fill(0, 255, 0);
    ellipse(x+30, y-15, 20, 20);
    fill(0);
    ellipse(x+30, y-15, 10, 10);
  }
  void costume3()
  {
    stroke(0);
    fill(r, g, b);
    triangle(x, y-25, x-200, y+20, x-100, y-45);
    triangle(x, y+25, x-100, y+45, x-200, y-20);
    ellipse(x, y, 140, 140);
    fill(0, 255, 0);
    ellipse(x+30, y-15, 20, 20);
    fill(0);
    ellipse(x+30, y-15, 10, 10);
  }
  float getX()
  {
    return x;
  }
  float getY()
  {
    return y;
  }
  void move()
  {
    x+=xspeed;
    y+=yspeed;
    if (x>width+200)
      x=-100;
    //xspeed=-random(6);
    if (y>height)
      yspeed=-random(4);
    if (y<0)
      yspeed=random(4);
  }
  void move(PVector[] locs)
  {
    move();
  }
  void faster()
  {
    xspeed*=2;
  }
}

