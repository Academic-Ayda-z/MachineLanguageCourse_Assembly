%include "lib.h"
    global _start
    extern ExitProcess
section .data
    n db 4
    input db "test",0
    len equ 10
    buffer db 0,0
    cr equ 13
    lf equ 10
    msg db "Enter numbers :",10,0
    nums db 0 ,0
section .bss
section .code
_start:
    fgets input,len
    call putsString
    call ExitProcess
putsString:
    pusha
;    mov [input],al
    mov EAX,4 ; 4 = write
    mov EBX,1 ; 1 = std output (display)
    mov ECX,input ; pointer to char buffer
    mov EDX,len ; # bytes = len
    int 0x80
    popa
    ret
ExitProcess: 
    mov eax, 1 
    int 0x80