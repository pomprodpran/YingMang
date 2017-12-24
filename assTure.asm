		.model tiny

		.data


	Sstart  db  'START$',0
	Slevel	db  'LEVEL$',0
	Seasy	db 	'EASY$',0
	Smedium db 	'MEDIUM$',0
	Shard 	db 	'HARD$',0
	Sexit	db 	'EXIT$',0
	Slife   db  'LIFE$',0
	Sgameover db 'GAMEOVER$',0
	Measy   dw  4e20h
	Mmedium dw  2710h
	Mhard   dw  1388h
	mode	dw	?
	mode2 dw ?

	posi1   db  11
	posi2	db 	11
	cursor 	db 	1

	logo1   db      "_____.___.___ _______    ________     _____      _____    _______    ________  ",0
	        db      "\__  |   |   |\      \  /  _____/    /     \    /  _  \   \      \  /  _____/  ",0
	        db      " /   |   |   |/   |   \/   \  ___   /  \ /  \  /  /_\  \  /   |   \/   \  ___  ",0
	        db      " \____   |   /    |    \    \_\  \ /    Y    \/    |    \/    |    \    \_\  \ ",0
	        db      " / ______|___\____|__  /\______  / \____|__  /\____|__  /\____|__  /\______  / ",0
	        db      " \/                  \/        \/          \/         \/         \/        \/ $",0


	char	db	33
	col		db	0,79,31,45,66,21,11,9,23,77,48,42,12,65,27,32,43,6
			db	49,58,55,4,2,41,52,36,1,3,29,86,35,84,46,87,81,30,7
			db	68,16,61,63,38,51,78,26,19,67,39,54,17,70,5,71,57,59
			db	53,28,83,34,33,13,8,44,64,10,22,85,37,56,74,20,40,50,18
			db	14,15,60,47,24,62 	; Random column to print
	row		db	80 dup(-12) 	; Start print @ row=-12
	rain	db	0               ; Indicate ordinal number of rain -- ex. rain=0 mean 1st rain
	count	db	0				; Number of rain that is  falling
	clr		db	-1              ; Count color char that is printed

	shoot   db  40
	rowA    db  0
	i       dw 0
	rowClear db 0
	life    db 9
	check   db 0

SomeTune        dw 3834, 100	;D#
;dw  10,1
dw  3416, 100	;F
;dw  10,1
dw  3224, 100	;F#
;dw  10,1
dw  2873, 100	;G#
;dw  10,1

dw  3416, 100	;F
;dw  10,1
dw  3224, 100	;F#
;dw  10,1
dw  2873, 100	;G#
;dw  10,1
dw  2559, 100	;A#
;dw  10,1

dw  3224, 100	;F#
;dw  10,1
dw  2873, 100	;G#
;dw  10,1
dw  2559, 100	;A#
;dw  10,1
dw  2152, 100	;C#
;dw  10,1

dw  2873, 100	;G#
;dw  10,1
dw  2559, 100	;A#
;dw  10,1
dw  2152, 100	;C#
;dw  10,1
dw  1917, 100	;D#
;dw  10,1

dw  2559, 100	;A#
;dw  10,1
dw  2152, 100	;C#
;dw  10,1
dw  1917, 100	;D#
;dw  10,2
dw  1715, 100	;F
dw  10,5

dw  1917, 25	;D#
;dw  10,1
dw  1715, 800	;F
dw  00h,00h

SomeTune2 dw  10,1
dw 3619, 100	;E
;dw  10,1
dw  3834, 100	;D#
;dw  10,1
dw  4063, 100	;D
;dw  10,1
dw  4304, 100	;C#
dw  10,5

dw  3043, 100	;G
;dw  10,1
dw  3224, 100	;F#
;dw  10,1
dw  3416, 100	;F
;dw  10,1
dw  3619, 100	;E
dw  10,5

dw  2559, 100	;A#
;dw  10,1
dw  2711, 100	;A
;dw  10,1
dw  2873, 100	;G#
;dw  10,1
dw  3043, 100	;G
dw  10,5


dw  2152, 125	;C#
dw  10,250
dw  4304, 800	;C#



dw  00h,00h



		.code
		org 0100h

main:		mov ah, 00h 	; Set to 80x25
			mov al, 03h
			int 10h

			mov 	ax,100h             	;hide cursor
			sub 	bx,bx
			mov 	cx,2000h
			mov 	dx,bx
			int 	10h


			mov si, 0 ;***
			mov di, 0 ;***


;-----------------------------SET FRAME1-------------------------------

			; mov ah, 02h				;set cursor position
			; mov bh, 00h
			; mov dh, 5				;column
			; mov dl, 25				;row
			; int 10h

			; mov ah, 09h				;set colour
			; mov al, ' '
			; mov bh, 00h
			; mov bl, 14h				;yellow
			; mov cx, 100h
			; int 10h

			; mov ah, 09h				;write string
			; mov dx, offset logo
			; int 21h
			mov     bh, 00h             ;set cursor
			mov     ah, 02h
			mov     dh, 3 ;y
			mov     dl, 1 ;x
			int     10h

			mov     ah, 09h             ;set colour for message
			mov     al, ' '
			mov     bh, 00h
			mov     bl, 07h
			mov     cx, 200h
			int     10h

			mov     ah, 09h             ;print for logo
			mov     dx, offset logo1
			int     21h


			mov ah, 02h				;set cursor position
			mov bh, 00h
			mov dh, 11				;column
			mov dl, 35				;row
			int 10h

			mov ah, 09h				;set colour
			mov al, ' '
			mov bh, 00h
			mov bl, 07h				;white
			mov cx, 100h
			int 10h

			mov ah, 09h				;write string
			mov dx, offset Sstart
			int 21h

;----------------------------------------------------------------------
			mov ah, 02h				;set cursor position
			mov bh, 00h
			mov dh, 13				;column
			mov dl, 35				;row
			int 10h

			mov ah, 09h				;set colour
			mov al, ' '
			mov bh, 00h
			mov bl, 07h				;white
			mov cx, 100h
			int 10h

			mov ah, 09h				;write string
			mov dx, offset Sexit
			int 21h
;----------------------------------------------------------------------





;;;;;;;;;;;;;;;;SET CURSOR TO SELECT;;;;;;;;;;;;;;;
start1:


			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, posi1			;column
			mov 	dl, 34				;row
			int 	10h

			mov     ah, 09h   			;set colour
			mov     al, '>'
			mov     bh, 00h
			mov     bl, 0Ah
			mov     cx, 01h
			int     10h

			mov 	ah,00h				;keyboard
			int 	16h

			cmp 	ax,4800h			;moveup keyboard
			je 		moveup1
			cmp 	ax,5000h 			;movedown keyboard
			je 		jmpmovedown1
			cmp 	al,13
			je 		jmpexit1
			cmp 	ax,011Bh
			je		jmpendd
			jmp 	clear1
;;;;;;;;;;;;;;;;;;; JUMP ZONE;;;;;;;;;;;;;;;;;;
jmpexit1:
			jmp 	exit1
jmpmovedown1:
			jmp 	movedown1
jmpendd:
			jmp 	endd

moveup1: 	cmp  	posi1,11
			je      moveupp1

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, posi1			;column
			mov 	dl, 34				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, '>'
			mov 	bh, 00h
			mov 	bl, 00h				;black
			mov 	cx, 001h
			int 	10h

			sub 	posi1,2

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, posi1			;column
			mov 	dl, 34				;row
			int 	10h

			mov     ah, 09h   			;set colour
			mov     al, '>'
			mov     bh, 00h
			mov     bl, 0Ah
			mov     cx, 01h
			int     10h

			jmp 	start1

moveupp1:   mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, posi1			;column
			mov 	dl, 34				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, '>'
			mov 	bh, 00h
			mov 	bl, 00h				;black
			mov 	cx, 001h
			int 	10h

			add 	posi1,2

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, posi1			;column
			mov 	dl, 34				;row
			int 	10h

			mov     ah, 09h   			;set colour
			mov     al, '>'
			mov     bh, 00h
			mov     bl, 0Ah
			mov     cx, 01h
			int     10h

			jmp     start1



movedown1:
			cmp 	posi1,13
			je 		movedownn1

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, posi1			;column
			mov 	dl, 34				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, '>'
			mov 	bh, 00h
			mov 	bl, 00h				;black
			mov 	cx, 001h
			int 	10h

			add 	posi1,2

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, posi1			;column
			mov 	dl, 34				;row
			int 	10h

			mov     ah, 09h   			;set colour
			mov     al, '>'
			mov     bh, 00h
			mov     bl, 0Ah
			mov     cx, 01h
			int     10h

			jmp 	start1

movedownn1:
			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, posi1			;column
			mov 	dl, 34				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, '>'
			mov 	bh, 00h
			mov 	bl, 00h				;black
			mov 	cx, 001h
			int 	10h

			sub 	posi1,2

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, posi1			;column
			mov 	dl, 34				;row
			int 	10h

			mov     ah, 09h   			;set colour
			mov     al, '>'
			mov     bh, 00h
			mov     bl, 0Ah
			mov     cx, 01h
			int     10h

			jmp     start1






clear1:
			mov     ah, 0ch
			mov     al, 0
			int     21h             ; Clear Keyboard Buffer for prevent Keyboard ghosting

			jmp 	start1






exit1:



			cmp 	posi1,11
			je    startgame1
			cmp   posi1,13
			je    jmptotoendd

;;;;;;jmp zone;;;;;;;;
jmptotoendd:
			jmp 	endd

;;;;;;;;;;;;;;;;;;;;;;;;
startgame1:


			mov 	ah, 00h 			; Set to 80x25
			mov 	al, 03h
			int 	10h

			mov 	ax,100h             	;hide cursor
			sub 	bx,bx
			mov 	cx,2000h
			mov 	dx,bx
			int 	10h

			; mov 	ax,100h             	;hide cursor
			; sub 	bx,bx
			; mov 	cx,2020h
			; mov 	dx,bx
			; int 	10h

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 10				;column
			mov 	dl, 35				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, ' '
			mov 	bh, 00h
			mov 	bl, 07h				;white
			mov 	cx, 100h
			int 	10h

			mov 	ah, 09h				;write string
			mov 	dx, offset Slevel
			int 	21h

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 11				;column
			mov 	dl, 36				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, ' '
			mov 	bh, 00h
			mov 	bl, 07h				;white
			mov 	cx, 100h
			int 	10h

			mov 	ah, 09h				;write string
			mov 	dx, offset Seasy
			int 	21h

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 12				;column
			mov 	dl, 36				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, ' '
			mov 	bh, 00h
			mov 	bl, 07h				;white
			mov 	cx, 100h
			int 	10h

			mov 	ah, 09h				;write string
			mov 	dx, offset Smedium
			int 	21h

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 13				;column
			mov 	dl, 36				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, ' '
			mov 	bh, 00h
			mov 	bl, 07h				;white
			mov 	cx, 100h
			int 	10h

			mov 	ah, 09h				;write string
			mov 	dx, offset Shard
			int 	21h


start2:

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, posi2			;column
			mov 	dl, 34				;row
			int 	10h

			mov     ah, 09h   			;set colour
			mov     al, '>'
			mov     bh, 00h
			mov     bl, 0Ah
			mov     cx, 01h
			int     10h

			mov 	ah,00h				;keyboard
			int 	16h

			cmp 	ax,4800h			;moveup keyboard
			je 		moveup2
			cmp 	ax,5000h 			;movedown keyboard
			je 		jmpmovedown2
			cmp 	al,13
			je 		jmpstartgame2
			cmp 	ax,011Bh
			je		jmptoendd
			jmp 	clear2

;;;;;;;;;;;;;;;;;;; JUMP ZONE;;;;;;;;;;;;;;;;;;
jmptoendd:
			jmp		endd
jmpstartgame2:
			jmp 	startgame2
jmpmovedown2:
			jmp 	movedown2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

moveup2: 	cmp  	posi2,11
			je      moveupp2

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, posi2			;column
			mov 	dl, 34				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, '>'
			mov 	bh, 00h
			mov 	bl, 00h				;black
			mov 	cx, 001h
			int 	10h

			dec 	posi2

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, posi2			;column
			mov 	dl, 34				;row
			int 	10h

			mov     ah, 09h   			;set colour
			mov     al, '>'
			mov     bh, 00h
			mov     bl, 0Ah
			mov     cx, 01h
			int     10h

			jmp 	start2

moveupp2:
			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, posi2			;column
			mov 	dl, 34				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, '>'
			mov 	bh, 00h
			mov 	bl, 00h				;black
			mov 	cx, 001h
			int 	10h

			add 	posi2,2

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, posi2			;column
			mov 	dl, 34				;row
			int 	10h

			mov     ah, 09h   			;set colour
			mov     al, '>'
			mov     bh, 00h
			mov     bl, 0Ah
			mov     cx, 01h
			int     10h

			jmp     start2







movedown2:
			cmp 	posi2,13
			je 		movedownn2

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, posi2			;column
			mov 	dl, 34				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, '>'
			mov 	bh, 00h
			mov 	bl, 00h				;black
			mov 	cx, 001h
			int 	10h

			inc 	posi2

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, posi2			;column
			mov 	dl, 34				;row
			int 	10h

			mov     ah, 09h   			;set colour
			mov     al, '>'
			mov     bh, 00h
			mov     bl, 0Ah
			mov     cx, 01h
			int     10h

			jmp 	start2

movedownn2:
			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, posi2			;column
			mov 	dl, 34				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, '>'
			mov 	bh, 00h
			mov 	bl, 00h				;black
			mov 	cx, 001h
			int 	10h

			sub 	posi2,2

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, posi2			;column
			mov 	dl, 34				;row
			int 	10h

			mov     ah, 09h   			;set colour
			mov     al, '>'
			mov     bh, 00h
			mov     bl, 0Ah
			mov     cx, 01h
			int     10h

			jmp     start2

clear2:
			mov     ah, 0ch
			mov     al, 0
			int     21h             	; Clear Keyboard Buffer for prevent Keyboard ghosting

			jmp 	start2

startgame2:
			cmp 	posi2,11
			je		easyMode
			cmp 	posi2,12
			je 		mediumMode
			cmp 	posi2,13
			je  	hardMode

easyMode:   mov 	ax,Measy
			mov 	mode,ax
			mov 	mode2,16h
			jmp 	startgame3

mediumMode: mov 	ax,Mmedium
			mov 	mode,ax
			mov 	mode2,0004h
			jmp 	startgame3

hardMode:   mov     ax,Mhard
			mov     mode,ax
			mov 	mode2,0001h
			jmp 	startgame3

;---------------------- THE MATRIX RAIN --------------------------


startgame3:
push ds
push si
push ax
push dx
push cx
pop  es
mov  si, offset SomeTune

mov  dx,61h                  ; turn speaker on
in   al,dx                   ;
or   al,03h                  ;
out  dx,al                   ;
mov  dx,43h                  ; get the timer ready
mov  al,0B6h                 ;
out  dx,al                   ;

LoopIt: lodsw                        ; load desired freq.
or   ax,ax                   ; if freq. = ;0 then done
jz   short LDone             ;
mov  dx,42h                  ; port to out
out  dx,al                   ; out low order
xchg ah,al                   ;
out  dx,al                   ; out high order


lodsw                        ; get duration
mov  cx,ax                   ; put it in cx (16 = 1 second)
call PauseIt                 ; pause it
jmp  short LoopIt

LDone:  mov  dx,61h                  ; turn speaker off
in   al,dx                   ;
and  al,0FCh                 ;
out  dx,al
jmp  asd                  ;

PauseIt proc near uses ax cx es
mov  ax,0040h
mov  es,ax

; wait for it to change the first time
mov  al,es:[006Ch]
@a:     cmp  al,es:[006Ch]
je   short @a

; wait for it to change again
loop_it:mov  al,es:[006Ch]
@b:     cmp  al,es:[006Ch]
je   short @b

sub  cx,55
jns  short loop_it

ret
PauseIt endp

asd:
			pop si
			pop dx
			pop ax
			pop cx

			mov 	ah, 00h 				; Set to 80x25
			mov 	al, 03h
			int 	10h

			mov 	ax,100h             	;hide cursor
			sub 	bx,bx
			mov 	cx,2000h
			mov 	dx,bx
			int 	10h



bestart3:

; delayy:

			; mov		cx,  00h			;Set delay time
			; mov		dx,  1000
			; mov		ah,  86h
			; int		15h
			; inc     check
			; cmp 	check,15
			; je		jmpblack


			; mov 	ah, 02h				;set cursor position
			; mov 	bh, 00h
			; mov 	dh, 24				;column
			; mov 	dl, 0				;row
			; int 	10h

			; mov 	ah, 09h				;write string
			; mov 	dx, offset Slife
			; int 	21h

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 24			;column
			mov 	dl, 0				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, 'L'
			mov 	bh, 00h
			mov 	bl, 07h				;black
			mov 	cx, 001h
			int 	10h

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 24			;column
			mov 	dl, 1				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, 'I'
			mov 	bh, 00h
			mov 	bl, 07h				;black
			mov 	cx, 001h
			int 	10h

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 24			;column
			mov 	dl, 2				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, 'F'
			mov 	bh, 00h
			mov 	bl, 07h				;black
			mov 	cx, 001h
			int 	10h

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 24			;column
			mov 	dl, 3				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, 'E'
			mov 	bh, 00h
			mov 	bl, 07h				;black
			mov 	cx, 001h
			int 	10h

			mov     bh, 00h             ;set cursor
			mov     ah, 02h
			mov     dh, 3 ;y
			mov     dl, 1 ;x
			int     10h

			mov     ah, 09h             ;set colour for message
			mov     al, ' '
			mov     bh, 00h
			mov     bl, 07h
			mov     cx, 200h
			int     10h

			push si
			mov si,0
			mov row[si],0
			pop si
;---
start3:
			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 24				;column
			mov 	dl, 6				;row
			int 	10h

			add 	life,30h
			mov     ah, 09h   			;set colour
			mov     al, life
			mov     bh, 00h
			mov     bl, 07h
			mov     cx, 01h
			int     10h
			sub     life,30h

			mov 	rowA,21

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 22				;column
			mov 	dl, shoot			;row
			int 	10h

			mov     ah, 09h   			;set colour
			mov     al, 'A'
			mov     bh, 00h
			mov     bl, 04h
			mov     cx, 01h
			int     10h

			mov 	ah,02h				;hide cursor
			mov 	bh,00h
			mov		dh,-1
			mov 	dl,-1
			int 10h





buffer:			mov 	ah,01h				;buffer
			int 	16h
			jz 		jmpdelayy


			mov 	ah,00h				;keyboard
			int 	16h


			cmp 	ax,4B00h			;moveleft keyboard
			je 		moveleft
			cmp 	ax,4D00h 			;moveright keyboard
			je 		jmpmoveright
			cmp 	ax,4800h
			je    beep
			cmp 	ax,011Bh
			je		jmptotheendd
			jmp 	black

beep:
			push ax
			push dx
			push cx
			push bx
			mov     al, 182         ; Prepare the speaker for the
					out     43h, al         ;  note.
					mov     ax, 1140		; Frequency number (in decimal)
									;  for middle C.
					out     42h, al         ; Output low byte.
					mov     al, ah          ; Output high byte.
					out     42h, al
					in      al, 61h         ; Turn on note (get value from
																	;  port 61h).
					or      al, 00000011b   ; Set bits 1 and 0.
					out     61h, al         ; Send new value.
					mov     bx, 1 ; Pause for duration of note.


		.ppause1:
					mov     cx, 65535


		.ppause2:
					dec     cx
					jne     .ppause2
					dec     bx
					jne     .ppause1
					in      al, 61h         ; Turn off note (get value from
																	;  port 61h).
					and     al, 11111100b   ; Reset bits 1 and 0.
					out     61h, al         ; Send new value.
			pop ax
			pop dx
			pop cx
			pop bx
			jmp jmpshootloop

;;;;;;;;;;;;;;;;;;; JUMP ZONE;;;;;;;;;;;;;;;;;;
jmpdelayy:
			jmp     delayy
jmpstartgame3:
			jmp 	startgame3
jmpmoveright:
			jmp 	moveright
jmpblack:
			jmp    	black
jmpshootloop:
			jmp 	shootloop
jmptotheendd:
			jmp		endd


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

moveleft: 	cmp  	shoot,0
			je      moveleftt

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 22				;column
			mov 	dl, shoot			;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, 'A'
			mov 	bh, 00h
			mov 	bl, 00h				;black
			mov 	cx, 001h
			int 	10h

			dec 	shoot

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 22				;column
			mov 	dl, shoot			;row
			int 	10h

			mov     ah, 09h   			;set colour
			mov     al, 'A'
			mov     bh, 00h
			mov     bl, 0Ch
			mov     cx, 01h
			int     10h

			jmp 	start3

moveleftt:
			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 22				;column
			mov 	dl, shoot			;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, 'A'
			mov 	bh, 00h
			mov 	bl, 00h				;black
			mov 	cx, 001h
			int 	10h

			add 	shoot,79

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 22				;column
			mov 	dl, shoot			;row
			int 	10h

			mov     ah, 09h   			;set colour
			mov     al, 'A'
			mov     bh, 00h
			mov     bl, 0Ch
			mov     cx, 01h
			int     10h

			jmp     start3

moveright:
			cmp 	shoot,79
			je 		moverightt

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 22				;column
			mov 	dl, shoot			;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, 'A'
			mov 	bh, 00h
			mov 	bl, 00h				;black
			mov 	cx, 001h
			int 	10h

			inc 	shoot

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 22				;column
			mov 	dl, shoot			;row
			int 	10h

			mov     ah, 09h   			;set colour
			mov     al, 'A'
			mov     bh, 00h
			mov     bl, 0Ch
			mov     cx, 01h
			int     10h

			jmp 	start3



moverightt:
			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 22				;column
			mov 	dl, shoot			;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, 'A'
			mov 	bh, 00h
			mov 	bl, 00h				;black
			mov 	cx, 001h
			int 	10h

			sub 	shoot,79

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 22				;column
			mov 	dl, shoot			;row
			int 	10h

			mov     ah, 09h   			;set colour
			mov     al, 'A'
			mov     bh, 00h
			mov     bl, 0Ch
			mov     cx, 01h
			int     10h
;;;;;;;;;;;;;;;;;;; SHOOT ;;;;;;;;;;;;;;;;;;;;
jmpstart3:  jmp 	start3
shootloop:
			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, rowA			;column
			mov 	dl, shoot			;row
			int 	10h

			mov     ah, 09h   			;set colour
			mov     al, '+'
			mov     bh, 00h
			mov     bl, 07h
			mov     cx, 01h
			int     10h


			mov		cx,  00h			;Set delay time
			mov		dx,  1000
			mov		ah,  86h
			int		15h

			cmp 	rowA,-1
			je 		jmpstart3



compare:	mov 	di,i
			mov 	ah,shoot
			cmp 	col[di],ah
			je      compareloop

			inc     i
			jmp		compare

compareloop:
			mov 	row[di],-12
			mov 	i,0

			mov 	ah, 09h				;set colour
			mov 	al, '+'
			mov 	bh, 00h
			mov 	bl, 00h				;black
			mov 	cx, 001h
			int 	10h

			dec		rowA
			jmp 	shootloop

delayy:

			mov		cx,  00h			;Set delay time
			mov		dx,  mode
			mov		ah,  86h
			int		15h
			inc     check
			cmp 	check,15
			jle		jmpbuffer
			jmp		black

jmpbuffer:
			jmp		buffer


; black2:
			; mov	si,0

black:		mov check,0
			mov ah, 02h 	; Move cursor XY
			mov dh, row[si] ; Row
			mov dl, col[si] ; Column
			int 10h

			cmp char, 127
			jb pblack
			mov char, 33

pblack:		mov ah, 09h 	; Write a colored char
			mov al, char
			mov bh, 00
			mov bl, 00h 	; Black Color
			mov cx, 1	; Print 1 time
			int 10h

			inc row[si] 	; Next Row
			inc clr

grey:		mov ah, 02h 	; Move cursor XY
			mov dh, row[si] ; Row
			mov dl, col[si] ; Column
			int 10h

			inc char 	; Random Char
			cmp char, 127
			jb pgrey
			mov char, 33

pgrey:		mov ah, 09h 	; Write a colored char
			mov al, char
			mov bh, 00
			mov bl, 08h 	; Green Color
			mov cx, 1
			int 10h

			inc row[si] 	; Next Row
			inc clr         ; Start count color char

green:		mov ah, 02h 	; Move cursor XY
			mov dh, row[si] ; Row
			mov dl, col[si] ; Column
			int 10h

			inc char 	; Random Char
			cmp char, 127
			jb  pgreen
			mov char, 33

pgreen:		mov ah, 09h 	; Write a colored char
			mov al, char
			mov bh, 00
			mov bl, 02h 	; Green Color
			mov cx, 1
			int 10h

			inc row[si] 	; Next Row
			inc clr
			cmp clr, 6 	; Print more Green Char
			jb green

greenl:		mov ah, 02h 	; Move cursor XY
			mov dh, row[si] ; Row
			mov dl, col[si] ; Column
			int 10h

			inc char 	; Random Char
			cmp char, 127
			jb pgreenl
			mov char, 33

pgreenl:	mov ah, 09h 	; Write a colored char
			mov al, char
			mov bh, 00
			mov bl, 0Ah 	; Light Green Color
			mov cx , 1
			int 10h

			inc row[si] 	; Next Row
			inc clr
			cmp clr, 8 	; Print Greenlight Char twice
			jb greenl

white:		mov ah, 02h 	; Move cursor XY
			mov dh, row[si] ; Row
			mov dl, col[si] ; Column
			int 10h

			inc char 	; Random Char
			cmp char, 127
			jb  pwhite
			mov char, 33

pwhite:		mov ah, 09h 	; Write a colored char
			mov al, char
			mov bh, 00
			mov bl, 0Fh 	; White Color
			mov cx, 1
			int 10h

			inc row[si] 	; Next Row
			inc clr
			cmp clr, 10 	; Print White Char twice
			jb white

;;;;;;;;;;;;;;;;print ordinal number of rain 01 012 0123 01234.... 0...79 ;;;;;;;;;;

printOrder:	mov ah, clr      ; Can't -- sub row[si], color --directy ,Must sub through register ah
			sub row[si], ah    ; Skip tail down 1 row
			mov clr, -1
			inc rain


checkTail:	cmp row[si], 12    ; Check for print new rain  if tail row=25
			jne l1		   ; Jump if tail row = 25
			mov row[si], -12   ; Reset start row(tail row) =-12 /head row=-1
			dec life
			cmp life,0
			je  endframe


clear :		mov ah, 02h 	; Move cursor XY
			mov bh,00h
			mov dh, rowClear ; Row
			mov dl, col[si] ; Column
			int 10h

			mov ah, 09h 	; Write a colored char
			mov al, char
			mov bh, 00
			mov bl, 00h 	; White Color
			mov cx, 1
			int 10h

			inc rowClear
			cmp rowClear,21
			jle	clear
			mov rowClear,0


l1:			cmp rain, 79 	   ; Check for new random and print
			je l1_1

			mov ah, rain 	   ; Can't cmp between rain & count directly ,Must cmp through register ah
			cmp ah, count
			ja reset	   ; Jump if rain > count

			inc si		   ; Do next rain
		    jmp start3

reset:		inc count
			mov si, 0
			mov rain, 0

			call DELAY

			jmp start3

l1_1:		mov si, 0
			mov rain, 0

			call DELAY

			jmp start3

endframe:
			mov 	ah, 00h 			; Set to 80x25
			mov 	al, 03h
			int 	10h

			mov 	ax,100h             ;hide cursor
			sub 	bx,bx
			mov 	cx,2000h
			mov 	dx,bx
			int 	10h


						push ds
						push si
						push ax
						push dx
						push cx
						pop  es
						mov  si, offset SomeTune2

						mov  dx,61h                  ; turn speaker on
						in   al,dx                   ;
						or   al,03h                  ;
						out  dx,al                   ;
						mov  dx,43h                  ; get the timer ready
						mov  al,0B6h                 ;
						out  dx,al                   ;

						LoopIt2: lodsw                        ; load desired freq.
						or   ax,ax                   ; if freq. = ;0 then done
						jz   short LDone2             ;
						mov  dx,42h                  ; port to out
						out  dx,al                   ; out low order
						xchg ah,al                   ;
						out  dx,al                   ; out high order


						lodsw                        ; get duration
						mov  cx,ax                   ; put it in cx (16 = 1 second)
						call PauseIt                 ; pause it
						jmp  short LoopIt2

						LDone2:  mov  dx,61h                  ; turn speaker off
						in   al,dx                   ;
						and  al,0FCh                 ;
						out  dx,al
						jmp  ad                 ;

						PauseIt2 proc near uses ax cx es
						mov  ax,0040h
						mov  es,ax

						; wait for it to change the first time
						mov  al,es:[006Ch]
						@a2:     cmp  al,es:[006Ch]
						je   short @a2

						; wait for it to change again
						loop_it2:mov  al,es:[006Ch]
						@b2:     cmp  al,es:[006Ch]
						je   short @b2

						sub  cx,55
						jns  short loop_it2

						ret
						PauseIt2 endp

			; mov 	ah, 02h				;set cursor position
			; mov 	bh, 00h
			; mov 	dh, 10				;column
			; mov 	dl, 35				;row
			; int 	10h

			; mov 	ah, 09h				;set colour
			; mov 	al, ' '
			; mov 	bh, 00h
			; mov 	bl, 07h				;white
			; mov 	cx, 100h
			; int 	10h

			; mov 	ah, 09h				;write string
			; mov 	dx, offset Sgameover
			; int 	21h
ad:
			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 10			;column
			mov 	dl, 35				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, 'G'
			mov 	bh, 00h
			mov 	bl, 07h				;black
			mov 	cx, 001h
			int 	10h

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 10			;column
			mov 	dl, 36				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, 'A'
			mov 	bh, 00h
			mov 	bl, 07h				;black
			mov 	cx, 001h
			int 	10h

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 10			;column
			mov 	dl, 37				;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, 'M'
			mov 	bh, 00h
			mov 	bl, 07h				;black
			mov 	cx, 001h
			int 	10h

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 10			;column
			mov 	dl, 38			;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, 'E'
			mov 	bh, 00h
			mov 	bl, 07h				;black
			mov 	cx, 001h
			int 	10h

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 10			;column
			mov 	dl, 39			;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, 'O'
			mov 	bh, 00h
			mov 	bl, 07h				;black
			mov 	cx, 001h
			int 	10h

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 10			;column
			mov 	dl, 40			;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, 'V'
			mov 	bh, 00h
			mov 	bl, 07h				;black
			mov 	cx, 001h
			int 	10h

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 10			;column
			mov 	dl, 41			;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, 'E'
			mov 	bh, 00h
			mov 	bl, 07h				;black
			mov 	cx, 001h
			int 	10h

			mov 	ah, 02h				;set cursor position
			mov 	bh, 00h
			mov 	dh, 10			;column
			mov 	dl, 42			;row
			int 	10h

			mov 	ah, 09h				;set colour
			mov 	al, 'R'
			mov 	bh, 00h
			mov 	bl, 07h				;black
			mov 	cx, 001h
			int 	10h

			mov 	ah,01h				;buffer
			int 	16h
			jnz 	endd

			mov 	ah,00h				;keyboard
			int 	16h

			cmp 	ax,1c0dh			;enter keyboard
			je 		endd
			jmp 	endframe


endd:		mov 	ah, 00h 				; Set to 80x25
			mov 	al, 03h
			int 	10h
			jmp 	enddd

DELAY:		;mov	cx, mode2 ;00h				;Set delay time
		;	mov	dx,  mode
		;	mov	ah,  86h
			;int	15h
			ret

enddd:
mov ax, 0003h           ;Clear screen back
int 10h


			ret

			end main
