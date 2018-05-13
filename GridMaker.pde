/**
 * Grid Maker for Notes to Myself
 * http://brendandawes.com
 */

import dawesometoolkit.*; //http://cloud.brendandawes.com/dawesometoolkit/
import processing.pdf.*;
import controlP5.*; //http://www.sojamo.de/libraries/controlP5/

ControlP5 cp5;
DawesomeToolkit dawesome; 

final String PROJECT = "notes_to_myself";
final int BACKGROUND_COLOR = #ffffff;
final int LABEL_COLOR = #000000;
final float MIN_FREQ = 10;
final float MAX_FREQ = 200;
final float MIN_SCALER = 100;
final float MAX_SCALER = 2000;
final float STROKE_WEIGHT = 0.1;
final float STROKE_COLOR = #000000;

boolean recordPDF = false;

float freq = 20;
float scaler = 1000;
float freqV = 20;
float scalerV = 1000;
float snapAmount = 24;

void setup(){
  size(283,595);
  initGUI();
  dawesome  = new DawesomeToolkit(this);
  dawesome.enableLazySave('s',".png");
  strokeWeight(STROKE_WEIGHT);
  smooth();
}


/**
 * Save a PDF
 * @param v a float 
 */

void savePDF(float v){
  if (frameCount > 60){
    recordPDF = true;
  }
}

/**
 * Main Drawing
 */

void draw(){
  background(BACKGROUND_COLOR);

  if(recordPDF){
    beginRecord(PDF,dawesome.uniqueFileName()+PROJECT+".pdf");
    smooth();
  }

  drawHorizontalLines(freq,scaler,snapAmount);
  drawVerticalLines(freqV,scalerV,snapAmount);

  if (recordPDF){
    endRecord();
    recordPDF = false;
  }
  cp5.draw();
}


/**
 * Draw Horizontal Lines
 * @param f a float defining the frequency
 * @param s a float defining the scale
 */

void drawHorizontalLines(float f, float s,float sn){

  pushMatrix();
  //translate(0,height/2);
  strokeWeight(STROKE_WEIGHT);

  float y = 1;
  float i = 0;
  float freq = f;
  float scaler = s;
  float snap = sn;

  while(y < height){

    stroke(STROKE_COLOR);
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

/**
 * Draw Vertical Lines
 * @param f a float defining the frequency
 * @param s a float defining the scale
 */

void drawVerticalLines(float f, float s,float sn){
  pushMatrix();
  strokeWeight(STROKE_WEIGHT);

  float x = 1;
  float i = 0;
  float freq = f;
  float scaler = s;
  float snap = sn;

  while(x < width){
    stroke(STROKE_COLOR);
    line(x,0,x,height);
    float spacing = sin(i/freq)*scaler;
    x += spacing;
    x = dawesome.snapToGrid(x,snap);
    i++;
  }
  popMatrix();

}


void keyReleased() {
  if (key == 'p') {
    recordPDF = true;
  }
}

