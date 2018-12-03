%TITLE "Ваш комментарий программы"
INCLUDE IO.ASM

ST1 SEGMENT             ;Описали сегмент стека;
	DB 128 DUP(?)
ST1 ENDS

info struc
	size_	dw	0
	color	dw	0
	material	dw	0
info	ends

DATA SEGMENT
	cube	info	100 dup(<,,>)
	
	volume_red	dw	0
	volume_yellow	dw	0
	volume_green	dw	0
	volume_blue	dw	0
	
	count_red	dw	0
	count_yellow	dw	0
	count_green	dw	0
	count_blue	dw	0
DATA ENDS


CODE SEGMENT            ;открыли сегмент кода;
ASSUME SS:ST1,DS:DATA,CS:CODE    ;связали регистровые сегменты с сегментами;

Start proc
	push	ds
	push	ax
	mov	ax, data	
	mov	ds, ax
;========== Ниже пишите Ваш код ==============================
	inint	n
	mov	cx,	n
	mov	bx,	0
	
struc_array_input:
	inint	cube[bx].size_
	inint	cube[bx].color
	inint	cube[bx].material
	add	bx,	type	info
	loop	struc_array_input
	
	mov	cx,	n
	mov	bx,	0
	
count_color:
	cmp	cube[bx].color, 0
	je	red
	cmp	cube[bx].color,	1
	je	yellow
	cmp cube[bx].color,	2
	je	green
	cmp	cube[bx].color,	3
	je	blue
	
red:	
	mov	ax,	1
	mul	cube[bx].size_
	mul	cube[bx].size_
	mul	cune[bx].size_
	add	volume_red,	ax
	inc	count_red
	jmp	L

yellow:
	mov	ax,	1
	mul	cube[bx].size_
	mul	cube[bx].size_
	mul	cune[bx].size_
	add	volume_yellow,	ax
	inc	count_yellow
	jmp	L
	
green:
	mov	ax,	1
	mul	cube[bx].size_
	mul	cube[bx].size_
	mul	cune[bx].size_
	add	volume_green,	ax
	inc	count_green
	jmp	L
	
blue:
	mov	ax,	1
	mul	cube[bx].size_
	mul	cube[bx].size_
	mul	cune[bx].size_
	add	volume_blue,	ax
	inc	count_blue
	jmp	L
	
L:	add bx, type	info
	loop count_color
	
;========== Заканчивайте писать Ваш код======================
	pop	ax
	pop	ds
mov ah, 4ch
  int 21h

start endp
CODE ENDS

END	Start
