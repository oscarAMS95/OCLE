MODEL small
.STACK 100h
INCLUDE procs.inc

LOCALS

.DATA
    mens_directo db 13, 10, "Desplegado de caracter en forma directa: ", 0
    mens_DOS db 13, 10, "Desplegado de caracter usando DOS: ", 0
    mens_BIOS db 13, 10, "Desplegado de caracter usando BIOS: ", 0
    new_line db 13, 10, 0
.CODE
Principal       PROC
                mov ax, @data
                mov ds, ax
                call clrscr
                
                mov dx, offset mens_directo
                call puts
                mov al, 'x'
                mov bh, 41
                mov bl, 0
                call putcharxy

                mov dx, offset mens_DOS
                call puts
                mov dl, 'x'
                mov ah, 2
                int 21h
                
                mov dx, offset mens_BIOS
                call puts
                mov al, 'x'
                mov ah, 0ah
                mov bx, 0
                mov cx, 1
                int 10h

                mov dx, offset new_line
                call puts

                mov ah, 04ch
                mov al, 0
                int 21h
                ret
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