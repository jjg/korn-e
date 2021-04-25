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

#define TRIGGER_PIN 6
#define ECHO_PIN 7
#define LED_DATA_PIN 5
#define SOUND_RX_PIN 2
#define SOUND_TX_PIN 3
#define NUM_LEDS 29
#define HOLE_SIZE 6


// Init array for leds
CRGB leds[NUM_LEDS];

// Init serial connection to sound board
SoftwareSerial DF1201SSerial(SOUND_RX_PIN, SOUND_TX_PIN);
DFRobot_PLAY DF1201S;
//SoftwareSerial DFPLAYER(SOUND_RX_PIN, SOUND_TX_PIN);

void setup() {

  // Enable serial for debugging
  Serial.begin(115200);
    
  // Init the hardware
  
  // Init the sound board
  DF1201SSerial.begin(57600);
  while(!DF1201S.begin(DF1201SSerial)){
    Serial.println("Init failed, please check the wire connection!");
    delay(1000);
  }
  
  // Init the LEDs
  FastLED.addLeds<NEOPIXEL, LED_DATA_PIN>(leds, NUM_LEDS);
  
  // Init the rangefinder
  pinMode(TRIGGER_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  
  // Self-test each component
  
  // Self-test LEDs
  fill_solid( &(leds[0]), NUM_LEDS, CRGB::Green);
  FastLED.show();
  delay(1000);
  fill_solid( &(leds[0]), NUM_LEDS, CRGB::Black);
  FastLED.show();
  delay(1000);

  
  // Self-test sound
  /*
  Serial.println("---------------");
  Serial.print("AT: ");
  Serial.println(DFPLAYER.write("AT\r\n"));
  Serial.print("AT+PROMPT=ON");
  Serial.print(DFPLAYER.write("AT+PROMPT=ON\r\n"));
  Serial.print("AT+VOL=?: ");
  Serial.println(DFPLAYER.write("AT+VOL=?\r\n"));
  Serial.println(DFPLAYER.write("AT+PLAYMODE=3\r\n"));
  //delay(2000);
  Serial.println(DFPLAYER.write("AT+PLAYFILE=roar.mp3\r\n"));
  Serial.print("AT+QUERY=1: ");
  Serial.println(DFPLAYER.write("AT+QUERY=1\r\n"));
  */

  //DF1201S.setBaudRate(57600);
  
  Serial.println("--------------");
  //DF1201S.begin();
  DF1201S.setPrompt(false);
  DF1201S.setPlayMode(DF1201S.SINGLE);
  Serial.print("PlayMode: ");
  Serial.println(DF1201S.getPlayMode());
  DF1201S.switchFunction(DF1201S.MUSIC);
  Serial.print("TotalFile: ");
  Serial.println(DF1201S.getTotalFile());
  DF1201S.setVol(20);
  Serial.print("Vol: ");
  Serial.println(DF1201S.getVol());
  Serial.print("FileName: ");
  Serial.println(DF1201S.getFileName());
  //DF1201S.start();
  DF1201S.playSpecFile("T-Rex1.mp3");

  delay(1000);
  //DF1201S.pause();
  
  /*
  DF1201S.setPrompt(false);
  DF1201S.setVol(20);
  Serial.print("Vol: ");
  Serial.println(DF1201S.getVol());
  DF1201S.switchFunction(DF1201S.MUSIC);
  delay(2000);
  DF1201S.setPlayMode(DF1201S.SINGLE);
  Serial.print("PlayMode: ");
  Serial.println(DF1201S.getPlayMode());
  Serial.print("TotalFile: ");
  Serial.println(DF1201S.getTotalFile());
  //DF1201S.start();
  DF1201S.playSpecFile("roar.mp3");
  */

  // Self-test rangefinder
  // Prime the sensor
  long duration;
  pinMode(TRIGGER_PIN, OUTPUT);
  digitalWrite(TRIGGER_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIGGER_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIGGER_PIN, LOW);

  // Take a reading
  //unsigned long duration;
  pinMode(ECHO_PIN, INPUT);
  duration = pulseIn(ECHO_PIN, HIGH);
  Serial.print("Distance: ");
  Serial.println(microsecondsToInches(duration));

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
  //unsigned long duration;
  pinMode(ECHO_PIN, INPUT);
  duration = pulseIn(ECHO_PIN, HIGH);
  inches = microsecondsToInches(duration);

  //Serial.print("Distance: ");
  //Serial.println(inches);

/*
  Serial.print("getCurTime: ");
  Serial.println(DF1201S.getCurTime());
  Serial.print("getTotalTime: ");
  Serial.println(DF1201S.getTotalTime());
*/

  if(inches < 3){

    Serial.println("Score!");
    
    // Flash leds
    fill_solid( &(leds[0]), NUM_LEDS, CRGB::Red);
    FastLED.show();

    // Only play a sound if the previously playing sound is done
    if(DF1201S.getCurTime() == DF1201S.getTotalTime()){
      // Play sound
      //DF1201S.start();
      //DF1201S.pause();
      DF1201S.playSpecFile("T-Rex1.mp3");
    }
    
    delay(500);
    fill_solid( &(leds[0]), NUM_LEDS, CRGB::Black);
    FastLED.show();
  }
}

long microsecondsToInches(long microseconds) {
   return microseconds / 74 / 2;
}
