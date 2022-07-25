%include "lib.h"
global _start
extern ExitProcess
section .data
    strlen equ 100
    buffer db 0,0
         cr equ 13
    lf equ 10
    newln db cr,lf,0
    ;string db 0,0
	text1 db "Please enter a string:  ",10,0    
    text2 db 'sum of individual digits is :',10,0  
    txt db "   hello",10,0

section .bss
    string resb strlen
section .code
_start:
    puts text1
    fgets string , 28
    puts text2

;    a2i strlen,string
    sub ecx,ecx ;sum is in ecx
    mov ebx,string
    
    dec ebx
    findIntAndSum:
        inc ebx
        mov al, [ebx]
        cmp al , 0
        je printSum
        ;sub al, '0'
        cmp al,48;cmp with 0
        jl findIntAndSum
        cmp al,57
        jg findIntAndSum
              ;puts ecx;;;;
     
  ;      puts newln
        sub al, '0'
        movzx edx, al
        add ecx,edx

        jmp findIntAndSum
        printSum:
            ;puts newln
            i2a ecx,buffer
            puts buffer
    call ExitProcess


ExitProcess: 
    mov eax, 1 
    int 0x80