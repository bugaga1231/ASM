%TITLE "Получить все 4значные числа, в записи которых ровно две семерки"
INCLUDE IO.ASM

ST1 SEGMENT             ;Описали сегмент стека;
	DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
	count	dw	0
	ten	dw	10
DATA ENDS


CODE SEGMENT            ;открыли сегмент кода;
ASSUME SS:ST1,DS:DATA,CS:CODE    ;связали регистровые сегменты с сегментами;

Start proc
	push	ds
	push	ax
	mov	ax, data	
	mov	ds, ax
;========== Ниже пишите Ваш код ==============================
	mov	cx,	9999
L:	mov	count,	0
	mov	ax,	cx
	mov	dx,	0
	div	ten
	cmp	dx,	7
	jne	L1
	inc	count
L1:	mov	dx,	0
	div	ten
	cmp	dx,	7
	jne	L2
	inc	count
L2:	mov	dx,	0
	div	ten
	cmp	dx,	7
	jne	L3
	inc	count
L3:	cmp	ax,	7
	jne	L4
	inc	count
L4:	cmp	count, 2
	jne	L5
	outint	cx
	outch	20h
L5:	loop L
;========== Заканчивайте писать Ваш код======================
	pop	ax
	pop	ds
mov ah, 4ch
  int 21h

start endp
CODE ENDS

END	Start
