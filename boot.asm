[org 0x7c00]          ; BIOS loads our boot sector at this memory address

start:
    ; Clear the screen and reset to standard 80x25 text mode
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    mov ah, 0x0e      ; BIOS scrolling teletype function
    mov bx, os_text   ; Point BX to the start of our string data

print_loop:
    mov al, [bx]      ; Load the character at the address in BX
    cmp al, 0         ; Check if it's the null terminator (end of string)
    je done           ; If it is 0, we are done printing
    int 0x10          ; Print the character to the screen
    inc bx            ; Move to the next character in the string
    jmp print_loop    ; Loop back to print the next character

done:
    jmp $             ; Loop forever

os_text:
    ; 8 empty lines to push the art to the vertical center of the screen
    db 13, 10, 13, 10, 13, 10, 13, 10, 13, 10, 13, 10, 13, 10, 13, 10
    
    ; Spaces added to pad the text out to the horizontal center
    db '                                  /\_/\', 13, 10
    db '                                 ((@v@))', 13, 10
    db '                                 ():::()', 13, 10
    db '                                  VV-VV', 13, 10
    db 13, 10
    db '                                Schmid OS', 13, 10
    db '                       FlorianSchmid449@gmail.com', 0 

times 510-($-$$) db 0 ; Fill the rest of the 512-byte sector with zeros
dw 0xaa55             ; The standard boot signature required by BIOS
