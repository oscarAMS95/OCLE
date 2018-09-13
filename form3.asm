MODEL small
.STACK 100h
INCLUDE procs.inc

LOCALS

.DATA
    mens_directo db 13, 10, "Desplegado de caracter en forma directa: ", 0
    mens_DOS db 13, 10, "Desplegado de caracter usando DOS: ", 0
    mens_BIOS db 13, 10, "Desplegado de caracter usando BIOS: ", 0
    mensaje db 13, 10, "Hola", 0
    new_line db 13, 10, 0
.CODE
Principal       PROC
                mov ax, @data
                mov ds, ax
                mov es, ax
                call clrscr
                
                mov dx, offset mens_BIOS
                call puts

                mov dx, offset new_line
                call puts

                mov bp, offset mensaje
                call puts
                mov ah, 13h
                mov al, 01h
                xor bh, bh
                mov bl, 2
                mov cx, 6
                mov dh, 2
                mov dl, 0
                int 10h

                mov ax, 4c00h
                int 21h
                ENDP

putcharxy       PROC
                push ax
                push bx
                push cx
                push dx
                push ds

                mov dx, ax

                mov ax, 0b800h
                mov ds, ax

                mov cl, 160
                mov al, bl
                mul cl
                mov bl, bh
                mov bh, 0
                shl bx, 1
                add bx, ax

                mov [bx], dl

                pop ds
                pop dx
                pop cx
                pop bx
                pop ax
                ret
                ENDP
END