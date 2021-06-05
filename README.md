# korn-e


# Notes

Quickly scratching-out notes for building this as it's been a bit of a nightmare.

Using Adafruit's [tinyisp](https://learn.adafruit.com/usbtinyisp) to program the Atmega328p once its in the breakout board doesn't work out-of-the box using the [Arduino](https://www.arduino.cc/) IDE.  Instead, you have to generate a .hex file, and then upload it manually using [avrdude](http://www.nongnu.org/avrdude/).

To generate the .hex file, click the Sketch menu and select Export compiled Binary.  This will write out two .hex files in the [firmware](./firmware/arduino/firmware) directory.

Next load the .hex file onto the Atmega328p using avrdude:

```
avrdude -c usbtiny -p atmega328p -B10 -U flash:w:firmware.ino.standard.hex
```

The secret ingredient is the `-B10` flag, without this upload errors occur and you're screwed (this is what happens when you try to use the Arduino IDE directly).



# References

* https://github.com/jjg/laserharp/blob/main/firmware.py
* https://docs.micropython.org/en/latest/esp8266/tutorial/neopixel.html
* https://www.makerfabs.cc/article/micropython-esp32-tutorial-interfacing-ultrasonic-sensor.html
* https://github.com/jjg/linebird/blob/main/journal.md
* https://github.com/miketeachman/micropython-esp32-i2s-examples
* https://wiki.dfrobot.com/DFPlayer_PRO_SKU_DFR0768
* https://github.com/DFRobot/DFRobot_DF1201S
* https://create.arduino.cc/projecthub/robocircuits/neopixel-tutorial-1ccfb9
* https://github.com/CharlesJGantt/Illuminate-NeoPixels-using-an-HC-SR04-Distance-Sensor-and-an-Arduino/blob/master/NeoPixels_HC-SR04.ino
* https://github.com/FastLED/FastLED/wiki/Basic-usage
* https://www.arduino.cc/reference/en/language/functions/advanced-io/pulsein/
* https://www.tutorialspoint.com/arduino/arduino_ultrasonic_sensor.htm
* http://www.martyncurrey.com/arduino-atmega-328p-fuse-settings/
* https://forums.adafruit.com/viewtopic.php?t=64694
* http://www.ladyada.net/learn/avr/avrdude.html
* https://learn.adafruit.com/usbtinyisp/avrdude
* https://www.instructables.com/Program-Arduino-Mini-05-with-FTDI-Basic/ 
