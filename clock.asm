MODEL small
.STACK 100h
INCLUDE procs.inc
LOCALS
.DATA
    flag db 0
    contador db 0
    segundos dw 50
    minutos dw 58
    horas dw 0
    signo db ":", 0
nueva_linea db 13, 10, 0
.CODE

Principal		PROC
                mov ax, 0
                mov ds, ax
                mov bx, 70h
                mov word ptr[bx], offset RSI
                mov [bx+2], cs
                mov ax, @data
                mov ds, ax

                mov ax, [segundos]
                mov bx, 10
@@verif:        cmp [flag], 1
                jne @@verif
                je @@imprime

@@imprime:      call clrscr
                call ContHora
                mov dx, offset signo
                call puts
                call ContMin
                mov dx, offset signo
                call puts
                call ContSeg

                cmp [segundos], 59
                jb @@sigue
                je @@verifmin

@@verifmin:     cmp [minutos], 59
                jb @@minuto
                je @@hora

@@hora:         mov [minutos], -1
                inc [horas]

@@minuto:       mov [segundos], -1
                inc [minutos]

@@sigue:        inc [segundos]
                mov ax, [segundos]

                mov [contador], 0
                mov [flag], 0
                jmp @@verif
				ENDP


RSI             PROC    ;interrupcion 1Ch
                inc [contador]
                cmp [contador], 18
                jne @@salir
                je @@activa

@@activa:       mov [flag], 1
@@salir:        iret
                ENDP


ContSeg         PROC   ;imprime los segundos del reloj
                push ax
                push bx
                push cx
                push dx
                mov cx, 1
        @@nxt:  mov dx, 0
                div bx
                push dx
                cmp ax, 10
                jb @@print
                jz @@printnum
                add ax, 7
    @@print: add ax, 30h
                call putchar
                pop dx
                mov ax, dx
    @@printnum: mov ax, dx
                add ax, 30h
                call putchar
                loop @@nxt
                pop dx
                pop cx
                pop bx
                pop ax
                ret
                ENDP

ContMin         PROC   ;imprime los minutos del reloj
                push ax
                push bx
                push cx
                push dx
                mov ax, [minutos]
                mov bx, 10
                mov cx, 1
        @@nxt:  mov dx, 0
                div bx
                push dx
                cmp ax, 10
                jb @@print
                jz @@printnum
                add ax, 7
    @@print: add ax, 30h
                call putchar
                pop dx
                mov ax, dx
    @@printnum: mov ax, dx
                add ax, 30h
                call putchar
                loop @@nxt
                pop dx
                pop cx
                pop bx
                pop ax
                ret
                ENDP

ContHora        PROC   ;imprime las horas del reloj
                push ax
                push bx
                push cx
                push dx
                mov ax, [horas]
                mov bx, 10
                mov cx, 1
        @@nxt:  mov dx, 0
                div bx
                push dx
                cmp ax, 10
                jb @@print
                jz @@printnum
                add ax, 7
    @@print: add ax, 30h
                call putchar
                pop dx
                mov ax, dx
    @@printnum: mov ax, dx
                add ax, 30h
                call putchar
                loop @@nxt
                pop dx
                pop cx
                pop bx
                pop ax
                ret
                ENDP
END