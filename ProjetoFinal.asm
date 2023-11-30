%include "includes/asm_io.inc"
section .data
    prompt       db "Bem-vindo à calculadora entre dois números com operações básica em Assembly!", 0
    operacoes    db "Escolha a operação que queira fazer!", 0
    operacoes1   db "   1: Calculadora", 0
    operacoes2   db "   2: Conversão de temperatura", 0
    operacoes3   db "   3: Conversões métricas", 0
    operacoes4   db "   4: Conversões volumetricas", 0
    operacoes5   db "   0: Encerrar!", 0
    error_msg    db "   Operação inválida. Tente novamente.", 0
    opcao        db "   Opção............: ", 0

section .bss
    num1        resd 1
    num2        resd 1
    operation   resd 1
    result      resd 1

section .text
    extern calculadorac
    global _asm_main	
_asm_main:
    enter 0,0
    pusha
    
whileLoop:
    call calculadora

    cmp  eax, 0
    je   exit
exit:
    popa
    mov eax, 0
    leave
    ret
