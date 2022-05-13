int testval;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  testval = 1;
  Serial.write(testval);
  delay(1000);
  

}
