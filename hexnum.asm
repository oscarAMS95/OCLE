MODEL small
.STACK 100h
INCLUDE procs.inc
LOCALS
.DATA
	cadena db 32 DUP('$')
	salto_linea db 13, 10, 0 
.CODE
Principal		PROC
				mov ax, @data
				mov ds, ax

				call getHexbyte

				mov ah, 04ch
				mov al, 0
				int 21h
				ENDP

getHexbyte		PROC
				mov cx, 32
				mov si, 0
	@@leer:		call getch
				cmp al, 13
				je @@exit
				cmp al, '0'
				jae @@mayorIgual
				jmp @@leer

@@mayorIgual:	cmp al, '9'
				ja @@compUpper
				mov cadena[si], al
				inc si
				call putchar
				jmp @@leer

@@compUpper:	cmp al, 'A'
				jae @@compUpper2
				jmp @@leer

@@compUpper2:	cmp al, 'F'
				ja @@compLower
				mov cadena[si], al
				inc si
				call putchar
				jmp @@leer

@@compLower:	cmp al, 'a'
				jae @@compLower2
				jmp @@leer

@@compLower2:   cmp al, 'f'
				ja @@leer
				mov cadena[si], al
				inc si
				call putchar
				jmp @@leer

	@@exit:	 	mov si, 2
				mov cadena[si], 0
				mov dx, offset salto_linea
				call puts
			 
				mov dx, offset cadena
				call puts
				ret
				ENDP
END
