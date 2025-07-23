; in Assembly inputs is a memory location with a ASCII number, so we need to convert to a real value to make operations

; MOVING DATA: 

; mov (copy bit a bit)
; movzx (fild high bits with 0)
; movsx (fild high bits wuth sign)

; SYSCALL REGISTERS]:

; mov al,  [mem8]    ; 8 bits em AL
; mov ax,  [mem16]   ; 16 bits em AX
; mov eax, [mem16]   ; 32 bits em EAX
; mov rax, [mem64]   ; 64 bits em RAX

; "VARIABLE" REGISTERS

; RAX / EAX	Acumulador (resultados de operações)	64 / 32 bits
; RBX / EBX	Base (endereços de dados)	64 / 32 bits
; RCX / ECX	Contador (loops, repetições)	64 / 32 bits
; RDX / EDX	Dados (multiplicações, I/O)	64 / 32 bits

; itoa = interger to ANCII
; atoi = ANCII to interger

; add numbers: 0-9

section .bss
  buffer resb 2
  buffer_2 resb 2
  result resb 2

section .data 
    string_valor_1 db "First value: ", 0  
    string_valor_1_length equ $ - string_valor_1
    
    string_valor_2 db "Second value: ", 0  
    string_valor_2_length equ $ - string_valor_2

section .text
  global _start

_start:
  mov rax, 1
  mov rdi, 1
  mov rsi, string_valor_1
  mov rdx, string_valor_1_length
  syscall

  mov rax, 0       
  mov rdi, 0       
  mov rsi, buffer   
  mov rdx, 2
  syscall

  mov rax, 1
  mov rdi, 1
  mov rsi, string_valor_2
  mov rdx, string_valor_2_length
  syscall

  mov rax, 0
  mov rdi, 0 
  mov rsi, buffer_2
  mov rdx, 2  
  syscall

  call atoi_and_add
  call itoa_result

  mov rax, 1
  mov rdi, 1
  mov rsi, result
  mov rdx, 2
  syscall

  call quit 


; FUNCTIONS ON ASSEMBLY IS CALLED ROUTINES

atoi_and_add:
  ; Convert ASCII to numeric value

  movzx eax, byte [buffer]  ; byte ASCII para EAX, zera bits altos
  sub eax, '0'              ; '0' (48) → 0, '1' (49) → 1
  
  movzx ebx, byte [buffer_2]
  sub ebx, '0' 

  ; Make the adition on two numbers
  add eax, ebx
  ret

itoa_result:
  add   eax, '0'                  ; 0 → '0', 1 → '1', …
  mov   [result], al              ; armazena o caractere
  mov   byte [result+1], 10       ; newline (LF)
  ret

quit:
  mov rax, 60
  xor rdi, rdi
  syscall