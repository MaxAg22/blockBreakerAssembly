.ifndef RECTANGLE_S

RECTANGLE_S:

    .include "constants.s"

draw_rectangle:

    // Cargar SCREEN_WIDTH y calcular stride
    mov  x6, SCREEN_WIDTH      
    sub  x7, x6, x1            // SCREEN_WIDTH - width
    lsl  x7, x7, #2            // Stride en bytes

    // Calcular dirección inicial del framebuffer
 	// Dirección_inicio = Dirección_base + 4 * [x + (y * SCREEN_WIDTH)]
    mul  x8, x4, x6            // y * SCREEN_WIDTH
    add  x8, x8, x3            // + x
    lsl  x8, x8, #2            // * 4 bytes por pixel
    add  x0, x0, x8            // x0 = framebuffer + offset

// Loop de dibujo
draw_rect:
    mov  x9, x1                	// Contador x
draw_row:
    str  w5, [x0]				// Colorear el píxel N
    add  x0, x0, 4				// Siguiente píxel
    subs x9, x9, 1				// Decrementar contador X
    b.ne draw_row				// Si no terminó la fila, salto

    add  x0, x0, x7            	// Salto a siguiente fila
    subs x2, x2, 1             	// Altura--
    b.ne draw_rect			   	// Si no es la última fila, salto

    ret

.endif
