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
section .bss
    fileP1 resw 
    fileP2 resw
    p1 resw
    p2 resw
section .code
_start:
    call concatef1f2
    call ExitProcess
concatef1f2:
    pusha
    fgets fileP1,len
    fgets fileP2,len
    readB:
        mov EAX,5 ; file open
        mov EBX,in_file_name ; pointer to input file name
        mov ECX,0 ; file access bits (0 = read only)
        mov EDX,0700 ; file permissions
        int 0x80

    openA:
        mov EAX,4 ; 4 = write
        mov EBX,0 
        mov ECX,p1 ; pointer to fp
        mov EDX,len ; # bytes = len
        int 0x80

        mov p1 , eax

        mov EAX,3 ; file read
        mov EBX,[p2] ; file descriptor
        mov ECX,buffer ; input buffer
        mov EDX,len ; size
        int 0x80

     ; write to output file
        mov EDX,EAX ; byte count
        mov EAX,4 ; file write
        mov EBX,[p1] ; file descriptor
        mov ECX,buffer ; input buffer
        int 0x80

    closeAandB:
        mov     ebx, p1           
        mov     eax, 6              ; invoke SYS_CLOSE (kernel opcode 6)
        int     80h 

        mov     ebx, p2           
        mov     eax, 6              ; invoke SYS_CLOSE (kernel opcode 6)
        int     80h 

    popa
    ret
ExitProcess: 
    mov eax, 1 
    int 0x80