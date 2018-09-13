MODEL small
.STACK 100h
INCLUDE user.inc
INCLUDE procs.inc
LOCALS
.DATA
    cadena db 32 DUP('$') 
.CODE
Principal   PROC
            mov ax, @data
            mov ds, ax
            call gets
            mov ah, 04ch ;end of code
            mov al, 0
            int 21h
            ENDP
END
