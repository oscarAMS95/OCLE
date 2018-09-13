MODEL small
.STACK 100h
INCLUDE procs.inc
LOCALS
.DATA
	cadena db "oscar martinez", 0
    nopangrama db "No es un pangrama.", 0
    espangrama db "Si es un pangrama.", 0
    vector db 32 DUP('$')
	nueva_linea db 13,10,0
.CODE

Principal		PROC
                mov ax, @data
                mov ds, ax
				mov dx, offset cadena
				call Pangrama
                
				mov ah, 04ch
				mov al, 0
				int 21h				
				ENDP

Pangrama		PROC
                mov bx, dx
                mov di, 0
@@caracter:     mov al, [bx+di]
                cmp al, 20h
                je @@nxt
                cmp al, 0
                je @@verif
                cmp al, 'a'
                jae @@mayorIgual
                jmp @@nxt

@@mayorIgual:   cmp al, 'z'
                ja @@nxt
                push bx
                sub al, 'a'
                mov bl, al
                xor bh, bh
                mov vector[bx], 1
                pop bx
@@nxt:          inc di
                jmp @@caracter 

@@verif:        mov cx, 26
                mov si, 0
@@car:          cmp vector[si], 1
                jne @@salir
                je @@sig
@@sig:          inc si
                loop @@car
                mov ah, 1
                mov dx, offset espangrama
                call puts
                jmp @@return
@@salir:        mov ah, 0
                mov dx, offset nopangrama
                call puts
@@return:       ret
				ENDP
END