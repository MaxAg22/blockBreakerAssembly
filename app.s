.include "constants.s"
.include "rectangle.s"

.globl main

main:
    // x0 contiene la direccion base del framebuffer
	mov x20, x0 // Guarda la dirección base del framebuffer en x20

	mov x9, GPIO_BASE
	str wzr, [x9, GPIO_GPFSEL0]			// Setea gpios 0 - 9 como lectura

    // Configurar posición inicial para el rectangulo

    // Tamaño del rectángulo (en pixeles)
    mov  x23, 160               // Ancho (width)
    mov  x24, 20                // Alto (height)	

	// Calcular punto de inicio del rectángulo (centrado)
    mov x6, SCREEN_WIDTH
    mov x7, SCREEN_HEIGHT

	// Posición inical para el ancho: x = (SCREEN_WIDTH  - width)  / 2
    sub x21, x6, x23
    lsr x21, x21, #1
	// Posición inical para la altura: y = (SCREEN_HEIGHT - height)
    sub x22, x7, x24

    // Dibujar primer rectangulo (única vez)
    mov x1, x23         // Ancho
    mov x2, x24         // Altura
    mov x3, x21         // x-coord 
    mov x4, x22         // y-coord
    movz x5, 0xFF, lsl 16 // Color
    movk x5, 0xFFFF, lsl 0
    bl draw_rectangle

    mov x25, 0          // Offset del rectanglujo inicial

InfLoop:

	ldr w10, [x9, GPIO_GPLEV0]			// Lee el estado de los GPIO 0 - 31

	// And bit a bit mantiene el resultado del bit 2 en w10 (notar 0b... es binario)
	// al inmediato se lo refiere como "máscara" en este caso:
	// - Al hacer AND revela el estado del bit 2
	// - Al hacer OR "setea" el bit 2 en 1
	// - Al hacer AND con el complemento "limpia" el bit 2 (setea el bit 2 en 0)
	and w11, w10, GPIO_D
    and w12, w10, GPIO_A

    // Si W11 es distinto de 0 entonces GPIO_1 (W) fue presionada 
    cbnz w11, draw_and_move_right
    cbnz w12, draw_and_move_left

    b InfLoop

draw_and_move_right:

    add x6, x23, x21 // offset actual + tamaño
    cmp x6, SCREEN_WIDTH
    b.eq InfLoop

    // Borrar el rectangulo anterior
    // Solo cambia el color, utiliza las ultimas coordenadas.
    movz x5, 0x00, lsl 16
    movk x5, 0x0000, lsl 0
    bl draw_rectangle

    // Incrementar el offset
    add x25, x25, 1

    // Incrementar x-coord
    add x21, x21, 1

    // Nueva posición
    mov x1, x23         // Ancho
    mov x2, x24         // Altura
    mov x3, x21         // x-coord 
    mov x4, x22         // y-coord
    movz x5, 0xFF, lsl 16 // Color
    movk x5, 0xFFFF, lsl 0
    bl draw_rectangle
    mov x19, 0x500000
    bl delay_loop

draw_and_move_left:

    // Si el offset actual es 0, no dibujamos más
    cmp x21, #0
    b.le InfLoop

    // Borrar el rectangulo anterior
    // Solo cambia el color, utiliza las ultimas coordenadas.
    movz x5, 0x00, lsl 16
    movk x5, 0x0000, lsl 0
    bl draw_rectangle

    // decrementar el offset
    sub x25, x25, 1

    // decrementar x-coord
    sub x21, x21, 1

    // Nueva posición
    mov x1, x23         // Ancho
    mov x2, x24         // Altura
    mov x3, x21         // x-coord 
    mov x4, x22         // y-coord
    movz x5, 0xFF, lsl 16 // Color
    movk x5, 0xFFFF, lsl 0
    bl draw_rectangle
    mov x19, 0x500000
    bl delay_loop

// Corto delay para hacer el movimiento visible
delay_loop:
    sub x19, x19, #1
    cbnz x19, delay_loop

    b InfLoop
