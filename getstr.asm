MODEL small
.STACK 100h
INCLUDE procs.inc
LOCALS
.DATA
    cadena db 32 DUP('$') 
.CODE
gets 	    PROC
            mov ax, @data
            mov ds, ax
 			mov cx, 32
 			mov si, 0

@@leer:	    call getchar
			mov cadena[si], al
			inc si
			cmp al, 13
			ja @@leer
			jb @@leer
			je @@salir

@@salir:    mov cadena[si], 0
			mov dx, offset cadena
			call puts
            mov ah, 04ch ;end of code
            mov al, 0
            int 21h
			ENDP
            PUBLIC gets
END
