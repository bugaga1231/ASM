%TITLE "Ваш комментарий программы"
INCLUDE IO.ASM

ST1 SEGMENT             ;Описали сегмент стека;
	DB 128 DUP(?)
ST1 ENDS

info	struc
	title_	db	20	dup	('$')
	second_name	db	20	dup('$')
	price	dw	0
	year	dw	0
info	ends

DATA SEGMENT
	n	dw	0
	book	info	100	dup(<>)
	min_price	dw	0
	s1	db	'Vvedite kolichestvo knig$'
	s2	db	'Vvedite title, second_name,price,year$'
	
	count_O	dw	0
	two	dw	2
DATA ENDS


CODE SEGMENT            ;открыли сегмент кода;
ASSUME SS:ST1,DS:DATA,CS:CODE,ES:DATA    ;связали регистровые сегменты с сегментами;

Start proc
	push	ds
	push	ax
	mov	ax, data	
	mov	ds, ax
	mov	es,	ax
;========== Ниже пишите Ваш код ==============================
	mov	ah,	9h
	lea	dx,	s1
	int	21h
	outch	20h
	inint	n
	mov	cx,	n
	mov	bp,	0
	
enter_book:
	mov	ah,	9h
	lea	dx,	s2
	int	21h
	outch 20h
	push	cx
	mov	ah,	3fh
	mov	cx,	20
	mov	bx,	0
	lea	dx,	book[bp].title_
	int	21h
	mov	ah,	3fh
	mov	cx,	20
	mov	bx,	0
	lea	dx,	book[bp].second_name
	int	21h
	inint	book[bp].price
	inint	book[bp].year
	pop	cx
	add	bp,	type	info
loop enter_book
	
	mov	cx,	n
	dec	cx
	mov	bp,	0
	mov	ax,	book[bp].price
	mov	min_price,	ax
findMin_price:
	add	bp,	type	info
	mov	ax,	book[bp].price
	cmp	min_price,	ax
	jl	L
	mov	min_price,	ax
L:	loop	findMin_price
	
	outint	min_price
	mov	ax,	min_price
	mul	two
	mov	min_price,	ax
	
	mov	cx,	n
	mov	bx,	0
find_author:
	push	cx
	mov	count_O,	0
	lea	di,	book[bx].title_
	mov	cx,	20
	mov	al,	'o'
L3:	repne	scasb
	je	L1
	inc	count_O
	jmp	L3
L1:	cmp	count_O,	2
	jg	L2
	mov	ax,	book[bx].price
	cmp	ax,	min_price
	jle	L2
	mov	ah,	9h
	lea	dx,	book[bx].second_name
	int	21h
	outch	20h
L2:	pop	cx	
	add	bx,	type	info
loop	find_author
;========== Заканчивайте писать Ваш код======================
	pop	ax
	pop	ds
mov ah, 4ch
  int 21h

start endp
CODE ENDS

END	Start
