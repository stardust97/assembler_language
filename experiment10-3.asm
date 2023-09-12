assume cs:codesg 

data segment 
  db 10 dup(0)
data ends

stack segment
  dw 16 dup(0)
stack ends

codeseg segment 
start:
    mov ax,12666
    mov bx,data
    mov ds,bx
    mov si,0
    call dtoc

    mov dh,8
    mov dl,3
    mov cl,2
    call show_str

    mov ax,4c00h
    int 21h

dtoc:
    push dx
    push cx
    push si

    mov dx,0;无溢出除法高16位为0
    mov cx,10
    mov si,0;统计栈中的个数

s0: call divdw 
    add cx,30h
    push cx;把余数加30h后入栈
    inc si;栈中的元素个数
    cmp ax,0;商为0后停止
    jne s0

;先将元素逆序取出放到ds:[si]中
    mov cx,si
s1: mov si,0
    pop ds:[si]
    inc si
    loop s1

    pop si
    pop cx
    pop dx
    ret

;无溢出除法
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


;显示字符串
show_str:
    push cx;保存用到的寄存器
    push bx
    push ax
    push es

    mov es,b800h;显存的偏移地址

    mov al,dh
    mov bl,a0h
    mul bl;dl*a0h,行号，乘法结果在ax中
    mov bx,ax

    mov al,dl
    mov bl,2
    mul bl;dh*2,列号，乘法结果在ax中
    add ax,bx;得到显存地址的偏移地址

s:  mov cx,17;17个字符
    mov bl,0
    mov es:[ax],[bl];把颜色存到显存指定位置
    mov es:1[ax],[cl]
    add bl,2
    loop s

    ;恢复保存的寄存器
    pop es
    pop ax
    pop bx
    pop cx
    ret 

codeseg ends
end start




