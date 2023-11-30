%include "includes/asm_io.inc"
section .data
    prompt       db "Bem-vindo à calculadora entre dois números com operações básica em Assembly!", 0
    operacoes    db "Escolha a operação que queira fazer!", 0
    operacoes1   db "   1: + (Adição)", 0
    operacoes2   db "   2: - (Subtração)", 0
    operacoes3   db "   3: * (Multiplicação)", 0
    operacoes4   db "   4: / (Divisão)", 0
    operacoes5   db "   0: Voltar!", 0
    error_msg    db "   Operação inválida. Tente novamente.", 0
    result_msg   db "               Resultado: ", 0
    div0         db "   Erro: Divisão por zero.", 0 
    primNum      db "   Digite o primeiro número: ", 0
    segNum       db "   Digite o segundo número: ", 0
    opcao        db "   Opção............: ", 0

section .bss
    num1        resd 1
    num2        resd 1
    operation   resd 1
    result      resd 1

section .text
    extern _asm_main
    global calculadora	
calculadora:
    enter 0,0
    pusha
    
    mov  eax, prompt
    call print_string
    call print_nl

operacao:
    mov  eax, operacoes
    call print_string
    call print_nl
    call print_nl
    mov  eax, operacoes1
    call print_string
    call print_nl
    mov  eax, operacoes2
    call print_string
    call print_nl
    mov  eax, operacoes3
    call print_string
    call print_nl
    mov  eax, operacoes4
    call print_string
    call print_nl
    mov  eax, operacoes5
    call print_string
    call print_nl
    mov  eax, opcao
    call print_string
    call read_int
    mov  [operation], eax

    jmp verifica_operacao
    
verifica_operacao:
    cmp  eax, 0
    je   exit_calculator

    cmp  eax, 1
    je   adicao
    cmp  eax, 2
    je   subtracao
    cmp  eax, 3
    je   multiplicacao
    cmp  eax, 4
    je   divisao

    ; Operação inválida
    mov  eax, error_msg
    call print_string
    call print_nl

    jmp  operacao

adicao:
    ; Soma
    mov  eax, primNum
    call print_string
    call read_int
    mov  [num1], eax
    
    mov  eax, segNum
    call print_string
    call read_int
    mov  [num2], eax
    
    add  eax, [num1]
    mov  [result], eax

    jmp  display_result

subtracao:
    ; Subtração
    mov  eax, primNum
    call print_string
    call read_int
    mov  [num1], eax
    
    mov  eax, segNum
    call print_string
    call read_int
    mov  [num2], eax
    
    sub  eax, [num1]
    mov  [result], eax

    jmp  display_result

multiplicacao:
    ; Multiplicação
    mov  eax, primNum
    call print_string
    call read_int
    mov  [num1], eax
    
    mov  eax, segNum
    call print_string
    call read_int
    mov  [num2], eax
    
    imul eax, [num1]
    mov  [result], eax

    jmp  display_result

divisao:
    ; Divisão
    mov  eax, primNum
    call print_string
    call read_int
    mov  [num1], eax
    
    mov  eax, segNum
    call print_string
    call read_int
    mov  [num2], eax
    
    cmp  eax, 0
    je   divisao_zero_error
    
    xor  edx, edx
    mov  eax, [num1]
    mov  ebx, [num2]
    idiv ebx
    mov  [result], eax

    jmp  display_result

divisao_zero_error:
    ; Erro de divisão por zero
    mov  eax, div0
    call print_string
    call print_nl
    jmp  operacao

display_result:
    ; Exibir o resultado
    call print_nl
    mov  eax, result_msg
    call print_string
    mov  eax, [result]
    call print_int
    call print_nl
    call print_nl
    
    jmp  operacao

exit_calculator:
    popa
    mov eax, 0
    call _asm_main
    ret
    
