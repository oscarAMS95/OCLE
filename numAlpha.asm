MODEL small
.STACK 100h
INCLUDE procs.inc
LOCALS
.DATA
    cadena db 32 DUP('$')
    salto_linea db 13, 10, 0 
.CODE
Principal   PROC
            mov ax, @data
            mov ds, ax
            call getNum
            mov ah, 04ch ;end of code
            mov al, 0
            int 21h
            ENDP

 	getNum	PROC
 			mov cx, 32
 			mov si, 0
 			
@@getchs:   call getch
 			cmp al, 13
 			je salir
			cmp al, '0'
			jae mayorIgual
			jmp @@getchs

mayorIgual: cmp al, '9'
			ja @@getchs
			mov cadena[si], al
			inc si
			call putchar
			jmp @@getchs

	salir:  mov cadena[si], 0
			;mov byte ptr[bx],0
			;call puts
			mov dx, offset salto_linea
			call puts
			 
			mov dx, offset cadena
			call puts
			ret
			ENDP

END
