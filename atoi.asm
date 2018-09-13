MODEL small
.STACK 100h
INCLUDE procs.inc
LOCALS
.DATA
	cadena db "1234", 0
    stringNum db 32 DUP('$')
	nueva_linea db 13,10,0
.CODE

Principal		PROC
                mov ax, @data
                mov ds, ax
				mov bx, offset cadena
                mov ax, 0
				call strDec2num
                
				mov ah, 04ch
				mov al, 0
				int 21h				
				ENDP

strDec2num		PROC
				mov di, 0 ;inicializando contador
                mov cx, 10 ;Constante 10
@@nxt:          mov dl, [bx + di] 
                cmp dl, '0'  ;Compara si es el caracter a 0, si es menor a 0 salta al final del procedimiento
                jb @@exit
                cmp dl, '9' ;Igualmente, si el caracter es mayor a 9 salta al final del procedimiento
                ja @@exit
                sub dl, '0'   ;Se quita 30h para obtener el valor numerico
                push dx ;guarda el valor de dx
                mul cx  ;multiplicar DX:AX = AX * 10
                pop dx  ;saca el valor de dx para sumarlo a AX
                add ax, dx  ;Sumar el numero en DX al resultado de la multiplicacion en AX
                inc di
                jmp  @@nxt
@@exit:    		ret
				ENDP

printNum		PROC  ;imprime numeros, falta mejorar esta parte. No imprime debidamente el contenido en AX
				mov cx, 10
				xor bx, bx
@@division:		xor dx, dx
				div cx
				push dx
				inc bx
				test ax, ax
				jnz @@division
				mov cx, bx
				lea si, stringNum
@@digito:		pop ax
				add al, '0'
				mov [si], al
				inc si
				loop @@digito
				mov al, 0
				mov [si], al
				mov dx, offset stringNum
				call puts
				ret
				ENDP
END