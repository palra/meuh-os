;------------------------------------------
; Avant de commencer, lisez attentivement
; le dossier `doc/01-Architecture`
;------------------------------------------

%define BASE  0x100 ; 0x0100:0x0 = 0x1000
%define KSIZE 1     ; nombre de secteurs de 512 à charger

jmp start
%include "util.inc"

start:
; initialisation des segments en 0x07C00
    mov ax, 0x07C0
    mov ds, ax
    mov es, ax
    mov ax, 0x8000
    mov ss, ax
    mov sp, 0xf000    ; stack de 0x8F000 -> 0x80000

; affiche un msg
    mov si, msgDebut
    call print

; chargement du noyau
    xor ax, ax ; ax = 0, d'où ah = 0
    int 0x13 ; int 13h, fonction ah = 0

    push es
        mov ax, BASE
        mov es, ax
        mov bx, 0

        mov ah, 2
        mov al, KSIZE
        mov ch, 0
        mov cl, 2
        mov dh, 0
        mov dl, [bootDrv]
        int 0x13 ; appel de l'interruption
    pop es

    jmp dword BASE:0 ; basculement vers le kernel

end:
    jmp end


;--- Variables ---
    bootDrv: db 0
    msgDebut db "Chargement du kernel ...", 13, 10, 0
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

;--- NOP jusqu'a 510 ---
    times 510-($-$$) db 144
    dw 0xAA55