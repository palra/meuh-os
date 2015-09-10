#include "screen.hpp"

extern "C" {
	void _start(void) {
	    Screen::putChar('H'); // TODO : fix that
		while (1);
	}
}