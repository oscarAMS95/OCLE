MODEL small
    .STACK 100h
    INCLUDE procs.inc
        LOCALS
        CR EQU 13 ;Carriage return
        LF EQU 10 ;New line feed, new line 
        
    .DATA
        mens db 'A es mayor que B', CR, LF, 0
        mens2 db 'Fin de programa',CR, LF, 0
    .CODE
    
    Principal   PROC
                mov ax, @data
                mov ds, ax
                mov ax, 15
                mov bx, 8
                cmp ax, bx
                ja @@then
                mov dx, offset mens2
                jmp @@showMessage
    @@then:     call clrscr
                mov dx, offset mens
                jmp @@showMessage
@@showMessage:  call puts
                mov ah, 04ch
                mov al, 0
                int 21h
        ENDP
END