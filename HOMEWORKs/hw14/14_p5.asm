%include "lib.h"
    global _start
    extern ExitProcess
section .data
    n db 4
    len equ 50
    buffer db 0,0
    cr equ 13
    lf equ 10
    error db "error",0
section .bss
    path1 resw 
    path2 resw
section .code
_start:
    fgets path1,len
    fgets path2,len
    call createDict
    call removeDict
    call ExitProcess
createDict:
    pusha
    mov EAX,39 
    mov EBX,path1
    cmp eax,0
    je next
    puts error
    next:
        int 0x80
    popa
    ret
removeDict:
    pusha
    mov EAX,40 
    mov EBX,path2
    cmp eax,0
    je next_
    puts error
    next_:
        int 0x80
    popa
    ret
ExitProcess: 
    mov eax, 1 
    int 0x80