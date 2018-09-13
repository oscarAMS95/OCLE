MODEL small
.STACK 100h
INCLUDE procs.inc
LOCALS
.DATA
    mens_ascii db "AL desplegado en ASCII:",0
    mens_bin db "AL desplegado en Binario:",0
    mens_dec db "AL desplegado en Decimal:",0
    mens_hex db "AL desplegado en Hexadecimal:",0
    new_line db 13,10,0
.CODE
Principal   PROC
            mov ax, @data
            mov ds, ax
            call clrscr

            mov ax, 80
            mov dx, offset mens_ascii
            call puts
            call putchar

            mov dx, offset new_line
            call puts

            mov dx, offset mens_bin
            call puts
            call printBin

            mov dx, offset new_line
            call puts

            mov dx, offset mens_dec
            call puts
            call printDec

            mov dx, offset new_line
            call puts

            mov dx, offset mens_hex
            call puts
            call printHex

            mov ah, 04ch
            mov al, 0
            int 21h
            ret
            ENDP

printBin    PROC
            push ax
            push cx
            mov cx, 8
            mov ah, al
    @@nxt:  mov al, '0'
            shl ah, 1
            adc al, 0
            call putchar
            loop @@nxt
            pop cx
            pop ax
            ret
            ENDP

printDec    PROC
            push ax
            push bx
            push cx
            push dx
            mov cx, 3
            mov bx, 100
            mov ah, 0
    @@nxt:  mov dx, 0
            div bx
            add al, '0'
            call putchar
            mov ax, dx
            push ax
            mov dx, 0
            mov ax, bx
            mov bx, 10
            div bx
            mov bx, ax
            pop ax
            loop @@nxt
            pop dx
            pop cx
            pop bx
            pop ax
            ret
            ENDP

printHex    PROC
            push ax
            push bx
            push cx
            mov ah, 0
            mov bl, 16
            div bl
            mov cx, 2
    @@nxt:  cmp al, 10
            jb @@print
            add al, 7
    @@print:add al, 30h
            call putchar
            mov al, ah
            loop @@nxt
            pop cx
            pop bx
            pop ax
            ret
            ENDP
END
