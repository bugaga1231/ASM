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
	add	bx,	2
	add	bx,	2
	pop	cx
	loop	inputMatrix
	
	mov	dx,	n
	add	dx,	n
	mov	cx,	n
	mov	bx,	0
	mov	si,	0
		
sumAboveMain:
	add	si,	2
	push	cx
		summation:
		cmp	bx,	dx
		jge	endSummation
		cmp	a[bx][si],	0
		jl	L
		mov	ax,	a[bx][si]
		add	sum_,	ax
	L:	add	bx,	2
		loop	summation
	endSummation:
	pop	cx
	mov	bx,	dx
	add	dx,	n
	add	dx,	n
loop	sumAboveMain



outint	sum_
;========== Заканчивайте писать Ваш код======================
	pop	ax
	pop	ds
mov ah, 4ch
  int 21h

start endp
CODE ENDS

END	Start
