assume cs:codesg ds:datasg ss:stack
datasg segment
  db  'welcome to masm!',0
datasg ends

stack segment
  dw 16 dup(0)
stack ends

code segment 
start:
    ;把自定义的7ch中断代码安装到0:200h处
    mov ax,cs
    mov ds,ax
    mov si,offset 7chdo
    mov ax,0
    mov es,ax
    mov di,200h
    mov cx,offset 7chdoend - offset 7chdo
    cld;传输方向为正
    rep movsb

    ;设置中断向量表
    mov ax,0
    mov es,ax
    mov es:[7ch*4],200h
    mov es:[7ch*4+2],0

    mov ax,4c00h
    int 21h


;dh=行号，dl=列号，cl=颜色，ds:si=字符串地址，字符串结束标志为0
7chdo:
    push cx;保存用到的寄存器
    push bx
    push ax
    push es
    push dx

    mov es,b800h;显存的偏移地址

    mov al,dh
    mov bl,a0h;h
    mul bl;dl*a0h得到行号，乘法结果在ax中
    mov dx,ax

    mov al,dl
    mov bl,2
    mul bl;dh*2,列号，乘法结果在ax中
    add ax,dx;得到显存地址的偏移地址

    mov bl,0
s:  mov ch,0
    mov cl,[bl]
    jcxz s1;遇到字符串结束符时退出循环
    mov bype ptr es:[ax],[bl];字符
    mov bype ptr es:1[ax],[cl];颜色
    inc bl
    jmp short s

s1: ;恢复保存的寄存器
    pop dx
    pop es
    pop ax
    pop bx
    pop cx
    iret

7chdoend:nop
    
codesg ends
end start


