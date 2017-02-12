/* Sketch for reading current and voltage for my Land Rover's power measurement board.

   It reads the current from the alternator to the battery, and from
   the battery to the vehicle's general systems, and displays them on
   an LCD character display connected via a D15 connector, which also
   carries a few other signals to/from the box containing the UI
   components.

   It also reads the temperatures of the power components.

   Based on http://playground.arduino.cc/Learning/OneWire,
   https://www.arduino.cc/en/Tutorial/HelloWorld, and
   https://www.arduino.cc/en/Tutorial/AnalogInput

   Explanation at https://tushev.org/articles/arduino/10/how-it-works-ds18b20-and-arduino

   The physical design to go with this is in power-board.scad in the
   same directory as this program; it defines a stack of plastic
   boards that hold the components in place.
 */

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

/*
    Arduino pinout:

    |-----+-----------+-------+-----+--------------------------------|
    | pin | direction | cable | LCD | function                       |
    |-----+-----------+-------+-----+--------------------------------|
    | A0  | in        |       |     | voltage                        |
    | A1  | in        |       |     | alternator current             |
    | A2  | in        |       |     | vehicle current                |
    | A3  | in        |       |     |                                |
    | D01 |           |       |     |                                |
    | D02 |           |       |     |                                |
    | D03 | in        |    10 |     | button A                       |
    | D04 | in        |    11 |     | button B                       |
    | D05 | out       |     3 |  11 | LCD pin 4                      |
    | D06 | out       |     4 |  12 | LCD pin 5                      |
    | D07 | out       |     5 |  13 | LCD pin 6                      |
    | D08 | out       |     6 |  14 | LCD pin 7                      |
    | D09 |           |       |     |                                |
    | D10 | both      |       |     | onewire to temperature sensors |
    | D11 | out       |     7 |   6 | LCD enable                     |
    | D12 | out       |     8 |   4 | LCD RS                         |
    | D13 | out       |     2 |     | warning LED                    |
    |-----+-----------+-------+-----+--------------------------------|

    I've not yet decided what to assign the buttons to; it'll probably
    be one to snapshot a sequence of readings several times a second
    for a few seconds, and one to step through the saves sequence.

    LCD cable:

    |-------+-----+---------------------------------|
    | cable | LCD | function                        |
    |-------+-----+---------------------------------|
    |     1 |   1 | 0v                              |
    |     2 |     | warning LED                     |
    |     3 |  11 | LCD pin 4                       |
    |     4 |  12 | LCD pin 5                       |
    |     5 |  13 | LCD pin 6                       |
    |     6 |  14 | LCD pin 7                       |
    |     7 |   6 | LCD enable                      |
    |     8 |   4 | LCD RS                          |
    |     9 |     | serial out                      |
    |    10 |     | serial in                       |
    |    11 |     | button A                        |
    |    12 |     | button B                        |
    |    13 |   2 | 5v to LCD                       |
    |    14 |     | 12V back from switch on LCD box |
    |    15 |     | 12V to switch on LCD box        |
    |-------+-----+---------------------------------|
*/

/*******/
/* LCD */
/*******/

//initialize the library with the numbers of the interface pins
// Suggested:
// LiquidCrystal lcd(12, 11, 5, 4, 3, 2);
// Actual:

#define LCD_enable 5
#define LCD_RS 6
#define LCD_D4 7
#define LCD_D5 8
#define LCD_D6 11
#define LCD_D7 12

LiquidCrystal lcd(LCD_enable, LCD_RS, LCD_D4, LCD_D5, LCD_D6, LCD_D7);
#define LCD_WIDTH 16
#define LCD_HEIGHT 2

/**********/
/* Analog */
/**********/

int chargingCurrentPin = A0;
int systemCurrentPin = A1;
int voltagePin = A2;

int voltageScale = 1;

/****************************/
/* DS18S20 Temperature chip */
/****************************/

#define MAX_DS1820_SENSORS 4

OneWire  ds(9);  // on pin 9
byte addrs[MAX_DS1820_SENSORS][8];

int sensors_found = 0;

int temperatures[MAX_DS1820_SENSORS];
char temperature_flags[MAX_DS1820_SENSORS];
int temperature_bits = 0;

/***************/
/* Warning LED */
/***************/

int warningLED = 13;

/********************/
/* Message building */
/********************/

char buf[32];

/*************/
/* Functions */
/*************/

void setup(void)
{
  lcd.begin(LCD_HEIGHT, LCD_WIDTH);

  pinMode(warningLED, OUTPUT);

  lcd.setCursor(0,0);
  for (sensors_found = 0; sensors_found < MAX_DS1820_SENSORS; sensors_found++) {
    ds.reset_search();
    if (!ds.search(addrs[sensors_found])) {
      lcd.setCursor(0,0);
      sprintf(buf, "max addr %d", sensors_found);
      lcd.print(buf);
      ds.reset_search();
    } else {
      switch (addrs[sensors_found][0]) {
      case 0X10: temperature_bits = 9;
        break;
      case 0X28: temperature_bits = 12;
        break;
      default: temperature_bits = 0;
        lcd.setCursor(0,1);
        sprintf(buf, "Wrong device %d", sensors_found);
        lcd.print(buf);
        temperature_flags[sensors_found] = 'D';
        break;
      }
    }
  }
  sprintf(buf, "%d sensors", sensors_found);
  lcd.setCursor(0,1);
  lcd.print(buf);
}

int next_sensor = 0;

int loop_count = 0;

void loop(void)
{
  byte i;
  byte present = 0;
  byte data[12];
  int chargingCurrent;
  int systemCurrent;
  int voltage;

  int TReading;

  delay(1000);                      // maybe 750ms is enough, maybe not

  if (OneWire::crc8(addrs[next_sensor], 7) != addrs[next_sensor][7]) {
    /* lcd.setCursor(0,0); */
    /* lcd.print("CRC is not valid"); */
    temperature_flags[next_sensor] = 'C';
  } else {
      temperature_flags[next_sensor] = 'D';

    if (temperature_bits == 0) {
    } else {
      ds.reset();
      ds.select(addrs[next_sensor]);
      ds.write(0x44,1); // start conversion, with parasite power on at the end

      /* todo: http://playground.arduino.cc/Learning/OneWire says how
         to start all converting at the same time:

         Multiple-device commands

         Alternatively, you can address a command to all slave devices
         by issuing a 'Skip ROM' command (0xCC), instead. It is
         important to consider the effects of issuing a command to
         multiple devices. Sometimes, this may be intended and
         beneficial. For example, issuing a Skip ROM followed by a
         convert T (0x44) would instruct all networked devices that
         have a Convert T command to perform a temperature
         conversion. This can be a time-saving and efficient way of
         performing the operations. On the other hand, issuing a Read
         Scratchpad (0xBE) command would cause all devices to report
         Scratchpad data simultaneously. Power consumption of all
         devices (for example, during a temperature conversion) is
         also important when using a Skip ROM command sequence. */

      // we might do a ds.depower() here, but the reset will take care of it.

      present = ds.reset();
      ds.select(addrs[next_sensor]);
      ds.write(0xBE);           // Read Scratchpad

      for ( i = 0; i < 9; i++) {        // we need 9 bytes
        data[i] = ds.read();
      }

      TReading = (data[1] << 8) + data[0];
      if (TReading & 0x8000) {          // negative
        TReading = (TReading ^ 0xffff) + 1; // 2's comp
      }

      temperatures[next_sensor] = TReading / 16;
      temperature_flags[next_sensor] = 'V';
    }
  }
  next_sensor++;
  if (next_sensor >= sensors_found) {
    next_sensor = 0;
  }

  chargingCurrent = (int)((analogRead(chargingCurrentPin) - 512) / 5.12);
  systemCurrent = (int)((analogRead(systemCurrentPin) - 512) / 5.12);
  voltage = analogRead(voltagePin) / voltageScale;

  lcd.clear();
  sprintf(buf, "%2dV %2dA, %2dA=%2dA",
	  voltagePin,
	  chargingCurrent, systemCurrent,
	  chargingCurrent - systemCurrent);
  lcd.setCursor(0, 0);
  lcd.print(buf);

  /* todo: show all the temperatures */
  sprintf(buf, "%c %d", temperature_flags[0], temperatures[0]);
  lcd.setCursor(0,1);
  lcd.print(buf);

  /* todo: put the warning light on if any temperature is too high */
}