MODEL small
.STACK 100h
INCLUDE procs.inc

LOCALS

.DATA
    mensaje db "Hola mundo$"
.CODE
Principal       PROC
                mov ax, @data
                mov ds, ax
                call clrscr
                mov bh, 2
                mov bl, 2
                call putcharxy
                mov ah, 04ch
                mov al, 0
                int 21h
                ret
                ENDP

putcharxy       PROC
                push ax
                push bx
                push dx
                mov dh, bh
                mov dl, bl
                mov ah, 02h
                xor bh, bh
                int 10h
                mov dx, offset mensaje
                mov ah, 9
                int 21h
                pop ds
                pop dx
                pop cx
                pop bx
                pop ax
                ret
                ENDP
END