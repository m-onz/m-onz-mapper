
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

CheckBox checkbox;

void controlSetup () {
  cp5 = new ControlP5(this);
  
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

  cp5.hide();
}

void keyPressed () {
  cp5.show(); 
  cursor();
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
