.ifndef CONSTANTS_S

CONSTANTS_S:
	
	.equ SCREEN_WIDTH,   640
	.equ SCREEN_HEIGHT,   480
	.equ BITS_PER_PIXEL, 32
	.equ GPIO_BASE,    0x3f200000
	.equ GPIO_GPFSEL0, 0x00
	.equ GPIO_GPLEV0,  0x34
	
	
	ret
	
.endif
