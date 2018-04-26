/**
 * Lines and Dots generator for Make Make Better project
 */

import dawesometoolkit.*;
import processing.pdf.*;
import toxi.math.*;
import controlP5.*;
float expectedMinValue=1;
float expectedMaxValue;

ControlP5 cp5;

final String PROJECT = "MakeMakeBetter";
final int BACKGROUND_COLOR = #ffffff;
final float MIN_FREQ = 10;
final float MAX_FREQ = 200;
final float MIN_SCALER = 100;
final float MAX_SCALER = 2000;
boolean recordPDF = false;
ScaleMap logMap;

float freq = 20;
float scaler = 1000;
float freqV = 20;
float scalerV = 1000;


DawesomeToolkit dawesome; //http://cloud.brendandawes.com/dawesometoolkit/


void setup(){
  size(283,595);
  initGUI();
  dawesome  = new DawesomeToolkit(this);
  dawesome.enableLazySave('s',".png");
  expectedMinValue = 1;
  expectedMaxValue =200 ;
  logMap=new ScaleMap(log(expectedMinValue),log(expectedMaxValue),0,height);
  strokeWeight(0.1);
  smooth();
}

void initGUI(){

  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  cp5.setColorActive(#FC7357);
  cp5.setColorBackground(#9C9999);
  cp5.addButton("savePDF")
    .setValue(0)
    .setPosition(20,180)
    .setSize(100,20)
    .setCaptionLabel("Save PDF")
    ;
  cp5.addSlider("freqV")
    .setPosition(20,100)
    .setSize(100,20)
    .setRange(MIN_FREQ,MAX_FREQ)
    .setValue(freqV)
    .setLabel("Vertical Frequency")
    .setColorLabel(#000000)
    ;
  cp5.addSlider("scalerV")
    .setPosition(20,140)
    .setSize(100,20)
    .setRange(MIN_SCALER,MAX_SCALER)
    .setValue(scalerV)
    .setLabel("Vertical Scale")
    .setColorLabel(#000000)
    ;
  cp5.addSlider("freq")
    .setPosition(20,20)
    .setSize(100,20)
    .setRange(MIN_FREQ,MAX_FREQ)
    .setValue(freq)
    .setLabel("Horizontal Frequency")
    .setColorLabel(#000000)
    ;
  cp5.addSlider("scaler")
    .setPosition(20,60)
    .setSize(100,20)
    .setRange(MIN_SCALER,MAX_SCALER)
    .setValue(scaler)
    .setLabel("Horizontal Scale")
    .setColorLabel(#000000)
    ;
}
void savePDF(float v){
  if (frameCount > 60){
  recordPDF = true;
  }
}
void draw(){
  background(BACKGROUND_COLOR);
  if(recordPDF){
    beginRecord(PDF,dawesome.uniqueFileName()+PROJECT+".pdf");
    smooth();
  }

  //drawLinesRotated();
  drawLines(freq,scaler);
  drawVerticalLines(freqV,scalerV);
  //drawDots();
  //drawSineWaves();
  //drawSineWavesLines();


  if (recordPDF){
    endRecord();
    recordPDF = false;
  }
  cp5.draw();
}

void drawSineWavesLines(){


  float count = 0;
  strokeWeight(1);

  for(int i=0; i < height; i++){
    float y=(float)logMap.getMappedValueFor(log(i));
    beginShape();
    noFill();
    strokeWeight(0.1);
    stroke(0);
    for(int j=0; j < width; j++){
      float x=(float)logMap.getMappedValueFor(log(j));
      float offset=sin(count)*100;
      vertex(x,y+offset);
      count+=0.01;
    }
    endShape();
  }

}
void drawSineWaves(){


  float count = 0;
  strokeWeight(1);

  for(int i=0; i < height; i++){
    float y=(float)logMap.getMappedValueFor(log(i));
    for(int j=0; j < width; j++){
      float x=(float)logMap.getMappedValueFor(log(j));
      float offset=sin(count)*100;
      stroke(0);
      strokeWeight(noise(j)*2);
      point(x,y+offset);
      count+=0.5;
    }
  }

}

void drawLinesRotated(){
  pushMatrix();
  //translate(-width/2,height/2);
  strokeWeight(0.1);

  for(int j=0; j < width; j++){
    float x=(float)logMap.getMappedValueFor(log(j));
    stroke(0);
    line(x,0,x,height);

    rotate(radians(sin(j)*45));
  }
  for(int i=0; i < height; i++){
    float y=(float)logMap.getMappedValueFor(log(i));
    stroke(0);

    //strokeWeight(noise(i)*2);
    line(0,y,width,y);
  }
  popMatrix();
}

void drawLines(float f, float s){

  pushMatrix();
  //translate(0,height/2);
  strokeWeight(0.1);

  float y = 1;
  float i = 0;
  float freq = f;
  float scaler = s;
  float snap = 24;

  while(y < height){

    stroke(0);
    //strokeWeight(noise(i)*2);
    line(0,y,width,y);
    float spacing = sin(i/freq)*scaler;
    //spacing = map(spacing,-50,50,0,height);
    y += spacing;
    y = dawesome.snapToGrid(y,snap);
    i++;
    //snap +=12;
  }
  popMatrix();
}

void drawVerticalLines(float f, float s){
  pushMatrix();
  //translate(0,height/2);
  strokeWeight(0.1);

  float x = 1;
  float i = 0;
  float freq = f;
  float scaler = s;
  float snap = 24;

  while(x < width){

    stroke(0);
    //strokeWeight(noise(i)*2);
    line(x,0,x,height);
    float spacing = sin(i/freq)*scaler;
    //spacing = map(spacing,-50,50,0,height);
    x += spacing;
    x = dawesome.snapToGrid(x,snap);
    i++;
  }
  popMatrix();

}

void drawDots(){

  strokeWeight(1);

  for(int j=0; j < width; j++){
    float x=(float)logMap.getMappedValueFor(log(j));
    stroke(0);
    //line(x,0,x,height);
    point(x,0);
    for(int i=0; i < height; i++){
      float y=(float)logMap.getMappedValueFor(log(i));
      stroke(0);
      //line(0,y,width,y);
      point(x,y);
    }
  }
}

void mousePressed(){
  expectedMaxValue = mouseX;
  expectedMaxValue = mouseY; 
  logMap=new ScaleMap(log(expectedMinValue),log(expectedMaxValue),0,height);
}


void keyReleased() {
  if (key == 'p') {
    recordPDF = true;
  }

}

