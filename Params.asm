MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
		CR EQU 13
		LF EQU 10
 
       LOCALS

   .DATA
      cnt_params       db  'Cantidad de parametros: ',0
      rcb_params       db  CR,LF,'Parametros recibidos: ',0
	  salto_linea 	   db 13, 10, 0 
	  compara dw 0
	  constante dw 10

   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS a la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				
				call printParams

				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 

                ENDP
				
printParams 	PROC
				push ds
				push ax
				push bx
				push cx
				push dx
				
				mov ah, 62h
				int 21h            ; el servicio 62h de la interrupción 21h retorna en BX el inicio del PSP
	
				;mov dx, offset cnt_params
				;call puts
				push ds
				mov ds, bx         ; vamos a usar a DS para direccionar a PSP 
				mov si, 80h        ; en la direccion DS:80h se encuentra la cantidad de parametros recibidos
				xor ah, ah
				mov al, [si]
				;call printDec
				pop ds
				cmp al, 0
				je @@fin				
				mov dx, offset salto_linea
				call puts

				mov ds, bx
				mov cx, ax
				mov si, 82h

;@@printParam:   inc si            ; a partir de la direccion DS:81h se encuentran los parametros
				;mov al, [si]
                ;mov cx, 10 ;Constante 10
@@nxt:          mov dl, [si] 
                cmp dl, '0'  ;Compara si es el caracter a 0, si es menor a 0 salta al final del procedimiento
                jb @@fin
                cmp dl, '9' ;Igualmente, si el caracter es mayor a 9 salta al final del procedimiento
                ja @@fin
                sub dl, '0'   ;Se quita 30h para obtener el valor numerico
                push dx ;guarda el valor de dx
                mul [constante]  ;multiplicar DX:AX = AX * 10
                pop dx  ;saca el valor de dx para sumarlo a AX
                add ax, dx  ;Sumar el numero en DX al resultado de la multiplicacion en AX
                inc si
				loop @@nxt
@@fin:			mov [compara], ax
				call trianNum
				
				pop dx
				pop cx
				pop bx
				pop ax
				pop ds				
				ret
				ENDP

trianNum		PROC
				push ax
				push dx
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
                cmp dx, [compara]
                jl @@sum
                je @@exit
@@sum:          inc dx
                jmp @@nxt
@@exit:			
				pop ax
				pop dx
				;mov ah, 04ch
				;mov al, 0
				;int 21h

                ret
				ENDP

printDec 		PROC 
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
				
				
; incluir procedimientos	
; ejemplo:
; funcionX PROC ; < -- Indica a TASM el inicio del un procedimiento
;               ; 
;               ; < --- contenido del procedimiento
;           ret
;           ENDP; < -- Indica a TASM el fin del procedimiento



         END
