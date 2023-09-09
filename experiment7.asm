assume cs:codesg
data segment
  db '1975' '1976' '1977' '1978' '1979' '1980' '1981' '1982' '1983' 
  db '1984' '1985' '1986' '1987' '1988' '1989' '1990' '1991' '1992' 
  db '1993' '1994' '1995'

  dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
  dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000

  dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
  dw 11542,14430,15257,17800
data ends

table segment
  db 21 dup('year summ ne ?? ')
table ends

; stack用于保存内外层循环的cx
stack segment
  dw 8 dup(0)
stack ends

code segment
; ds和es分别指向data段和table段
start:
    mov ax,data
    mov ds,ax
    mov ax,table
    mov es,ax

    mov bx,0 ;bx定位每个结构性数据
    mov si,0 
; 外层循环21次,共21年
    mov cx,21
;年份 4字节
s0: mov ax,ds:0[bx]
    mov es:0[si],ax
    mov ax,ds:2[bx]
    mov es:2[si],ax
    add bx,4
    add si,10h
    loop s0

;空格部分占一个字节 //TODO
    mov cx,21
s1: mov es::[bx].4 20h ;空格
    mov es:[bx].9,20h;空格
    mov es:[bx].12,20h ;空格
    mov es:[bx].15,20h ;空格

;收入占4字节
    mov cx,21
    mov bx,84;年份有21*4=84字节
    mov si,5
s2: mov ax,ds:0[bx]
    mov es:0[si],ax
    mov ax,ds:2[bx]
    mov es:2[si],ax
    add bx,4
    inc si,10h
    loop s2

;雇员数占两字节
s3: mov cx,21
    mov bx,168;年份84+21*4=168
    mov si,0ah;雇员从第10个字节开始
    mov ax,ds:0[bx]
    mov es:0[si],ax
    add bx,2
    add si,10h
    loop s3

;计算人均收入
s4: mov cx,21
    mov si,0
;被除数32位，除数16位 被除数高位放在DX，低位放在AX
;结果 商放在AX 余数放在DX
    mov ax,es:5[si]
    mov dx,es:7[si]
    div word ptr es:0ah[si]
    mov es:0dh[si],ax
    add si,10h
    loop s4

    mov ax,4c00h
    int 32h
code ends

end start



