int cnt=1;
int valor=0;
int seno[] = {127, 149, 170, 190, 208, 224, 236, 246, 252, 254, 252, 246, 236, 224, 208, 190, 170, 149, 127, 104, 83, 63, 45, 29, 17, 7, 1, 0, 1, 7, 17, 29, 45, 63, 83, 104};
int interruptor=1;
int freq=0;
void setup() 
{
attachInterrupt(interruptor, contador, RISING);
 Serial.begin(9600);
}

void loop() {
  Serial.print("contador  ");
  Serial.println(cnt);
  freq=10*analogRead(A0);
  freq=constrain(freq,5,2000);
  Serial.print("freq  ");
  Serial.println(freq);
  // put your main code here, to run repeatedly:
switch (cnt) {
    case 1:  //senoidal
      for(valor=0;valor<=36;valor++)
        {
          analogWrite(9,seno[valor]);
          delay(freq/36); //1 a 500
        } 
    break;
     
    case 2:   // cuadrada;
    analogWrite(9,255);
    delay(freq/2);
    analogWrite(9,0);
    delay(freq/2);
    break;
    
    case 3: //diente sierra
    for(valor=0;valor<=255;valor=valor+14)
    {
    analogWrite(9,valor);
    delay(freq/36);
    }
    for(valor=255;valor>=0;valor=valor-14)
    {
    analogWrite(9,valor);
    delay(freq/36);
    }
    break;
    
    default: 
    cnt=1;  // default is optional
    break;
  }  
  
}


void contador() {
  cnt++; 
  Serial.print("contador  ");
  Serial.println(cnt);
  
}
