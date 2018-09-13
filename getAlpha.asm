MODEL small
.STACK 100h
INCLUDE procs.inc
LOCALS
.DATA
    cadena db 32 DUP('$')
    salto_linea db 13, 10, 0 
	contador db 0
.CODE
Principal   PROC
            mov ax, @data
            mov ds, ax
            call getAlpha
            mov ah, 04ch ;end of code
            mov al, 0
            int 21h
            ENDP

 	getAlpha 	PROC
 				mov cx, 32
 				mov si, 0
 			
@@getchs:   	call getch
 				cmp al, 13
 				je @@salir
				cmp al, 'A'
				jae @@mayorIgual
				jmp @@getchs

@@mayorIgual:	cmp al, 'Z'
				ja @@compUpper
				mov cadena[si], al
				inc si
				call putchar
				jmp @@getchs

@@compUpper:	cmp al, 'a'
				jae @@mayorUpper
				jmp @@getchs 

@@mayorUpper:	cmp al, 'z'
				ja @@getchs
				mov cadena[si], al
				inc si
				call putchar
				jmp @@getchs

	@@salir:  	mov cadena[si], 0
				mov dx, offset salto_linea
				call puts
			 
				mov dx, offset cadena
				call puts
				;mov byte ptr[bx],0
				;call puts
				;mov dx, offset cadena
				ret
			ENDP

END
