import time
from machine import Pin, I2C
import neopixel
from HC_SR04 import HCSR04
import SSD1306 as ssd1306

i2c = I2C(scl=Pin(15), sda=Pin(4), freq=400000)      #Init i2c
lcd=ssd1306.SSD1306_I2C(128,64,i2c)
sensor = HCSR04(trigger_pin=13, echo_pin=12,echo_timeout_us=1000000)
np = neopixel.NeoPixel(Pin(14), 2)

# Hole size in mm
TRIGGER_DISTANCE = 150

score = 0

try:
    while True:

        distance = sensor.distance_mm()
        #print(distance)

        if distance < TRIGGER_DISTANCE:
            score += 1

            print("*** POINT SCORED! ***")

            # Display the score on the display
            lcd.fill(0)
            lcd.text("SCORE!",30,20)
            lcd.text(str(score),30,40)
            #lcd.text("Distance:",30,20)
            #lcd.text(str(distance),30,40)
            lcd.show()

            # TODO: Flash the LEDs

            np[0] = (0, 255, 0)
            np[1] = (0,0,0)
            np.write()
            time.sleep(.25)
            np[0] = (0,0,0)
            np[1] = (0,255,0)
            np.write()
            time.sleep(.25)
            np[0] = (0,255,0)
            np[1] = (0,0,0)
            np.write()
            time.sleep(.25)
            np[0] = (0,0,0)
            np[1] = (0,0,0)
            np.write()

except KeyboardInterrupt:
       pass
