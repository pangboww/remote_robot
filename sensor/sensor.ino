int sensorPin = A0;
int speakerPin = 8;
int sensorValue = 400; 

void setup() {
  // put your setup code here, to run once:
  pinMode(sensorPin, INPUT);
  pinMode(speakerPin, OUTPUT);
//  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  int light= analogRead(sensorPin);
  if (light > sensorValue){
    digitalWrite(speakerPin, HIGH);
  } else {
    digitalWrite(speakerPin, LOW);
  }
//  Serial.println(light);
}
