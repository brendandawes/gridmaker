
void initGUI(){

  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  cp5.setColorActive(#FC7357);
  cp5.setColorBackground(#9C9999);
  cp5.addButton("savePDF")
    .setValue(0)
    .setPosition(20,220)
    .setSize(100,20)
    .setCaptionLabel("Save PDF")
    ;
  cp5.addSlider("freqV")
    .setPosition(20,100)
    .setSize(100,20)
    .setRange(MIN_FREQ,MAX_FREQ)
    .setValue(freqV)
    .setLabel("Vertical Frequency")
    .setColorLabel(LABEL_COLOR)
    ;
  cp5.addSlider("scalerV")
    .setPosition(20,140)
    .setSize(100,20)
    .setRange(MIN_SCALER,MAX_SCALER)
    .setValue(scalerV)
    .setLabel("Vertical Scale")
    .setColorLabel(LABEL_COLOR)
    ;
  cp5.addSlider("freq")
    .setPosition(20,20)
    .setSize(100,20)
    .setRange(MIN_FREQ,MAX_FREQ)
    .setValue(freq)
    .setLabel("Horizontal Frequency")
    .setColorLabel(LABEL_COLOR)
    ;
  cp5.addSlider("scaler")
    .setPosition(20,60)
    .setSize(100,20)
    .setRange(MIN_SCALER,MAX_SCALER)
    .setValue(scaler)
    .setLabel("Horizontal Scale")
    .setColorLabel(LABEL_COLOR)
    ;
  cp5.addSlider("snapAmount")
    .setPosition(20,180)
    .setSize(100,20)
    .setRange(3,24)
    .setColorLabel(LABEL_COLOR)
    .setColorTickMark(LABEL_COLOR)
    .setNumberOfTickMarks(8)
    .showTickMarks(true)
    .snapToTickMarks(true)
    .setLabel("Snap Amount")
    .setValue(snapAmount)
    ;
}
