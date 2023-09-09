assume cs:codesg ds:datasg ss:stack
datasg segment
db      'welcome to masm!'
db      00000010b,00100100b,00010111b
datasg ends

stack segment
db 8 dup(0)
stack ends

codesg segment
start:  mov ax,0B8h
        mov es,ax
        mov cx,3;3种颜色
				mov si,0;颜色的索引
				mov di,0;显存偏移地址
s:   		mov bx,0;字母的索引
        push cx
        mov cx,16;16个字符

	s1:   mov al,ds:[bx];字符
        mov ah,ds:16[si];颜色
        mov es:[di],ax
        inc bx
        add di,2
	loop s1

			pop cx
			inc si ;改变颜色
			loop s

codesg ends



