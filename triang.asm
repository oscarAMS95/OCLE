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

                mov cx, 20
				call trianNum

				mov ah, 04ch
				mov al, 0
				int 21h
				ENDP

trianNum		PROC
				mov dx, 1
@@nxt:          mov ax, dx
                push dx
                inc dx
                mul dx
                shr ax, 1
                call printDec
                mov dx, offset salto_linea
                call puts
                pop dx
                cmp dx, cx
                jl @@sum
                je @@exit
@@sum:          inc dx
                jmp @@nxt
@@exit:			mov ah, 04ch
				mov al, 0
				int 21h
                ret
				ENDP

printDec 	    PROC 
                push ax
                push dx
                push cx
                
                mov dl,10
                mov cx,0
    @@div:		inc cl
                mov ah,0
                div dl
                push ax
                cmp al,0
                jne @@div
                cmp cx,1
                je @@printCero
    @@print:	pop ax
                mov al,ah
                add al,'0'
                call putchar
                loop @@print
                jmp @@fin
    @@printCero:mov al,'0'
                call putchar
                jmp @@print
                
    @@fin:		pop cx
                pop dx
                pop ax
                ret
                ENDP
END
