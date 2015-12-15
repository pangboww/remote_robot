#include <Servo.h>
#include <AFMotor.h>

AF_DCMotor motorL(1);
AF_DCMotor motorR(2);

Servo servoHead;
const int laserPin = A0;

const int CMD_FORWARD   = 1;
const int CMD_BACKWARD  = 2;
const int CMD_LEFT      = 3;
const int CMD_RIGHT     = 4;
const int CMD_STOP      = 5;
const int CMD_HEAD      = 6;
const int CMD_LASER_ON  = 7;
const int CMD_LASER_OFF = 8;

const int CMD_GUN_LEFT  = 9;
const int CMD_GUN_RIGHT = 0;

const int len = 80;
char buf[len];
int readLen = 0;

int pos = 90;

void setup() {
  Serial.begin(9600);
  motorL.setSpeed(255);
  motorR.setSpeed(255);

  servoHead.attach(9);
  servoHead.write(pos);

  //this will allow the parseInt to read faster and 
  //the arduino board will responsd faster
  Serial.setTimeout(10);

  pinMode (laserPin, OUTPUT);
}

void loop() {
  if(!Serial.available()) {
    return;
  }

  readLen = Serial.readBytesUntil('\n', buf, len);
  
  if(readLen <= 0) {
    return;
  }
  
  int cmd = buf[0] - '0';
    
    /*for(int i=0; i<readLen; ++i) {
      Serial.println(buf[i]);
    }*/
  

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

    case CMD_LASER_ON:
    digitalWrite (laserPin, HIGH);
    break;

    case CMD_LASER_OFF:
    digitalWrite (laserPin, LOW);
    break;
    
    /*case CMD_HEAD:
    String str = String(buf).substring(2, readLen);
    if(!str.equals("_") && !str.equals("") && !str.equals(" ")) {
      //int pos = str.toInt();
      //Serial.println(pos);
      //servoHead.write(pos);
    }
    break;*/

    case CMD_GUN_LEFT:
    if(pos > 0) {
      pos -= 5;
      servoHead.write(pos);
    }
    break;
    
    case CMD_GUN_RIGHT:
    if(pos < 180) {
      pos += 5;
      servoHead.write(pos);
    }
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


