#include <AFMotor.h>
AF_DCMotor motorL(1);
AF_DCMotor motorR(2);

const int CMD_FORWARD  = 1;
const int CMD_BACKWARD = 2;
const int CMD_LEFT     = 3;
const int CMD_RIGHT    = 4;
const int CMD_STOP     = 5;

void setup() {
  Serial.begin(9600);
  motorL.setSpeed(255);
  motorR.setSpeed(255);

  //this will allow the parseInt to read faster and 
  //the arduino board will responsd faster
  Serial.setTimeout(50);   
}

void loop() {
  int cmd = Serial.parseInt();
  Serial.println(cmd);
  
  switch(cmd) {
    case CMD_FORWARD:
    moveForward();
    break;
    
    case CMD_BACKWARD:
    moveBackward();
    break;
    
    case CMD_LEFT:
    moveLeft();
    break;
    
    case CMD_RIGHT:
    moveRight();
    break;
    
    case CMD_STOP:
    stopMotors();
    break;
  }

}

void moveForward() {
  motorL.run(FORWARD);
  motorR.run(FORWARD);
}

void moveBackward() {
  motorL.run(BACKWARD);
  motorR.run(BACKWARD);
}

void moveLeft() {
  motorL.run(BACKWARD);
  motorR.run(FORWARD);
}

void moveRight() {
  motorR.run(BACKWARD);
  motorL.run(FORWARD);
}

void stopMotors() {
  motorR.run(RELEASE);
  motorL.run(RELEASE);
}


