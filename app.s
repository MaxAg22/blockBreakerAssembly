	.include "constants.s"
	.include "rectangle.s"

	.globl main

main:
	// x0 contiene la direccion base del framebuffer
	mov x20, x0 // Guarda la dirección base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------

	movz x10, 0xC7, lsl 16
	movk x10, 0x1585, lsl 00

    //=======================================================================
    //          DIBUJAR RECTANGULO PRINCIPAL    
    //=======================================================================

	// Tamaño del rectángulo (en pixeles)
	mov  x1, 160               // Ancho (width)
    mov  x2, 20                // Alto (height)	

	// Calcular punto de inicio del rectángulo (centrado)
    mov x6, SCREEN_WIDTH
	mov x7, SCREEN_HEIGHT

	// Posición inical para el ancho: x = (SCREEN_WIDTH  - width)  / 2
	sub x3, x6, x1
	lsr x3, x3, #1
	// Posición inical para la altura: y = (SCREEN_HEIGHT - height)
	sub x4, x7, x2

	// Color
    movz x5, 0xFF, lsl 16      
    movk x5, 0xFFFF, lsl 0

	bl draw_rectangle









	// Ejemplo de uso de gpios
	mov x9, GPIO_BASE

	// Atención: se utilizan registros w porque la documentación de broadcom
	// indica que los registros que estamos leyendo y escribiendo son de 32 bits

	// Setea gpios 0 - 9 como lectura
	str wzr, [x9, GPIO_GPFSEL0]

	// Lee el estado de los GPIO 0 - 31
	ldr w10, [x9, GPIO_GPLEV0]

	// And bit a bit mantiene el resultado del bit 2 en w10 (notar 0b... es binario)
	// al inmediato se lo refiere como "máscara" en este caso:
	// - Al hacer AND revela el estado del bit 2
	// - Al hacer OR "setea" el bit 2 en 1
	// - Al hacer AND con el complemento "limpia" el bit 2 (setea el bit 2 en 0)
	and w11, w10, 0b00000010

	// si w11 es 0 entonces el GPIO 1 estaba liberado
	// de lo contrario será distinto de 0, (en este caso particular 2)
	// significando que el GPIO 1 fue presionado

	//---------------------------------------------------------------
	// Infinite Loop

InfLoop:
	b InfLoop
