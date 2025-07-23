section .bss
    buffer_1 resb 64         ; 64 bytes para o valor 1 (reserve byte)
    buffer_2 resb 64         ; 64 bytes para o valor 2 (reserve byte)
    resultado resb 64
    name resd 1              ;  reserva 1 double word (4 bytes)     

section .data 
    idade db 25                                      ; constant 1 byte (db = define byte)
    
    string_valor_1 db "First value: ", 0    ; string com terminador nulo
    string_valor_1_length equ $ - string_valor_1
    
    string_valor_2 db "Second value: ", 0  
    string_valor_2_length equ $ - string_valor_2

    a db 255                  ; define byte (1 bytes)
    b dw 1000                 ; define word (2 bytes)
    c dd 123456789            ; define double word (4 bytes)
    d dq 12345678912345678    ; define quad word (8 bytes)

section .text 
    global _start
    
    _start:
        mov rax, 1          ; syscall write
        mov rdi, 1          ; stout 
        mov rsi, string_valor_1          ; endereco da mensagem
        mov rdx, string_valor_1_length   ; tamanho da string em bytes
        syscall 

        mov rax, 0          ; syscall read
        mov rdi, 0          ; stdin
        mov rsi, buffer_1   ; salvar no buffer_1
        mov rdx, 64         ; quantidade de bytes
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, string_valor_2
        mov rdx, string_valor_2_length
        syscall

        mov rax, 0
        mov rdi, 0
        mov rsi, buffer_2
        mov rdx, 64
        syscall

        mov rax, 1          ; syscall write
        mov rdi, 1          ; stdout 
        mov rsi, buffer_1   ; endereco da mensagem
        mov rdx, 64
        syscall 

        mov rax, 1          ; syscall write
        mov rdi, 1          ; stdout 
        mov rsi, buffer_2   ; endereco da mensagem
        mov rdx, 64
        syscall 

        mov rax, 60
        xor rdi, rdi
        syscall