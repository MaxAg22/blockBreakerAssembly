.ifndef RECTANGLE_S

RECTANGLE_S:

    .include "constants.s"

draw_rectangle:
    sub sp, sp, #96       
    stp x1, x2, [sp, #0]
    stp x3, x4, [sp, #16]
    stp x5, x6, [sp, #32]
    stp x7, x8, [sp, #48]
    str x9,     [sp, #64]
    str x10,    [sp, #72]
    str x11,    [sp, #80]

    // Cargar SCREEN_WIDTH y calcular stride
    mov x6, SCREEN_WIDTH
    lsl x7, x6, #2          // SCREEN_WIDTH * 4
    lsl x8, x1, #2          // width * 4
    sub x7, x7, x8          // stride = total_bytes_fila - bytes_dibujados


    // Calcular dirección inicial del framebuffer
 	// Dirección_inicio = Dirección_base + 4 * [x + (y * SCREEN_WIDTH)]
    mul  x8, x4, x6            // y * SCREEN_WIDTH
    add  x8, x8, x3            // + x
    lsl  x8, x8, #2            // * 4 bytes por pixel
    add  x9, x0, x8            // x9 = framebuffer + offset

    mov x10, x2
// Loop de dibujo
draw_rect:
    mov  x11, x1                	// Contador x
draw_row:
    str  w5, [x9]				// Colorear el píxel N
    add  x9, x9, 4				// Siguiente píxel
    subs x11, x11, 1				// Decrementar contador X
    b.ne draw_row				// Si no terminó la fila, salto

    add  x9, x9, x7            	// Salto a siguiente fila
    subs x10, x10, 1             	// Altura--
    b.ne draw_rect			   	// Si no es la última fila, salto

    ldp x1, x2, [sp, #0]
    ldp x3, x4, [sp, #16]
    ldp x5, x6, [sp, #32]
    ldp x7, x8, [sp, #48]
    ldr x9,     [sp, #64]
    ldr x10,    [sp, #72]
    ldr x11,    [sp, #80]
    add sp, sp, #96

    ret

.endif
