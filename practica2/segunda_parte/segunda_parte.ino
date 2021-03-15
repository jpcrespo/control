
int cnt=1;
int led1=13;
int led2=12;
int led3=11;
int led4=10;
int led5=9;
int led6=8;
int led7=7;
int led8=6;

void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
    pinMode(led1,OUTPUT);
  pinMode(led2,OUTPUT);
  pinMode(led3,OUTPUT);
  pinMode(led4,OUTPUT);
  pinMode(led5,OUTPUT);
  pinMode(led6,OUTPUT);
  pinMode(led7,OUTPUT);
  pinMode(led8,OUTPUT);

}

void loop() {
  // read the input on analog pin 0:
  int sensorValue = analogRead(A0);
  // Convert the analog reading (which goes from 0 - 1023) to a voltage (0 - 5V):
  int sensorValue1=constrain(sensorValue, 0, 255);
  delay(300);
  Serial.println(sensorValue1,BIN);
  for (int m=0; m<=7; m++) {
     digitalWrite(6+m, bitRead(sensorValue1, m));
      }
      delay(100);
}
