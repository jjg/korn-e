#include <DFRobot_PLAY.h>
#include <SoftwareSerial.h>
#include <FastLED.h>

/*
 * Firmware for the korn-e electronic cornhole hardware
 * 
 * Things to do:
 * * Initialize all the hardware
 * * Play an initial sound
 * * Illuminate some inital lights
 * * Watch for a bag in the hole
 * * Play another sound and animate the lights
 * * etc.
 */

// Enables/disables debugging over serial
#define DEBUG true

#define TRIGGER_PIN 6
#define ECHO_PIN 7
#define LED_DATA_PIN 5
#define SOUND_RX_PIN 2
#define SOUND_TX_PIN 3
#define NUM_LEDS 29
#define HOLE_SIZE 3


// Init array for leds
CRGB leds[NUM_LEDS];

// Init serial connection to sound board
SoftwareSerial DF1201SSerial(SOUND_RX_PIN, SOUND_TX_PIN);
DFRobot_PLAY DF1201S;


void setup() {

  // Init serial port for debugging
  if(DEBUG)
    Serial.begin(115200);


  /*** Init the hardware ***/
  
  // Init sound board
  DF1201SSerial.begin(57600);
  while(!DF1201S.begin(DF1201SSerial)){
    if(DEBUG)
      Serial.println("Init failed, please check the wire connection!");
      
    delay(1000);
  }
  // TODO: Disable sound board LED
  DF1201S.setPrompt(false);
  DF1201S.switchFunction(DF1201S.MUSIC);
  DF1201S.setPlayMode(DF1201S.SINGLE);
  DF1201S.setVol(20);
  
  // Init LEDs
  FastLED.addLeds<NEOPIXEL, LED_DATA_PIN>(leds, NUM_LEDS);
  
  // Init rangefinder
  pinMode(TRIGGER_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  // Prime the sensor
  pinMode(TRIGGER_PIN, OUTPUT);
  digitalWrite(TRIGGER_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIGGER_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIGGER_PIN, LOW);
  
  
  /*** Self-test each component ***/

  // Self-test LEDs
  fill_solid( &(leds[0]), NUM_LEDS, CRGB::Green);
  FastLED.show();
  delay(1000);
  fill_solid( &(leds[0]), NUM_LEDS, CRGB::Black);
  FastLED.show();
  delay(1000);

  // Self-test sound
  if (DEBUG){
    Serial.println("--------------");
    Serial.print("PlayMode: ");
    Serial.println(DF1201S.getPlayMode());
    Serial.print("TotalFile: ");
    Serial.println(DF1201S.getTotalFile());
    Serial.print("Vol: ");
    Serial.println(DF1201S.getVol());
    Serial.print("FileName: ");
    Serial.println(DF1201S.getFileName());
    Serial.println("--------------");
  }
    
  // Play start-up sound
  DF1201S.playSpecFile("/fx/startup.mp3");

  // Self-test rangefinder
  // Take a reading
  long duration;
  pinMode(ECHO_PIN, INPUT);
  duration = pulseIn(ECHO_PIN, HIGH);
  if(DEBUG){
    Serial.print("Distance: ");
    Serial.println(microsecondsToInches(duration));
  }

}

void loop() {

  // Measure distance
  long duration, inches;
  pinMode(TRIGGER_PIN, OUTPUT);
  digitalWrite(TRIGGER_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIGGER_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIGGER_PIN, LOW);

  // Take a reading
  pinMode(ECHO_PIN, INPUT);
  duration = pulseIn(ECHO_PIN, HIGH);
  inches = microsecondsToInches(duration);

  if(DEBUG){
    Serial.print("Distance: ");
    Serial.println(inches);
  }

  if(inches < HOLE_SIZE){

    if(DEBUG)
      Serial.println("Score!");
    
    // Flash leds
    fill_solid( &(leds[0]), NUM_LEDS, CRGB::Red);
    FastLED.show();

    // Play score sound (only play a sound if the previously playing sound is done)
    if(DEBUG){
      Serial.print("getCurTime: ");
      Serial.println(DF1201S.getCurTime());
      Serial.print("getTotal_time: ");
      Serial.println(DF1201S.getTotalTime());
    }

    // NOTE: This is a hack because sometimes getCurTime() != getTotalTime() even if
    // the sound has finished playing (I'm guessing this is a rounding error?)
    //if(DF1201S.getCurTime() == DF1201S.getTotalTime()){
    if(DF1201S.getTotalTime() - DF1201S.getCurTime() < 2){
      DF1201S.playSpecFile("/fx/score.mp3");
    }
    
    delay(500);
    fill_solid( &(leds[0]), NUM_LEDS, CRGB::Black);
    FastLED.show();
  }

}

long microsecondsToInches(long microseconds) {
   return microseconds / 74 / 2;
}
