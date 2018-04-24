/**
 * Lines and Dots generator for Make Make Better project
 */

import dawesometoolkit.*;
import processing.pdf.*;
import toxi.math.*;
float expectedMinValue=1;
float expectedMaxValue;

final String PROJECT = "MakeMakeBetter";
final int BACKGROUND_COLOR = #ffffff;
final int SECONDS_TO_CAPTURE = 60;
final int VIDEO_FRAME_RATE = 60;

int videoFramesCaptured = 0;
boolean recordVideo = false;
boolean recordPDF = false;
ScaleMap logMap;

DawesomeToolkit dawesome; //http://cloud.brendandawes.com/dawesometoolkit/

void setup(){
  size(300,700);
  dawesome  = new DawesomeToolkit(this);
  dawesome.enableLazySave('s',".png");
  expectedMinValue = 1;
  expectedMaxValue =200 ;
  logMap=new ScaleMap(log(expectedMinValue),log(expectedMaxValue),0,height);
  strokeWeight(0.1);
  smooth();
}

void draw(){
  background(BACKGROUND_COLOR);
  if(recordPDF){
    beginRecord(PDF,dawesome.uniqueFileName()+PROJECT+".pdf");
    smooth();
  }

  drawLinesRotated();
  //drawLines();
  //drawDots();
  //drawSineWaves();
  //drawSineWavesLines();

  if (recordVideo){
    saveFrame("export/####-frame.tga");
    if (videoFramesCaptured > VIDEO_FRAME_RATE * SECONDS_TO_CAPTURE){
      recordVideo = false;
      videoFramesCaptured = 0;
    }
    videoFramesCaptured ++;
  }

  if (recordPDF){
    endRecord();
    recordPDF = false;
  }
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
void drawLines(){

  strokeWeight(0.1);

  for(int j=0; j < width; j++){
    float x=(float)logMap.getMappedValueFor(log(j));
    stroke(0);
    line(x,0,x,height);
  }
  for(int i=0; i < height; i++){
    float y=(float)logMap.getMappedValueFor(log(i));
    stroke(0);

    strokeWeight(noise(i)*2);
    line(0,y,width,y);
  }
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
  if (key == 'r') {
    recordVideo = true;
  }

}

