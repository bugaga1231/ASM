%TITLE "Если в массиве четных элементов больше нечетных, то получить новый массив по правилу
b[i] = 2 + 4 + ... + a[i], a[i] - четное
b[i] = 0, иначе"
INCLUDE IO.ASM

ST1 SEGMENT             ;Описали сегмент стека;
	DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
	a	dw	100	dup(?)
	b	dw	100	dup(0)
	n	dw	0
	count_even	dw	0	;счетчик четных
	count_odd	dw	0	;счетчик нечетных
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
	
array_A_input:
	inint	a[bx]
	add	bx,	2
	loop	array_A_input
	
	mov	cx,	n
	mov	bx,	0
	
parity_check:
	mov	ax,	a[bx]
	test	ax,	1b
	jz	even_
	inc count_odd
	jmp	L
even_:	
	inc count_even
L:	add	bx,	2
	loop parity_check
	
	mov	ax,	count_even
	cmp	ax,	count_odd
	jng	end_
	
	mov	cx,	n
	mov	bx,	0
	
array_B_creation:
	mov	ax,	a[bx]
	test	ax,	1b
	jnz	L1
addition:	
	cmp	ax,	0
	je	L1
	add	b[bx],	ax
	sub	ax,	2
	jmp	addition
L1:	add	bx,	2
	loop	array_B_creation
	
	mov	cx,	n
	mov	bx,	0
	
array_B_output:
	outint	b[bx];
	outch	20h
	add	bx,	2
	loop	array_B_output
	
end_:	
;========== Заканчивайте писать Ваш код======================
	pop	ax
	pop	ds
mov ah, 4ch
  int 21h

start endp
CODE ENDS

END	Start
