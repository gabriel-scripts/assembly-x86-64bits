section .bss
    ; variáveis

section .data 
    ; constantes
    
    hello db "hello world", 10 
    helloLen equ $ - hello   

section .text 
    global _start
    
    _start:
        mov rax, 1
        mov rdi, 1
        mov rsi, hello
        mov rdx, helloLen
        syscall