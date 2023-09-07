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
  db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
stack ends

code segment
; ds和es分别指向data段和table段
    mov ax,data
    mov ds,ax
    mov ax,table
    mov es,ax

    mov bx,0 ;bx定位每个结构性数据
    mov si,0 ;si首先指向0,表示年份
    mov di,0 ;table中的数据
; 外层循环21次,共21年
    mov cx,21
s:  [bx].4 ;空格
    [bx].9 ;空格
    [bx].12 ; 空格
    [bx].15 ;空格

    mov cx,4 ;需要改成栈cx
    mov si,0
s0: mov al,es:[di]
    mov [bx].0[si],al ;;年份 4
    inc si
    inc di
    loop s0

    mov cx,4
    mov si,0
    mov di,0
s1: mov al,es:[di+年份占据的空间]
    mov bx.5[si],al;收入 4
    inc si
    inc di
    loop s1

s2: mov cx,4

    mov al,es:[di+年份+收入]
    mov bx.10.[si] ,al;雇员数量 2

    [bx].13[si四] ;人均收入 2

