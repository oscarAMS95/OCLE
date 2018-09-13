MODEL small
.STACK 100h
INCLUDE procs.inc
LOCALS
.DATA
    mensaje db "Numero binario original: ",13, 10, 0
    mensaje2 db "Numero binario despues del procedimiento: ",13, 10, 0
    new_line db 13, 10, 0
.CODE
Principal       PROC
                mov ax, @data
                mov ds, ax
                mov al, 55h
                mov cx, 4
                mov dx, offset mensaje
                call puts

                call printBin

                mov dx, offset new_line
                call puts

                mov dx, offset mensaje2
                call puts

                ;call setBit
                ;call clearBit
                ;call notBit
                call getBit
                call printBin
                mov ah, 04ch
				mov al, 0
				int 21h
                ENDP

setBit          PROC
                mov dl, 1
@@nxt:          rol dl, 1
                loop @@nxt
                or al, dl
                ret
                ENDP

clearBit        PROC
                mov dl, 254
@@nxt1:         rol dl, 1
                loop @@nxt1
                and al, dl
                ret
                ENDP

notBit          PROC
                not al
                ret
                ENDP

getBit          PROC ;para obtener bit menos sig. del numero CX necesita ser 1.
@@nxt2:         rcr al, 1
                loop @@nxt2
                jc @@yes
                jnc @@no
@@yes:          mov al, 1
                jmp @@exit
@@no:           mov al, 0
                jmp @@exit
@@exit:         ret
                ENDP

printBin        PROC
                push ax
                push cx
                mov cx, 8
                mov ah, al
@@nxt2:         mov al, '0'
                shl ah, 1
                adc al, 0
                call putchar
                loop @@nxt2
                pop cx
                pop ax
                ret
                ENDP       
END