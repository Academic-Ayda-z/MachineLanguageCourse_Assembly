%include "lib.h"
 global _start

section .data
    hex_table db "0123456789ABCDEF"
    ; translation table: 4-bit binary to hex
	len equ 10
	input db 0,0
	binary dd 0
	msg1 db "please Enter the number = ",0
	exponent db "  Exponent = ",0
	mantissa db 10,"  Mantissa =   1.",0
	out_one db " 1",0
	out_zero db " 0",0
	cou dd 0
	signz db "  Sign = 0",10,0
	sign1 db "  Sign = 1",10,0


	section .code
_start:
	puts msg1
	fgets input,len

	loop:
		mov ecx, [cou]
		cmp ecx, 7
		jz show1
		mov EAX, input
		mov ecx, [cou]
		mov al, [eax + ecx]
		inc ecx
		mov [cou], ecx
		cmp al, '0'
		jz zero
		cmp al, '1'
		jnz next2

		mov ebx, [binary];
		add ebx, 1;
		shl ebx, 4;
		mov [binary],ebx;
		
		jmp loop;
	next2:
		cmp al, '2'
		jnz next3
		mov ebx, [binary];
		add ebx, 2;
		shl ebx, 4;
		mov [binary],ebx;
		jmp loop;
	next3:
		cmp al, '3'
		jnz next4
		mov ebx, [binary];
		add ebx, 3;
		shl ebx, 4;
		mov [binary],ebx;
		jmp loop;

	next4:
		cmp al, '4'
		jnz next5
		mov ebx, [binary];
		add ebx, 4;
		shl ebx, 4;
		mov [binary],ebx;
		jmp loop;
	next5:
		cmp al, '5'
		jnz next6
		mov ebx, [binary];
		add ebx, 5;
		shl ebx, 4;
		mov [binary],ebx;
		jmp loop;
	next6:
		cmp al, '6'
		jnz next7
		mov ebx, [binary];
		add ebx, 6;
		shl ebx, 4;
		mov [binary],ebx;
		jmp loop;
	next7:
		cmp al, '7'
		jnz next8
		mov ebx, [binary];
		add ebx, 7;
		shl ebx, 4;
		mov [binary],ebx;
		jmp loop;

	next8:
		cmp al, '8'
		jnz next9
		mov ebx, [binary];
		add ebx, 8;
		shl ebx, 4;
		mov [binary],ebx;
		jmp loop;

	next9:
		cmp al, '9'
		jnz next10
		mov ebx, [binary];
		add ebx, 9;
		shl ebx, 4;
		mov [binary],ebx;
		jmp loop;
	next10:
		cmp al, 'A'
		jnz next11
		mov ebx, [binary];
		add ebx, 10;
		shl ebx, 4;
		mov [binary],ebx;
		jmp loop;
	next11:
		cmp al, 'B'
		jnz next12
		mov ebx, [binary];
		add ebx, 11
		shl ebx, 4
		mov [binary],ebx
		jmp loop
	next12:
		cmp al, 'C'
		jnz next13
		mov ebx, [binary]
		add ebx, 12
		shl ebx, 4
		mov [binary],ebx;
		jmp loop;
	next13:
		cmp al, 'D'
		jnz next14;
		mov ebx, [binary]
		add ebx, 13
		shl ebx, 4
		mov [binary],ebx
		jmp loop
		
	next14:
		cmp al, 'E';
		jnz next15;
		mov ebx, [binary]
		add ebx, 14
		shl ebx, 4
		mov [binary],ebx
		jmp loop
	next15:
		cmp al, 'F';
		jz last;
	last:
		mov ebx, [binary]
		add ebx, 15
		shl ebx, 4
		mov [binary],ebx
		jmp loop
	show1:
		mov eax, [binary];
		shl eax, 1;
		jnc signzero;
		puts sign1;
	show2:
		puts exponent
		mov ebx, [binary]
		shr ebx,23
		sub ebx, 127
		shl ebx, 24;
		sub edx, edx;

	part2:
		cmp edx , 8;
		jz res3;
		inc edx;
		shl ebx, 1;
		jnc print1;
		jc print2;

	res3:
		puts mantissa;
		mov ebx, [binary]
		shl ebx, 9
		sub edx, edx

	part3:
		cmp edx, 23
		jz exit
		inc edx
		shl ebx, 1
		jnc out3
		jc out4
	print1:
		puts out_zero;
		jmp part2;
	print2:
		puts out_one;
		jmp part2;
	out3:
		puts out_zero;
		jmp part3;
	out4:
		puts out_one;
		jmp part3;
	zero:
		mov ebx, [binary];
		add ebx, 0;
		shl ebx, 4;
		mov [binary],ebx;
		jmp loop;
			signzero:
			puts signz
			jmp show2
exit:
	mov eax,1
	mov ebx,0
	int 0x80
