#include "screen.hpp"
#include "types.hpp"
#include "bitfields.hpp"

namespace Screen {
	const unsigned char *ramScreen = (unsigned char*) 0xB8000;
	const char scrWidth = 80;
	const char scrHeight = 25;
	char cAttrs = 0x7;

	uchar cX = 0;
	uchar cY = 0;

	bool getBlink() {
		return MASK_GET_BIT(cAttrs, 7);
	}

	void setBlink(bool blink) {
		if(blink) {
			cAttrs = MASK_SET_BIT_ON(cAttrs, 7);
		} else {
			cAttrs = MASK_SET_BIT_OFF(cAttrs, 7);
		}
	}


	bool getHighlight() {
		return MASK_GET_BIT(cAttrs, 3);
	}

	void setHighlight(bool highlight) {
		if(highlight) {
			cAttrs = MASK_SET_BIT_ON(cAttrs, 3);
		} else {
			cAttrs = MASK_SET_BIT_OFF(cAttrs, 3);
		}
	}

	Color getFgColor() {
		return static_cast<Color>(MASK_GET_FROM_TO(cAttrs, 4, 7));
	}

	void setFgColor(char color) {
		MASK_SET_FROM_TO(cAttrs, color, 4, 7);
	}

	void setFgColor(Color color) {
		setFgColor((char) color);
	}


	Color getBgColor() {
		return static_cast<Color>(MASK_GET_FROM_TO(cAttrs, 0, 3));
	}

	void setBgColor(char color) {
		MASK_SET_FROM_TO(cAttrs, color, 0, 3);
	}

	void setBgColor(Color color) {
		setBgColor((char) color);
	}

	void putChar(char c) {
		uchar *video = (uchar*)(ramScreen + 2 * cX + 2 * scrWidth * cY);
		*video = c;
		*(video + 1) = cAttrs;
	}
}