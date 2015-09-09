;---------------------------------------------------------
; Synopsis: Affiche une chaine de caracteres se terminant par 0x0
; Entree:   DS:SI -> pointe sur la chaine a afficher
;---------------------------------------------------------

print:
    push ax
    push bx
.prt_start:
    lodsb         ; ds:si -> al
    cmp al, 0     ; fin chaine ?
    jz .prt_end
    mov ah, 0x0E  ; appel au service 0x0e, int 0x10 du bios
    mov bx, 0x07  ; bx -> attribut, al -> caractere ascii
    int 0x10
    jmp .prt_start

.prt_end:
    pop bx
    pop ax
    ret
