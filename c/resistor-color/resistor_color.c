#include "resistor_color.h"

int color_code(char color) {
  switch (color) {
  case BLACK:
    return 0;

  case BROWN:
    return 1;

  case RED:
    return 2;

  case ORANGE:
    return 3;

  case YELLOW:
    return 4;

  case GREEN:
    return 5;

  case BLUE:
    return 6;

  case VIOLET:
    return 7;

  case GREY:
    return 8;

  case WHITE:
    return 9;
  }

  return -1;
}

int *colors(void) {
  static int colors[10];

  colors[0] = 0;
  colors[1] = 1;
  colors[2] = 2;
  colors[3] = 3;
  colors[4] = 4;
  colors[5] = 5;
  colors[6] = 6;
  colors[7] = 7;
  colors[8] = 8;
  colors[9] = 9;

  return colors;
}
