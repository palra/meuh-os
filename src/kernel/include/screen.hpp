#pragma once

#include "types.hpp"

namespace Screen {
	enum class Color : char {
		BLACK,   // 000
		BLUE,    // 001
		GREEN,   // 010
		CYAN,    // 011
		RED,     // 100
		MAGENTA, // 101
		YELLOW,  // 110
		WHITE    // 111
	};

	/*
		Representation in memory of an attribute :
		+---+-------+---+-------+
		| a | b c d | e | f g h |
		+---+-------+---+-------+

		 - a   : Blinking
		 - bcd : Background color (see enum Color)
		 - e   : Highlighted
		 - fgh : Foreground color
	*/
	extern const unsigned char *ramScreen;
	extern const char scrWidth;
	extern const char sccrHeight;
	extern char cAttrs;

	extern uchar cX;
	extern uchar cY;

	bool getBlink();
	void setBlink(bool blink);

	bool getHighlight();
	void setHighlight(bool highlight);

	Color getFgColor();
	void setFgColor(Color color);
	void setFgColor(char color);

	Color getBgColor();
	void setBgColor(Color color);
	void setBgColor(char color);

	void putChar(char c);
}