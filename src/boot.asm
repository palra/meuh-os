;------------------------------------------
; Avant de commencer, lisez attentivement
; le dossier `doc/01-Architecture`
;------------------------------------------

; initialisation des segments en 0x07C00
    mov ax, 0x07C0
    mov ds, ax
    mov es, ax
    mov ax, 0x8000
    mov ss, ax
    mov sp, 0xf000    ; stack de 0x8F000 -> 0x80000

; affiche un msg
    mov si, msgDebut
    call afficher
end:
    jmp end


;--- Variables ---
    msgDebut db "Wsh", 0
;-----------------

;---------------------------------------------
; Vocabulaire :
; - `DS:SI`
;   `Data Segment` pointé par le registre `SI`
; - `SS:SP`
;   `Stack Segment` pointé par le registre `SP`
;
;---------------------------------------------

;---------------------------------------------------------
; Synopsis: Affiche une chaine de caracteres se terminant par 0x0
; Entree:   DS:SI -> pointe sur la chaine a afficher
;---------------------------------------------------------
afficher:
    push ax
    push bx
.debut:
    lodsb         ; ds:si -> al
    cmp al, 0     ; fin chaine ?
    jz .fin
    mov ah, 0x0E  ; appel au service 0x0e, int 0x10 du bios
    mov bx, 0x07  ; bx -> attribut, al -> caractere ascii
    int 0x10
    jmp .debut

.fin:
    pop bx
    pop ax
    ret

;--- NOP jusqu'a 510 ---
    times 510-($-$$) db 144
    dw 0xAA55