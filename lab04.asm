%TITLE "Ваш комментарий программы"
INCLUDE IO.ASM

ST1 SEGMENT             ;Описали сегмент стека;
	DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
	a	dw	10	dup(10 dup (?))
	b	dw	10	dup(0)
	n	dw	0
	sum_	dw	0	;сумма положительных над главной диагональю
	sum	dw	0	;сумма положительных элементов стобца
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
	
inputMatrix:
	push	cx
	mov	cx,	n
	mov	si,	0
	inputMatrix_elem:
		inint a[bx][si]
		add	si,	2
	loop inputMatrix_elem
	add	bx,	n
	add	bx,	n
	pop	cx
loop	inputMatrix
	
	mov	cx,	n
	mov	bx,	0

outputMatrix:
	push	cx
	mov	cx,	n
	mov	si,	0
	output_elem:
	outint	a[bx][si]
	outch	20h
	add	si,	2
	loop	output_elem
	add	bx,	n
	add	bx,	n
	pop	cx
loop	outputMatrix
	
	mov	cx,	n
	sub	cx,	1
	mov	bx,	2
		
sumAboveMain:
	push	cx
	mov	si,	0
	summation:
		mov	ax,	a[bx][si]
		cmp	ax,	0
		jl	L
		add	sum_,	ax
	L:	add	si,	2
	loop	summation
	add	bx,	n
	add	bx,	n
	add	bx,	2
	pop	cx
loop	sumAboveMain

	mov	cx,	n
	mov	bx,	0
	
create_B:
	push cx
	mov	cx,	n
	mov	si,	0
	mov	sum,	0
	summation_2:
		mov	ax,	a[bx][si]
		cmp	ax,	sum_
		jge	L1
		add	sum,ax
	L1:	add	si,	n
		add	si,	n
	loop	summation_2
	mov	ax,	sum
	mov	b[bx],	ax
	add	bx,	2
	pop	cx
loop	create_B


;========== Заканчивайте писать Ваш код======================
	pop	ax
	pop	ds
mov ah, 4ch
  int 21h

start endp
CODE ENDS

END	Start
