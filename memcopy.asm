MODEL small
.STACK 100h
INCLUDE procs.inc
LOCALS
.DATA
	cadenaFuente db "123456789", 0
	cadenaDestino db 32 DUP('$')
	salto_linea db 13, 10, 0 
.CODE
Principal		PROC
				mov ax, @data
				mov ds, ax

				mov bx, offset cadenaFuente
				mov dx, offset cadenaDestino
				mov cx, 8
				call copiaMemoria

				mov ah, 04ch
				mov al, 0
				int 21h
				ENDP

copiaMemoria	PROC
				mov di, 0
				mov si, 0
@@copy:			mov al, [bx + di]
				mov cadenaDestino[si], al
				inc di
				inc si
				loop @@copy
				mov cadenaDestino[si], 0

				mov dx, offset cadenaDestino
				call puts
				ret
				ENDP
END
