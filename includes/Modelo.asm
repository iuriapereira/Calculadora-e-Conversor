; file: Modelo.asm

; ------------------------------
; Como compilar o programa(Usando o programa cygwin terminal do desktop):

; S�o umas 5 rotinas

; Estrelas � o c�digo a ser executado
; O menos embaixo � o comentario

; * nasm -f win32 calculadora.asm
; - arquivo: calculadora.obj � criado

; * nasm -f win32 asm_io.asm
; - arquivo: asm_io.obj � criado

; * gcc -c -o driver.obj driver.c
; - driver.c � compilado e arquivo driver.obj � criado

; * gcc -o calculadora driver.obj calculadora.obj asm_io.obj
; - os arquivos objeto s�o ligados / �linkados� e o execut�vel calculadora.exe � criado

; * ./calculadora.exe
; - arquivo .exe gerado � executado 
; -----------------------------

%include "asm_io.inc"
segment .data

segment .bss


segment .text
	global _asm_main
_asm_main:
	enter 	0,0
	pusha


; N�o
	popa
	mov	eax, 0
	leave
	ret