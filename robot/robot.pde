import spacebrew.*;
import processing.serial.*;

final int CMD_FORWARD   = '1';
final int CMD_BACKWARD  = '2';
final int CMD_LEFT      = '3';
final int CMD_RIGHT     = '4';
final int CMD_STOP      = '5';
final int CMD_HEAD      = '6';
final int CMD_LASER_ON  = '7';
final int CMD_LASER_OFF = '8';

final int CMD_GUN_LEFT = '9';
final int CMD_GUN_RIGHT = '0';

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
  sb.addSubscribe("laser", "boolean");
  sb.addSubscribe("gun_left", "boolean");
  sb.addSubscribe("gun_right", "boolean");
  sb.connect(server, name, description );

  String portName = Serial.list()[1]; //change the 0 to a 1 or 2 etc. to match your port
  println(portName);
  arduinoPort = new Serial(this, portName, 9600);
}

void draw() {
  //Here just a test for sb.send(); It works!
   float distance;
   while(true){
     distance = random(100);
     //sb.send("distance", str(distance));
   }
   
}


void onRangeMessage( String name, int value ) {
  //println("got range message " + name + " : " + value);
  value += 90;
  println(CMD_HEAD-'0' + "_" + value);
  arduinoPort.write(CMD_HEAD-'0' + "_" + value);
}

void onBooleanMessage( String name, boolean value ) {
  println("got boolean message " + name + " : " + value);
  
  if(!name.equals("laser") && !value) {
    arduinoPort.write(CMD_STOP);
    println("STOP");
    return;
  }
  
  if(name.equals("up")) {
    arduinoPort.write(CMD_FORWARD);
  } else if(name.equals("down")) {
    arduinoPort.write(CMD_BACKWARD);
  } else if(name.equals("left")) {
    arduinoPort.write(CMD_LEFT);
  } else if(name.equals("right")) {
    arduinoPort.write(CMD_RIGHT);
  } else if(name.equals("laser")) {
    if(value) {
      println("FIRE ON");
      arduinoPort.write(CMD_LASER_ON);
    } else {
      println("FIRE OFF");
       arduinoPort.write(CMD_LASER_OFF);
       arduinoPort.write(CMD_LASER_OFF);
       arduinoPort.write(CMD_LASER_OFF);
    }
  } else if(name.equals("gun_left")) {
    if(value) {
      println("gun_left");
      arduinoPort.write(CMD_GUN_LEFT);
    }
  } else if(name.equals("gun_right")) {
    if(value) {
      println("gun_right");
      arduinoPort.write(CMD_GUN_RIGHT);
    }
  }
}

void onStringMessage( String name, String value ){
  println("got string message " + name + " : " + value);  
}

void onCustomMessage( String name, String type, String value ){
  println("got " + type + " message " + name + " : " + value);
}