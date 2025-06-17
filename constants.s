#ifndef CONSTANTS_S
#define CONSTANTS_S

.equ SCREEN_WIDTH,   640
.equ SCREEN_HEIGHT,  480
.equ BITS_PER_PIXEL, 32
.equ GPIO_BASE,      0x3f200000
.equ GPIO_GPFSEL0,   0x00
.equ GPIO_GPLEV0,    0x34
.equ GPIO_W,         0b000010        // GPIO_1
.equ GPIO_A,         0b000100        // GPIO_2
.equ GPIO_S,         0b001000        // GPIO_3
.equ GPIO_D,         0b010000        // GPIO_4
.equ GPIO_SPACE,     0b100000        // GPIO_5

#endif

