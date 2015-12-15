int sensorPin = A0;
int speakerPin = 10;
int sensorValue = 400; 

void setup() {
  // put your setup code here, to run once:
  pinMode(sensorPin, INPUT);
  pinMode(speakerPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  int light= analogRead(sensorPin);
  if (light > sensorValue){
    analogWrite(speakerPin, 200);
  } else {
    analogWrite(speakerPin, 0);
  }
  Serial.println(light);
}
