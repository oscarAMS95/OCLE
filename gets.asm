MODEL small
.STACK 100h
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

 	gets 	PROC
 			mov cx, 32
 			mov si, 0
	leer:	call getchar
			mov cadena[si], al
			inc si
			cmp al, 13
			ja leer
			jb leer
			je salir

	salir:  mov cadena[si], 0
			mov dx, offset cadena
			call puts
			ret
			ENDP
END
