; file: Modelo.asm

; ------------------------------
; Como compilar o programa(Usando o programa cygwin terminal do desktop):

; São umas 5 rotinas

; Estrelas é o código a ser executado
; O menos embaixo é o comentario

; * nasm -f win32 calculadora.asm
; - arquivo: calculadora.obj é criado

; * nasm -f win32 asm_io.asm
; - arquivo: asm_io.obj é criado

; * gcc -c -o driver.obj driver.c
; - driver.c é compilado e arquivo driver.obj é criado

; * gcc -o calculadora driver.obj calculadora.obj asm_io.obj
; - os arquivos objeto são ligados / “linkados” e o executável calculadora.exe é criado

; * ./calculadora.exe
; - arquivo .exe gerado é executado 
; -----------------------------

%include "asm_io.inc"
segment .data

segment .bss


segment .text
	global _asm_main
_asm_main:
	enter 	0,0
	pusha


; Não
	popa
	mov	eax, 0
	leave
	ret