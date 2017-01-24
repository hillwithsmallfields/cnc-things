/* Sketch for reading current and voltage for my Land Rover's power measurement board.
   It also reads the temperatures of the power components. */

/* Based on http://playground.arduino.cc/Learning/OneWire,
   https://www.arduino.cc/en/Tutorial/HelloWorld, and
   https://www.arduino.cc/en/Tutorial/AnalogInput */

/* Explanation at https://tushev.org/articles/arduino/10/how-it-works-ds18b20-and-arduino */

#include <OneWire.h>
#include <LiquidCrystal.h>

// LCD=======================================================

/* To wire your LCD screen to your board, connect the following pins: */

/*     LCD RS pin to digital pin 12 */
/*     LCD Enable pin to digital pin 11 */
/*     LCD D4 pin to digital pin 5 */
/*     LCD D5 pin to digital pin 4 */
/*     LCD D6 pin to digital pin 3 */
/*     LCD D7 pin to digital pin 2  */

/* Additionally, wire a 10k pot to +5V and GND, with it's wiper
   (output) to LCD screens VO pin (pin3). A 220 ohm resistor is used
   to power the backlight of the display, usually on pin 15 and 16 of
   the LCD connector */

/*******/
/* LCD */
/*******/

//initialize the library with the numbers of the interface pins
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);
#define LCD_WIDTH 20
#define LCD_HEIGHT 2

/**********/
/* Analog */
/**********/

int chargingCurrentPin = A0;
int systemCurrentPin = A1;
int voltagePin = A2;

/****************************/
/* DS18S20 Temperature chip */
/****************************/

#define MAX_DS1820_SENSORS 4

OneWire  ds(9);  // on pin 9
byte addr[MAX_DS1820_SENSORS][8];

/***************/
/* Warning LED */
/***************/

int warningLED = 13;

/*************/
/* Functions */
/*************/

void setup(void)
{
  lcd.begin(LCD_WIDTH, LCD_HEIGHT,1);

  pinMode(warningLED, OUTPUT);

  lcd.setCursor(0,0);
  lcd.print("DS1820 Test");
  int sensor;
  for (sensor = 0; sensor < MAX_DS1820_SENSORS; sensor++) {
    if (!ds.search(addr[sensor])) {
	lcd.setCursor(0,0);
	lcd.print("No more addresses.");
	ds.reset_search();
	delay(250);
	return;
      }
  }
}

int temperatures[MAX_DS1820_SENSORS];

int next_sensor = 0;

char buf[32];

void loop(void)
{
  byte i;
  byte present = 0;
  byte data[12];
  int chargingCurrent;
  int systemCurrent;
  int voltage;

  int TReading;
  if (OneWire::crc8( addr[next_sensor], 7) != addr[next_sensor][7]) {
    lcd.setCursor(0,0);
    lcd.print("CRC is not valid");
    return;
  }

  if ( addr[next_sensor][0] != 0x10) {
    lcd.setCursor(0,0);
    lcd.print("Device is not a DS18S20 family device.");
    return;
  }

  ds.reset();
  ds.select(addr[next_sensor]);
  ds.write(0x44,1); // start conversion, with parasite power on at the end

  delay(1000);			// maybe 750ms is enough, maybe not
  // we might do a ds.depower() here, but the reset will take care of it.

  present = ds.reset();
  ds.select(addr[next_sensor]);
  ds.write(0xBE);		// Read Scratchpad

  for ( i = 0; i < 9; i++) {	// we need 9 bytes
    data[i] = ds.read();
  }

  TReading = (data[1] << 8) + data[0];
  if (TReading & 0x8000) {		// negative
    TReading = (TReading ^ 0xffff) + 1; // 2's comp
  }

  temperatures[next_sensor] = TReading*100/2;

  chargingCurrent = analogRead(chargingCurrentPin);
  systemCurrent = analogRead(systemCurrentPin);
  voltage = analogRead(voltagePin);

  sprintf(buf, "%dV %dA %dA", voltagePin, chargingCurrent, systemCurrent);
  lcd.setCursor(0, 0);
  lcd.print(buf);
  
  sprintf(buf, "%d: %d", next_sensor, temperatures[next_sensor]);
  lcd.setCursor(0, 1);
  lcd.print(buf);

  /* todo: put the warning light on if any temperature is too high */
  
  next_sensor++;
  if (next_sensor >= sensor<MAX_DS1820_SENSORS) {
    next_sensor = 0;
  }

}