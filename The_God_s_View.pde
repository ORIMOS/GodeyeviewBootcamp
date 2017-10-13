                                import ddf.minim.*;
                                Minim minim;
                                AudioSample kick;
                                AudioSample snare;
                                AudioSample hihat;
                                AudioSample hihatO;


int num = 300;
PVector[] posArray = new PVector[num];
int r = 100;
float pTime = 10;
float vel;
PVector[] noiseArray = new PVector[num];


void setup() {
  size(1440, 900,P3D);
  //background(0);
  
  
  
                                  minim = new Minim(this);
                                
                                  kick = minim.loadSample( "kick.wav");
                                  //snare = minim.loadSample("snare.wav");
                                  hihat = minim.loadSample("hihat.wav", 512);
                                  //hihatO = minim.loadSample("hihato.wav", 512);

for (int i = 0; i < num; i++) {
    float r = random(300,400);
    float theta = random(TWO_PI);
    float y = r*sin(theta);
    float x = r*cos(theta);

    noiseArray[i] = new PVector(x, y);
    posArray[i]  = new PVector(0, 0);
    
  }
}

void draw() {

  background(0);
  pushMatrix();
  translate(width/2, height/2);
  scale(1.5);
 

  for (int i = 0; i < num; i++) {
     ellipse(posArray[i].x, posArray[i].y, random(1,5), random(1,5));
     fill((random(1,255)),(random(1,255)),(random(1,255)),(random(1,255)));
     stroke((random(1,255)),(random(1,255)),(random(1,255)),(random(1,255)));
  }

 float dist = 20;

  for (int i = 0; i<num; i++) {
    for (int j = i+1; j<num; j++) {
      if (dist(posArray[i].x, posArray[i].y, posArray[j].x, posArray[j].y)<dist) {
        strokeWeight(random(1,5));
        line(posArray[i].x, posArray[i].y, posArray[j].x, posArray[j].y);
        fill((random(1,255)),(random(1,255)),(random(1,255)),(random(1,255)));
        stroke((random(1,255)),(random(1,255)),(random(1,255)),(random(1,255)));
                 
                 
                                     hihat.trigger();
      } 
    }
  }
  popMatrix();

  update();
}

void update() {

  float time = millis()*0.00001;
  float dt = time - pTime;
  //println(dt);
  println(time);
  pTime = time;

 
  
  vel = map(300, 1000, 100, 1, 50);

  for (int i = 0; i < num; i++) {
    noiseArray[i].x += vel * dt;
    noiseArray[i].y += vel *dt;
    float xScale = map(noise(noiseArray[i].x), 0, 1, -1, 1);
    float yScale = map(noise(noiseArray[i].y), 0, 1, -1, 1);

    posArray[i].x = xScale * 500;
    posArray[i].y = yScale * 500;
  }
}