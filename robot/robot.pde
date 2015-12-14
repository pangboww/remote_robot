import spacebrew.*;
import processing.serial.*;

final int CMD_FORWARD  = '1';
final int CMD_BACKWARD = '2';
final int CMD_LEFT     = '3';
final int CMD_RIGHT    = '4';
final int CMD_STOP     = '5';

String server="sandbox.spacebrew.cc";
String name="Processing";
String description ="This is the Processing side who will listen the web side commond";

Spacebrew sb;
Serial arduinoPort;

void setup() {
  sb = new Spacebrew( this );

  sb.addSubscribe("up", "boolean");
  sb.addSubscribe("down", "boolean");
  sb.addSubscribe("left", "boolean");
  sb.addSubscribe("right", "boolean");
  sb.connect(server, name, description );

  String portName = Serial.list()[1]; //change the 0 to a 1 or 2 etc. to match your port
  println(portName);
  arduinoPort = new Serial(this, portName, 9600);
}

void draw() {
  // do whatever you want to do here  
}


void onRangeMessage( String name, int value ){
  println("got range message " + name + " : " + value);
}

void onBooleanMessage( String name, boolean value ){
  println("got boolean message " + name + " : " + value);
  
  if(!value) {
    arduinoPort.write(CMD_STOP);
    println("STOP");
    return;
  }
  
  if(name.equals("up")) {
    arduinoPort.write(CMD_FORWARD);
    println("FWD");
  } else if(name.equals("down")) {
    arduinoPort.write(CMD_BACKWARD);
  } else if(name.equals("left")) {
    arduinoPort.write(CMD_LEFT);
  } else if(name.equals("right")) {
    arduinoPort.write(CMD_RIGHT);
  }
}

void onStringMessage( String name, String value ){
  println("got string message " + name + " : " + value);  
}

void onCustomMessage( String name, String type, String value ){
  println("got " + type + " message " + name + " : " + value);  
}