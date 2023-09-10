assume cs:codesg ds:datasg ss:stack
datasg segment
  db  'welcome to masm!',0
datasg ends

stack segment
  dw 16 dup(0)
stack ends

code segment 
start:
	mov dh,8
	mov dl,3
	mov cl,2
	mov ax,data
	mov ds,ax
	mov si,0
	call show_str

	mov ax,4c00h
	int 21h

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
    
codesg ends
end start


