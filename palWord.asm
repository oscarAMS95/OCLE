MODEL small
.STACK 100h
INCLUDE procs.inc
LOCALS
.DATA
	palabra db "palabra", 0
	cadena db 'palabra', '$'
	strlen dw $-cadena
	cadenarev db 20 DUP(' ')
	nueva_linea db 13,10,0
.CODE

Principal		PROC
				mov ax, @data
				mov ds, ax
				mov es, ax
				mov dx, offset palabra
				call puts
				mov dx, offset nueva_linea
				call puts
				call palindromo
				ENDP

palindromo		PROC
				mov cx, strlen
				add cx, -2

				lea si, cadena
				lea di, cadenarev

				add si, strlen
				add si, -2

@@verifica:		mov al, [si]
				mov [di], al
				dec si
				inc di
				loop @@verifica
				mov al, [si]
				mov [di], al
				inc di
				mov dl, '$'
				mov [di], dl
				mov cx, strlen

@@verpal:		lea si, cadena
				lea di, cadenarev
				repe cmpsb
				jne @@nopalindromo

@@espalindromo:	mov ah, 1
				mov al, ah
				add al, 30h
				call putchar
				jmp @@exit

@@nopalindromo:	mov ah, 0
				mov al, ah
				add al, 30h
				call putchar

@@exit:			mov ah, 04ch
				mov al, 0
				int 21h				
				ret
				ENDP
END