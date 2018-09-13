MODEL small
.STACK 100h
INCLUDE procs.inc
LOCALS
.DATA
    mens_base db "El valor en AX en la base seleccionada:", 0
    nueva_linea db 13, 10, 0
.CODE
Principal   PROC
            mov ax, @data ;Inicializar DS a la direccion
            mov ds, ax    ;del segmento de datos(.DATA)
            call clrscr

            mov ax, 32
            mov bx, 10
            mov dx, offset mens_base
            call puts
            call printNumBase

            mov dx, offset nueva_linea
            call puts

            mov ah, 04ch ;fin de programa
            mov al, 0
            int 21h
            ret
            ENDP

printNumBase  PROC
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
END
