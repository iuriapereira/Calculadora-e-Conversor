%include "includes/asm_io.inc"

section .data
    ; Aqui os dados inicializados s o colocados 
    prompt       db "Bem-vindo a conversão de temperatura!!", 0
    operacoes    db "Escolha a conversão que queira fazer!", 0
    operacoes1   db "   1: Celsius em Fahrenheit - ºC --> ºF", 0
    operacoes2   db "   2: Fahrenheit em Celsius - ºF --> ºC", 0
    operacoes3   db "   3: Celsius em Kelvin - ºC --> ºK", 0
    operacoes4   db "   4: Kelvin em Celsius - ºK --> ºC", 0
    operacoes5   db "   0: Voltar!", 0
    opcao        db "   Opção............: ", 0
    error_msg    db "   Operação inválida. Tente novamente.", 0
    entrada1     db "Informe os graus ºC: ", 0
    entrada2     db "Informe os graus ºF: ", 0
    entrada3     db "Informe os graus ºK: ", 0
    saida1       db "ºC = ", 0 	
    saida2       db "ºF = ", 0 	
    saida3       db "ºK = ", 0	

section .bss
    celsius	    resd 1
    fahrenheit  resd 1
    kelvin      resd 1

    celsiusSaida resd 1
    multsoma     resd 1
    farSaida     resd 1
    kelSaida     resd 1

section .text
    extern _asm_main
	global temperatura	
temperatura:
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
    mov  eax, opcao
    call print_string
    call read_int

    jmp verifica_operacao

verifica_operacao:
    cmp  eax, 0
    je   exit

    cmp  eax, 1
    je   CelsiusFahrenheit
    cmp  eax, 2
    je   FahrenheitCelsius
    cmp  eax, 3
    je   CelsiusKelvin
    cmp  eax, 4
    je   KelvinCelsius

    ; Operação inválida
    mov  eax, error_msg
    call print_string
    call print_nl

    jmp  operacao

CelsiusFahrenheit:
    ; Entrada do usuário
	mov eax, entrada1		
    call print_string		
    call read_int			
    mov [celsius], eax		
    call print_nl		
	
    ; Calculando a multiplicação e a soma
	mov	 eax, 9		
	imul eax, [celsius]		
    add  eax, 160
    mov  [multsoma], eax
    
    ; Calculando a divisão do resultado obtido anteriormente
    mov  eax, [multsoma]
    mov  ebx, 5
	idiv ebx, 	
    mov  [farSaida], eax 	
    call print_nl

    ; Saída dos resultados
        ; Aqui printa a entrada do usuário
    mov  eax, saida1		
    call print_string		
    mov  eax, [celsius]	
	call print_int			
    call print_nl

        ; Aqui printa a o resultado já convertido
	mov  eax, saida2		
    call print_string		
    mov  eax, [farSaida]  	
	call print_int			
    call print_nl

    jmp  operacao

FahrenheitCelsius:
    ; Entrada do usuário
    mov  eax, entrada2		
    call print_string		
    call read_int			
    mov  [fahrenheit], eax	
    call print_nl	

    ; Aqui faz a multiplicação por 10 porque para converter tem que fazer o calculo C=(F-32)/1,8... - Veja mais em C = (F-32)/1,8.
    mov  eax, [fahrenheit]
    sub  eax, 32
    imul eax, 10
    mov  ebx, 18
    idiv ebx
    mov  [celsiusSaida], eax

    ; Printando o resultado
        ; Printa a entrada que o usuário forneceu
    mov  eax, saida2		
    call print_string		
    mov  eax, [fahrenheit]  	
	call print_int			
    call print_nl
        ; Printa o resultado da conversão
	mov  eax, saida1		
    call print_string		
    mov  eax, [celsiusSaida] 	
	call print_int			
    call print_nl

    jmp  operacao

CelsiusKelvin:
    ; Entrada do usuário
    mov  eax, entrada1		
    call print_string		
    call read_int			
    mov  [celsius], eax	
    call print_nl	

    ; Opreação de conversão
    mov  eax, [celsius]
    add  eax, 273
    mov  [kelSaida], eax
    
    ; Imprime os resultados
        ; printa a entrada do usuário
    mov  eax, saida1		
    call print_string		
    mov  eax, [celsius]	
	call print_int			
    call print_nl
        ; printa o valor da conversão
	mov  eax, saida3		
    call print_string		
    mov  eax, [kelSaida]  	
	call print_int			
    call print_nl

    jmp  operacao

KelvinCelsius:
    ; Entrada do usuário
    mov  eax, entrada3		
    call print_string		
    call read_int			
    mov  [kelvin], eax	
    call print_nl	

    ; Operação de conversão
    mov  eax, [kelvin]
    sub  eax, 273
    mov  [celsiusSaida], eax
    
    ; Saida dos resultados
        ; Printa o valor que o usário forneceu
    mov  eax, saida3		
    call print_string		
    mov  eax, [kelvin]	
	call print_int			
    call print_nl
        ; Printa a conversão feita
	mov  eax, saida1		
    call print_string		
    mov  eax, [celsiusSaida]  	
	call print_int			
    call print_nl
     
    jmp  operacao

exit:
	popa
	mov	eax, 0
	call _asm_main ; substitui leave por call _asm_main para que ele possa retornar para o primeiro arquivo a main
	ret