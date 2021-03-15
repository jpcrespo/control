int out1 = 0;
int out2 = 0;

void setup() {
   // inicializar puerto serie
   Serial.begin(9600);
}

void loop() {
   // leer pines
   out1 = analogRead(A0);
   out2 = analogRead(A1);
   // enviar
   Serial.print(out1);
   Serial.print(",");
   Serial.println(out2);
   // esperar
   delay(20);
}
