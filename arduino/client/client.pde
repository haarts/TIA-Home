int total_period = 30 * 60;
//unsigned long total_period = 1 * 10 * 1000;
int on_period = 5 * 60;
//unsigned long on_period = 1 * 2 * 1000;
unsigned long loop_sleep = 1000;
int relayPin = 4;
int temperaturePin = 0;
float average;
int hostVoltage = 4820;
  
void setup() {
  pinMode(relayPin, OUTPUT);
  digitalWrite(relayPin, HIGH);
  Serial.begin(9600);
}

void loop() {
  int seconds = millis() / 1000;
  if((seconds % total_period) < on_period) {
    digitalWrite(relayPin, HIGH);
  } else {
    digitalWrite(relayPin, LOW);
  }
  
  if((seconds % 5) == 0) {
    float temperature = getTemperature();
    average = temperature;
  }
  if((seconds % 5) == 1 || (seconds % 5) == 2 || (seconds % 5) == 3) {
    average = average + getTemperature();
  }
  if((seconds % 5) == 4) {
    float temperature = getTemperature();
    Serial.println((average + temperature)/ 5);
    average = 0.0;
  }
  delay(loop_sleep);
}

float getTemperature() {
  float voltage = (analogRead(temperaturePin) / 1024.0) * hostVoltage;
  return (voltage - 500) / 10;
}
