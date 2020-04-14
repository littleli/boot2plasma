; boot2plasma

include '80386.inc'
include '80387.inc'

use16
org 0x7C00

spd1    equ     1
spd2    equ     2
spd3    equ     3
spd4    equ     4

RED     equ     0
GREEN   equ     1
BLUE    equ     2

color1  equ     GREEN
color2  equ     BLUE

entrypoint:
	push	cs
	push	cs
	pop	ds
	pop	es
	xor 	bx, bx

; palette computation
        mov	ax, 0x3F00
        mov	di, pal
        push	di
        mov	cx, 768
        rep stosb					; in DI rests offset of waves
pal_loop:
	mov	[bx + pal + color1 +   0 * 3], al	; red ascending
        mov	[bx + pal + color1 +  64 * 3], ah	; red descending
        mov	[bx + pal + color2 + 128 * 3], al	; green ascending
        mov	[bx + pal + color2 + 192 * 3], ah	; green descending
        dec	ah
        inc	al
        add	bx, 3
        cmp	bx, 64 * 3
        jl	pal_loop

; waves computation
        mov	cx, 0x100	; array size of 0x100
        push	cx		; store same for palette
        finit			; coprocessor init
wave_loop:   
	fld	dword [konst]
        fimul	word [x]	; st0<-st0*x                 x*(pi/128)
        fsin			; st0<-sin(x*pi/128)      sin(x*pi/128)
        fstp	st1
        fld1			; st0<-1!
        fadd	st0, st1	; st0<-st0+st1          1+sin(x*pi/128)
        fimul	word [THIRTY]	; st0<-st0*30       30*(1+sin(x*pi/128))
				; st0<-result before conversion
				; and store to memory
        fistp   word [di]
        inc     di
        inc     word [x]
        loop    wave_loop

; vga init
	mov	ax, 0x13
	int	0x10		; VGA mode 320x200, 8 bits per pixel

; tweek vga mode
	cli
        mov	dx, 0x3C4	; reprogram vga to adjust size to 80x50
        mov     ax, 0x604
        out     dx, ax
        mov     ax, 0xF02
        out     dx, ax
        add     dx, 0x10	; 0x3C4 + 0x10
        mov     ax, 0x14
        out     dx, ax
        mov     ax, 0xE317
        out     dx, ax
        mov     al, 9
        out     dx, al
        inc     dx
        in      al, dx
        and     al, 0xE0
        add     al, 7
        out     dx, al
        sti

set_palette:
	pop	cx
	pop	dx
	mov	ax, 0x1012
	xor	bx, bx
	int	0x10		; use bios service call to set the palette
	
	push	word 0xA000
	pop	es		; use 386 segment register fs, useful for xlatb instruction

waitvr: mov	dx, 0x3DA
w1:	in	al, dx
	and	al, 8
	jnz	w1
w2:	in	al, dx
	and	al, 8
	jz	w2

	xor	bp, bp
        mov	ax, [pos1]
        mov	[tpos1], ax
        mov	ch, 0x32
for_y:  mov	ax, [pos3]
        mov	[tpos3], ax
        mov	cl, 0x50
for_x:  mov	si, tpos1
        mov	bx, waves
        mov	ah, 0
        mov	dl, 4
s1:     lodsb
        xlatb
        add	ah, al
        dec	dl
        jnz	s1
        mov	[es:bp], ah
        inc	bp
        inc	byte [tpos3]
        add	[tpos4], byte 3
        dec	cl
        jnz	for_x
        add	[tpos1],byte 2
        inc	byte [tpos2]
        dec	ch
        jnz	for_y

        add	[pos1],byte spd1
        sub	[pos2],byte spd2
        add	[pos3],byte spd3
        sub	[pos4],byte spd4
	jmp 	waitvr

; the end of code section

pos1:	db	0
pos2:	db	0
pos3:	db	0
pos4:	db	0

; pi = 355 ⁄ 113
konst:	dd	355.0 / 113 / 128		; pi / 128
THIRTY:	dw	30
x:	dw	0

	rb	0x7C00 + 0x200 - 2 - $
	db	0x55, 0xAA

; the end of boot sector

tpos1:	rb	1
tpos2:	rb    	1
tpos3:  rb	1
tpos4:	rb	1

pal:	rb	768
waves:	rb	256
