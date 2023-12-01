%include "includes/asm_io.inc"

section .data
    ; Aqui os dados inicializados s o colocados 
    prompt       db "Bem-vindo a conversão dos comprimentos!!", 0
    operacoes    db "Escolha a conversão que queira fazer!", 0
    operacoes1   db "   1: Metro em Quilômetro      - m   --> km", 0
    operacoes2   db "   2: Quilômetro em Metro      - km  --> m",  0
    operacoes3   db "   3: Metro em Centimetro      - m   --> cm", 0
    operacoes4   db "   4: Centimetro em Metro      - cm  --> m",  0
    operacoes5   db "   5: Centimetro em Quilômetro - cm  --> km", 0
    operacoes6   db "   6: Quilômetro em Centimetro - km  --> cm", 0
    voltar       db "   0: Voltar!", 0
    opcao        db "   Opção............: ", 0
    error_msg    db "   Operação inválida. Tente novamente.", 0
    entradaMetro db "Informe o valor do metro: ",      0
    entradaQuilo db "Informe o valor do quilometro: ", 0
    entradaCenti db "Informe o valor do centimetro: ", 0
    saidaMetro   db "m   = ", 0 	
    saidaQuilom  db "km  = ", 0 	
    saidaCenti   db "cm  = ", 0	

section .bss
    m       resd 1
    km	    resd 1
    hm      resd 1
    dam     resd 1
    dm      resd 1
    cm      resd 1
    mm      resd 1

section .text
    extern _asm_main
	global comprimento
comprimento:
	enter 	0,0
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
    mov  eax, operacoes6
    call print_string
    call print_nl
    mov  eax, voltar
    call print_string
    call print_nl
    mov  eax, opcao
    call print_string
    call read_int

    jmp verifica_operacao

verifica_operacao:
    cmp  eax, 0
    je   exit

    cmp  eax, 1
    je   MetroQuilometro
    cmp  eax, 2
    je   QuilometroMetro
    cmp  eax, 3
    je   MetroCentimetro
    cmp  eax, 4
    je   CentimetroMetro
    cmp  eax, 5
    je   CentimetroQuilometro
    cmp  eax, 6
    je   QuilometroCentimetro

    ; Operação inválida
    mov  eax, error_msg
    call print_string
    call print_nl

    jmp  operacao

MetroQuilometro:
    ; Entrada do usuário 
	mov  eax, entradaMetro		
    call print_string		
    call read_int			
    mov  [m], eax		
    call print_nl		
	
    ; Calculando a conversão
	mov	 eax, [m]	
	mov  ebx, 1000
    idiv ebx		
    mov  [km], eax

    ; Printa as saidas dos resultados
        ; Aqui printa o que o valor que o usuário inseriu em m
    mov  eax, saidaMetro		
    call print_string		
    mov  eax, [m]	
	call print_int			
    call print_nl
        ; Aqui printa o resultado da conversão que foi salvo em km
	mov  eax, saidaQuilom		
    call print_string		
    mov  eax, [km]  	
	call print_int			
    call print_nl

    ; Retorna para operacao
    jmp  operacao

QuilometroMetro:
    ; Entrada do usuário
    mov  eax, entradaQuilo		
    call print_string		
    call read_int			
    mov  [km], eax		
    call print_nl		
	
    ; Calculando a conversão
	mov	 eax, [km]	
    imul eax, 1000
    mov  [m], eax
			
    mov  [hm], eax

    ; Saída dos resultados
        ; Aqui printa a entrada do usuário
    mov  eax, saidaQuilom		
    call print_string		
    mov  eax, [km]	
	call print_int			
    call print_nl
	
        ; Aqui printa a o resultado já convertido
	mov  eax, saidaMetro		
    call print_string		
    mov  eax, [m]  	
	call print_int			
    call print_nl

    ; Retorna para operacao
    jmp  operacao

MetroCentimetro:
    ; Entrada do usuário
    mov  eax, entradaMetro		
    call print_string		
    call read_int			
    mov  [m], eax		
    call print_nl		
	
    ; Calculando a conversão
	mov	 eax, [m]	
    imul eax, 100		
    mov  [cm], eax
    ; Saída dos resultados
        ; Aqui printa a entrada do usuário
    mov  eax, saidaMetro		
    call print_string		
    mov  eax, [m]	
	call print_int			
    call print_nl
        ; Aqui printa a o resultado já convertido
	mov  eax, saidaCenti		
    call print_string		
    mov  eax, [cm]  	
	call print_int			
    call print_nl

    ; Retorna para operacao
    jmp  operacao

CentimetroMetro:
    ; Entrada do usuário
    mov  eax, entradaCenti		
    call print_string		
    call read_int			
    mov  [cm], eax		
    call print_nl		
	
    ; Calculando a conversão
	mov	 eax, [cm]	
    mov  ebx, 100
    idiv ebx		
    mov  [m], eax

    ; Saída dos resultados
        ; Aqui printa a entrada do usuário
    mov  eax, saidaCenti		
    call print_string		
    mov  eax, [cm]	
	call print_int			
    call print_nl

        ; Aqui printa a o resultado já convertido
	mov  eax, saidaMetro		
    call print_string		
    mov  eax, [m]  	
	call print_int			
    call print_nl

    ; Retorna para operacao
    jmp  operacao

CentimetroQuilometro:
    ; Entrada do usuário
    mov  eax, entradaCenti		
    call print_string		
    call read_int			
    mov  [cm], eax		
    call print_nl		
	
    ; Calculando a conversão
	mov	 eax, [cm]	
    mov  ebx, 100000
    idiv ebx		
    mov  [km], eax
    
    ; Saída dos resultados
        ; Aqui printa a entrada do usuário
    mov  eax, saidaCenti		
    call print_string		
    mov  eax, [cm]	
	call print_int			
    call print_nl
        ; Aqui printa a o resultado já convertido
	mov  eax, saidaQuilom		
    call print_string		
    mov  eax, [km]  	
	call print_int			
    call print_nl

    ; Retorna para operacao
    jmp  operacao

QuilometroCentimetro:
    ; Entrada do usuário
    mov  eax, entradaQuilo		
    call print_string		
    call read_int			
    mov  [km], eax		
    call print_nl		
	
    ; Calculando a conversão
	mov	 eax, [km]	
    imul eax, 100000
    mov  [m], eax

    ; Saída dos resultados
        ; Aqui printa a entrada do usuário
    mov  eax, saidaQuilom		
    call print_string		
    mov  eax, [km]	
	call print_int			
    call print_nl
    
        ; Aqui printa a o resultado já convertido
	mov  eax, saidaCenti		
    call print_string		
    mov  eax, [cm]  	
	call print_int			
    call print_nl

    ; Retorna para operacao
    jmp  operacao
    
exit:
	popa
	mov	eax, 0
	call _asm_main ; substitui leave por call _asm_main para que ele possa retornar para o primeiro arquivo a main
	ret