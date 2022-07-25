%include "lib.h"
global _start
extern ExitProcess
section .data
    n db 0
    space db " ",0
    len equ 4
    buffer db 0,0
         cr equ 13
    lf equ 10
   newln db cr,lf,0
    msg db "Enter numbers :",10,0
    msg_r db "Enter number of Row:",10,0
    msg_c db "Enter number of Column:",10,0
    msg_f db "transport is:",10,0
    nums db 0 ,0
    row db 0,0
    column  db 0,0
    m1 times 100 db 0
    m2 times 100 db 0
    counter db 0


section .bss
section .code
_start:
    sub ebx , ebx
    sub ecx ,ecx
    puts msg_r
    fgets row,len
    puts msg_c
    fgets column,len
    a2i len,column
    mov ebx,eax
    a2i len,row
    mul ebx
    mov ecx,eax
    puts msg
read_matrix_row:
;    enter 4,0
    sub edx,edx
    xor esi,esi
    push ecx ;n*m
    get_nums:
        fgets nums,len
        a2i len,nums                
        mov [m1+esi],eax
        add esi ,4
        loop get_nums
    
    pop ecx
puts msg_f
print:
;    enter 0,0 
    xor esi,esi
    sub eax,eax
    sub edx,edx
    add_m:
        mov edx,[m1+esi]
        i2a edx,buffer
        puts buffer
        puts space
        add esi ,4
;        inc esi
    loop add_m

ExitProcess: 
    mov eax, 1 
    int 0x80