%include "includes/asm_io.inc"
section .data
    prompt       db "Bem-vindo ao programa que executa calculadora e faz conversões!", 0
    opcoes       db "Escolha a opção que queira fazer!", 0
    opcao1       db "   1: Calculadora", 0
    opcao2       db "   2: Conversão de temperatura", 0
    opcao3       db "   3: Conversões métricas", 0
    opcao5       db "   0: Encerrar!", 0
    error_msg    db "   Opção inválida. Tente novamente.", 0
    opcao        db "   Opção............: ", 0

section .bss
    

section .text
    extern calculadora
    extern temperatura
    extern comprimento
    global _asm_main	
_asm_main:
    enter 0,0
    pusha

    mov  eax, prompt
    call print_string
    call print_nl
    
escolhas:
    mov  eax, opcoes
    call print_string
    call print_nl
    call print_nl
    mov  eax, opcao1
    call print_string
    call print_nl
    mov  eax, opcao2
    call print_string
    call print_nl
    mov  eax, opcao3
    call print_string
    call print_nl
    mov  eax, opcao4
    call print_string
    call print_nl
    mov  eax, opcao5
    call print_string
    call print_nl
    mov  eax, opcao
    call print_string
    call read_int

    jmp verifica_opcoes

verifica_opcoes:
    cmp  eax, 0
    je   exit

    cmp  eax, 1
    je   calculadora
    cmp  eax, 2
    je   temperatura
    cmp  eax, 3
    je   comprimento
    ; cmp  eax, 4
    ; je   divisao

    ; Opção inválida
    mov  eax, error_msg
    call print_string
    call print_nl

    jmp escolhas

exit:
    popa
    mov eax, 0
    leave
    ret
