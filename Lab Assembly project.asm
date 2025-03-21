; Assembly program to reverse a string and check if it's a palindrome
; Designed for EMU8086

.model small
.stack 100h

.data
    original_string db "ahmmha$", 0   ; Input string (ends with $)
    reversed_string db 7 dup(0)     ; Space for reversed string 
    string_displayer db "The reversed string is: $"
    palindrome_msg db "The string is a palindrome.$", 0
    not_palindrome_msg db "The string is NOT a palindrome.$", 0

.code
main proc
    mov ax, @data       ; Initialize data segment
    mov ds, ax

    ; Step 1: Reverse the string
    lea si, original_string  ; SI points to the original string
    lea di, reversed_string  ; DI points to the reversed string
    mov cx, 0                ; CX will count the string length

find_length:
    mov al, [si]             ; Load the current character
    cmp al, '$'              ; Check for string terminator
    je reverse_string        ; If '$', end of string
    inc si                   ; Move to the next character
    inc cx                   ; Increment length counter
    jmp find_length          ; Repeat until end of string

reverse_string:
    dec si                   ; SI now points to the last character (before $)
reverse_loop:
    mov al, [si]             ; Load the character from the original string
    mov [di], al             ; Store it in the reversed string
    dec si                   ; Move SI backward
    inc di                   ; Move DI forward
    loop reverse_loop        ; Repeat until CX = 0

    mov al, '$'              ; Add string terminator to the reversed string
    mov [di], al 
    


    ; Step 2: Compare the original and reversed strings
    lea si, original_string  ; SI points to the original string
    lea di, reversed_string  ; DI points to the reversed string 
    
display_reversed:
lea dx, display_string
mov ah, 09
int 21h

lea dx, reversed_string
mov ah, 09
int 21h

compare_loop:
    mov al, [si]             ; Load character from original string
    mov bl, [di]             ; Load character from reversed string
    cmp al, '$'              ; Check for string terminator
    je palindrome            ; If '$', strings match
    cmp al, bl               ; Compare characters
    jne not_palindrome       ; If mismatch, not a palindrome
    inc si                   ; Move to the next character in original string
    inc di                   ; Move to the next character in reversed string
    jmp compare_loop         ; Repeat comparison

palindrome:
    ; Display palindrome message
    lea dx, palindrome_msg
    mov ah, 09h              ; DOS interrupt to print string
    int 21h
    jmp end_program          ; Exit program

not_palindrome:
    ; Display not palindrome message
    lea dx, not_palindrome_msg
    mov ah, 09h              ; DOS interrupt to print string
    int 21h

end_program:
    ; Exit program
    mov ah, 4Ch
    int 21h

main endp
end main
