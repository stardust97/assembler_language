assume cs:codesg ds:datasg
datasg segment
    'welcome to masm!'
datasg ends

codesg segment

start:  mov ax,0B8h
        mov es,ax

        ;绿色
        mov cx,16
copy1:  mov ax,0;
        mov es:[ax],[ax];
        mov es:2[ax], 00000010b
        add ax,4
        loop copy1

        ;绿底红色
        mov cx,16
copy2:  mov ax,0;
        mov es:[ax],[ax];
        mov es:2[ax], 00100100b
        add ax,4
        loop copy2

        ;绿底红色
        mov cx,16
copy2:  mov ax,0;
        mov es:[ax],[ax];
        mov es:2[ax], 00010111b
        add ax,4
        loop copy2


codesg ends



