
/*

  menu for calibrating the projection mapping,

  press a certain key to show or hide the control menu.
  toggling configuration mode will allow the lines to be editable
  toggle showing cross hairs to aid seeing the mouse via a projector
  change the background to help in seeing the edges of the projector imaage
  toggle between presentation and configuration modes
  when in presentation mode go fullscreen and hide the mouse.
  
*/

import controlP5.*;

ControlP5 cp5;
Knob myKnobA;
CheckBox checkbox;

boolean toggleValue = false;

boolean showControls = false;
boolean configurationMode = false;

Knob globalstrokeweightKnob;
int globalStrokeWeight = 2;

public void addNewLine() {
  int theColor = (int)random(255);
  //myColorBackground = color(theColor);
  println("### bang(). a bang event. setting background to "+theColor);
  
  lines.add(new Line(this, (int)random(width), (int)random(height), (int)random(width), (int)random(height), 12));
}

void controlSetup () {
  cp5 = new ControlP5(this);
  
  cp5.addToggle("toggleValue")
     .setPosition(40,100)
     .setSize(50,20)
     ;
  cp5.addToggle("configurationMode")
     .setPosition(40,150)
     .setSize(50,20)
     ;

  cp5.addBang("addNewLine")
     .setPosition(40, 300)
     //.setSize(280, 40)
     .setTriggerEvent(Bang.RELEASE)
     .setLabel("add a new line")
     ;
     
  globalstrokeweightKnob = cp5.addKnob("globalStrokeWeight")
               .setRange(0, 10)
               .setValue(2)
               .setPosition(100,210)
               .setRadius(50)
               .setNumberOfTickMarks(10)
               .setTickMarkLength(4)
               .snapToTickMarks(true)
               .setDragDirection(Knob.HORIZONTAL)
               ;

  /*
  checkbox = cp5.addCheckBox("checkBox")
                .setPosition(100, 200)
                .setSize(40, 40)
                .setItemsPerRow(3)
                .setSpacingColumn(30)
                .setSpacingRow(20)
                .addItem("Selection 1", 0);
                
  cp5.addTextfield("default")
     .setPosition(20,350)
     .setAutoClear(false)
     ;
  */
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

void controlDraw () {
  
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(checkbox)) {
    print("got an event from "+checkbox.getName()+"\t\n");
    // checkbox uses arrayValue to store the state of 
    // individual checkbox-items. usage:
    println(checkbox.getArrayValue());
  }
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
  }

}
