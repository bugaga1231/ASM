%TITLE "Дано N и целые неотрицательные a1, a2, ... , aN.
Найти произведение элементов, у которых количество цифр не больше последней цифры 1 элемента"
INCLUDE IO.ASM

ST1 SEGMENT             ;Описали сегмент стека;
	DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
	a	dw	0
	b	dw	0
	n	dw	0
	proiz	dw	1
	ten	dw	10
	count	dw	0
DATA ENDS


CODE SEGMENT            ;открыли сегмент кода;
ASSUME SS:ST1,DS:DATA,CS:CODE    ;связали регистровые сегменты с сегментами;

KOLVO	proc
	mov	count,	0
L1:	mov	dx,	0
	div	ten
	inc	count
	cmp	ax,	0
	jne	L1
	ret
KOLVO	endp

Start proc
	push	ds
	push	ax
	mov	ax, data	
	mov	ds, ax
;========== Ниже пишите Ваш код ==============================
	inint	n
	mov	cx,	n
	sub	cx,	1
	inint	ax
	mov	dx,	0
	div	ten
	mov	b,	dx
L:	inint	ax
	mov	a,	ax
	call	KOLVO
	mov	dx,	b
	mov	ax,	a
	cmp	dx,	count
	jl	L2
	mul	proiz
	mov	proiz,	ax
L2:	loop L
	outint	proiz
;========== Заканчивайте писать Ваш код======================
	pop	ax
	pop	ds
mov ah, 4ch
  int 21h

start endp
CODE ENDS

END	Start
