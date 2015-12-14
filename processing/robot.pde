import spacebrew.*;

String server="52.19.162.255";
String name="Processing";
String description ="This is the Processing side who will listen the web side commond";

Spacebrew sb;

void setup() {
  sb = new Spacebrew( this );

  sb.addSubscribe("up", "boolean");
  sb.addSubscribe("down", "boolean");
  sb.addSubscribe("left", "boolean");
  sb.addSubscribe("right", "boolean");
  sb.connect(server, name, description );

}

void draw() {
  // do whatever you want to do here  
}


void onRangeMessage( String name, int value ){
  println("got range message " + name + " : " + value);
}

void onBooleanMessage( String name, boolean value ){
  println("got boolean message " + name + " : " + value);  
}

void onStringMessage( String name, String value ){
  println("got string message " + name + " : " + value);  
}

void onCustomMessage( String name, String type, String value ){
  println("got " + type + " message " + name + " : " + value);  
}