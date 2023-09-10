assume cs:codesg  ss:stack
stack segment
  dw 16 dup(0)
stack ends

codeseg segment 
start:
        mov ax,4240H		;低16位
        mov dx,000FH		;高16位
        mov cx,0AH
        call divdw

        mov ax,4c00h
        int 21h


;结果高位：Int(H/N)。
;结果低位：[rem(H/N)*65536+L]/N的商。
;结果余数：[rem(H/N)*65536+L]/N的余数。
divdw: 
        push bx ;保存用到的寄存器
        mov bx,ax;暂时保存ax内容
        mov ax,dx
        mov dx,0
        div cx ;0H/N
        push ax ;0H/N的商为最终结果的高16位

        mov ax,bx;恢复ax内容
        div cx ;rem(H/N)/N
        push ax ;rem(H/N)/N的商为最终结果的低16位
        push dx;余数位最终结果的余数
        
        pop bx
        ret
codeseg ends
end start




