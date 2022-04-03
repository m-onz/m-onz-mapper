
/*

  menu for calibrating the projection mapping,

  press a certain key to show or hide the control menu.
  toggling configuration mode will allow the lines to be editable
  toggle showing cross hairs to aid seeing the mouse via a projector
  change the background to help in seeing the edges of the projector imaage
  toggle between presentation and configuration modes
  when in presentation mode go fullscreen and hide the mouse.
  
  todo:
  
  show a list of lines in a listbox
  when selecting an item show more options in a seperate box
  allow changing the strokeweight of individual lines
  allow changing co-ordinates of lines via the configuration box
  
*/

import controlP5.*;

ControlP5 cp5;
Knob myKnobA;
CheckBox checkbox;

//boolean toggleValue = false;

boolean showControls = false;
boolean configurationMode = false;

Knob globalstrokeweightKnob;
int globalStrokeWeight = 2;

Knob BackgroundColorKnob;
int globalBackgroundColor = 0;

//public void addNewLine() {  
//  lines.add(new Line(this, (int)random(width), (int)random(height), (int)random(width), (int)random(height), 12));
//}

//public void removeLine() {}

void controlSetup () {
  cp5 = new ControlP5(this);
  
  //cp5.addToggle("toggleValue")
  //   .setPosition(40,100)
  //   .setSize(50,20)
  //   ;
  cp5.addToggle("configurationMode")
     .setPosition(40,150)
     .setSize(50,20)
     ;

  //cp5.addBang("addNewLine")
  //   .setPosition(40, 300)
  //   .setTriggerEvent(Bang.RELEASE)
  //   .setLabel("add a new line")
  //   ;
     
  //cp5.addBang("removeLine")
  //   .setPosition(40, 350)
  //   .setTriggerEvent(Bang.RELEASE)
  //   .setLabel("remove a line")
  //   ;
     
  globalstrokeweightKnob = cp5.addKnob("globalStrokeWeight")
               .setRange(0, 10)
               .setValue(2)
               .setPosition(200,210)
               .setRadius(50)
               .setNumberOfTickMarks(10)
               .setTickMarkLength(4)
               .snapToTickMarks(true)
               .setDragDirection(Knob.HORIZONTAL)
               ;
               
  BackgroundColorKnob = cp5.addKnob("globalBackgroundColor")
               .setRange(0, 255)
               .setValue(0)
               .setPosition(350,210)
               .setRadius(50)
               .setNumberOfTickMarks(10)
               .setTickMarkLength(4)
               .snapToTickMarks(true)
               .setDragDirection(Knob.HORIZONTAL)
               ;

  cp5.hide();
}

void keyPressed () {
  if (key == 'e') {
    showControls = !showControls;
  }
  if (showControls == true) {
    cp5.show(); 
    cursor();
  } else {
    cp5.hide(); 
    noCursor();
  }
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(checkbox)) {
    print("got an event from "+checkbox.getName()+"\t\n");
    println(checkbox.getArrayValue());
  }
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
    +theEvent.getName()+"': "
    +theEvent.getStringValue()
    );
  }
}
