; 16-bit mode 80386 CPU
cpu 386
bits 16

; bootOS services
; https://github.com/nanochess/bootOS
int_exit:        equ 0x20
int_input_char:  equ 0x21
int_output_char: equ 0x22
int_load_file:   equ 0x23
int_save_file:   equ 0x24
int_delete_file: equ 0x25

global _start
_start:

; Prints the message.
print_message:
    mov si,message
.print_one_character:
    lodsb
	test al,al
	jz .done
    int int_output_char
	jmp .print_one_character
.done:
    int int_exit

message:
    db `Hello, world!\r`, 0
