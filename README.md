# FastLED on PC

## What?

With this software you can run an Arduino Sketch on your PC and is specifically designed to test code written for any of:
- https://github.com/marcmerlin/Framebuffer_GFX (base class)
- https://github.com/pixelmatix/SmartMatrix
- https://github.com/adafruit/Adafruit-GFX-Library
- https://github.com/FastLED/FastLED  
- https://github.com/marcmerlin/LEDMatrix
using SDL on Linux

If you have run code that runs on any of:
- https://github.com/marcmerlin/FastLED_NeoMatrix/
- https://github.com/marcmerlin/SmartMatrix_GFX/
- https://github.com/marcmerlin/FastLED_SPITFT_GFX (SSD1331, ILI9341, and ST7735 TFTs)
it can then run with this linux/SDL backend too.

![102_demo_snaps](https://user-images.githubusercontent.com/1369412/71480161-a982c800-27ac-11ea-8f0e-fb149b6a9ae2.jpg)
![103_demo_snaps](https://user-images.githubusercontent.com/1369412/71480163-abe52200-27ac-11ea-9cb1-f4d23bdf96ac.jpg)

## Why?

Ben's original answer:  
It takes three weeks to ship a serial LED strip from China, but I want to start coding animations now!

Marc's new answer:  
- Complicated code can take a while to write and debug, and it's just much faster on a PC than actual hardware.
- It also makes it easier to test code to see whether it works on resolutions like 320x240 if you don't have capable hardware like ILI9341 supported by https://github.com/marcmerlin/FastLED_SPITFT_GFX
- You can work on your demo code while travelling and without having to carry bigger matrix displays

# HowTo

If you are using [Arduino Make](https://github.com/sudar/Arduino-Makefile), it should be sufficient to
replace the `Arduino.mk` include with `makeNativeArduino.mk` in your Makefile.
Then simply run `make` as usual.
This uses a patched version of FastLED which outputs to a SDL buffer instead of real hardware.

**If things appear too dark, use the `+` key to increase brightness.**

See the `example/` directory for examples.

If you use FastLED_NeoMatrix_SmartMatrix_LEDMatrix_GFX_Demos, you can simply use neomatrix_config.h and it will set everything up for you.

If you want to do it manually like in example/hello_world: 
```
FastLED.addLeds<WS2812B, DATA_PIN>(leds, num_leds);   # before
FastLED.addLeds<SDL, width, height>(leds, num_leds);  # after
```
The Layout for NeoMatrix is `NEO_MATRIX_TOP + NEO_MATRIX_LEFT + NEO_MATRIX_ROWS` (no ZIGZAG as you would want on real hardware).


# Installation

SDL is used to render a simulation of the LED-Strip Matrix.
To install the required dependencies, run

```
sudo apt install libsdl2-dev
```

The project uses git submodules to include the Arduino libraries. To get them, you have to run

```
git submodule init
git submodule update
```

after checking out the repository.
