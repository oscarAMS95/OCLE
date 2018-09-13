MODEL small
.STACK 100h
INCLUDE procs.inc
LOCALS
.DATA
	cadena db 32 DUP('$')
	nueva_linea db 13,10,0
.CODE

Principal		PROC
				mov ax, 10234
				call printNumInverse
				
				mov ah, 04ch
				mov al, 0
				int 21h				
				ret
				ENDP

printNum		PROC  ;imprime numeros
				mov cx, 10
				xor bx, bx
@@division:		xor dx, dx
				div cx
				push dx
				inc bx
				test ax, ax
				jnz @@division
				mov cx, bx
				lea si, cadena
@@digito:		pop ax
				add al, '0'
				mov [si], al
				inc si
				loop @@digito
				mov al, 0
				mov [si], al
				mov dx, offset cadena
				call puts
				ret
				ENDP


printNumInverse PROC  ;imprime reversa de los numeros de registro AX
				mov bx, 10
				push ax
				push dx
	@@nxt:  	mov dx, 0
				div bx
				push ax
				mov ax, dx
				cmp ax, 10
				jb @@print
				add ax, 7
	@@print:    add ax, 30h
				call putchar
				pop ax
				cmp ax, 0
				jnz @@nxt
				pop dx
				pop ax
				ret
				ENDP
END