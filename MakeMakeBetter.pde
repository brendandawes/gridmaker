/**
 * Grid Maker for Notes to Myself
 * http://brendandawes.com
 */

import dawesometoolkit.*; //http://cloud.brendandawes.com/dawesometoolkit/
import processing.pdf.*;
import controlP5.*; //http://www.sojamo.de/libraries/controlP5/

ControlP5 cp5;

final String PROJECT = "notes_to_myself";
final int BACKGROUND_COLOR = #ffffff;
final float MIN_FREQ = 10;
final float MAX_FREQ = 200;
final float MIN_SCALER = 100;
final float MAX_SCALER = 2000;
boolean recordPDF = false;

float freq = 20;
float scaler = 1000;
float freqV = 20;
float scalerV = 1000;


DawesomeToolkit dawesome; 


void setup(){
  size(283,595);
  initGUI();
  dawesome  = new DawesomeToolkit(this);
  dawesome.enableLazySave('s',".png");
  strokeWeight(0.1);
  smooth();
}

/**
 * Set up the GUI
 */

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

  drawHorizontalLines(freq,scaler);
  drawVerticalLines(freqV,scalerV);

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

void drawHorizontalLines(float f, float s){

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

/**
 * Draw Vertical Lines
 * @param f a float defining the frequency
 * @param s a float defining the scale
 */

void drawVerticalLines(float f, float s){
  pushMatrix();
  strokeWeight(0.1);

  float x = 1;
  float i = 0;
  float freq = f;
  float scaler = s;
  float snap = 24;

  while(x < width){
    stroke(0);
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

