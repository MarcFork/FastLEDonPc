# FastLED on PC

## What?

With this software you can run an Arduino Sketch on your PC.
In particular, you can run [FastLED](http://fastled.io/) sketches with [Adafruit-GFX](https://learn.adafruit.com/adafruit-gfx-graphics-library/).

It is made for Linux using SDL.

![Hello World!](https://user-images.githubusercontent.com/1301112/49700142-37f4cd80-fbdb-11e8-8783-30b7dcfdaad9.png)

## Why?

It takes three weeks to ship a serial LED strip from China, but I want to start coding animations now!

# HowTo

If you are using [Arduino Make](https://github.com/sudar/Arduino-Makefile), it should be sufficient to
replace the `Arduino.mk` include with `makeNativeArduino.mk` in your Makefile.
Then simply run `make` as usual.

See the `example/` directory for an example.

This uses a patched version of FastLED which outputs to a SDL buffer instead of real hardware.

You use the following enviroment variables to control the simulated LED matrix:

 - `FASTLED_WIDTH`: With of the Matrix
 - `FASTLED_HEIGHT`: Height of the Matrix
 - `FASTLED_SCALE`: How many screen pixels each LED should be represented as

The Layout for NeoMatrix is `NEO_MATRIX_TOP + NEO_MATRIX_LEFT + NEO_MATRIX_ROWS` (no ZIGZAG as you would want on real hardware)

# Installation

SDL is used to render a simulation of the LED-Strip Matrix.
To install the required dependencies, run

```
sudo apt install libsdl2-dev
```
