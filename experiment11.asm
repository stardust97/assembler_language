assume cs:codesg 

dataseg segment 
  db "Beginner's All-purpose Symbolic Instruction Code.",0
dataseg ends

stack segment
  dw 16 dup(0)
stack ends

codeseg segment 
begin:  mov ax,dataseg
        mov ds,ax
        mov si,0
        call letterc

        mov ax,4c00h
        int 21h

letterc:
        push ax
        push si

        mov al,ds:[si]
        cmp al,0
        je end
        cmp al,97
        jna no
        cmp al 122;只有[97,122]范围内的才是小写字母
        jnb no
        sub al,32;转化为大写

no:     inc si
        jmp letterc
        
end:    pop si
        pop ax
        ret

codeseg ends
end begin




