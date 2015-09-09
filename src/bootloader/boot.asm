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
    mov sp, 0xf000  ; stack de 0x8F000 -> 0x80000

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

; ------------------------- Passage en mode protégé ---------------------------

    ; calcul de la taille de la gdt : fin - début = taille
    mov ax, gdtend
    mov bx, gdt
    sub ax, bx            ; ax = ax - bx
    mov word [gdtptr], ax ; place le contenu de `ax` dans `gdtptr`
                          ; `mov word` indique que l'on doit déplacer
                          ; 2 octets (word = 2 bytes)

    ; calcul de l'addresse linéaire de la gdt
    xor eax, eax
    xor ebx, ebx
    mov ax, ds                ; ds = 0x07C0, voir l.13
    mov ecx, eax              ; Rappel : ax est inclus dans eax
    shl ecx, 4                ; décalage arithmétique de 4, voir 01/01-MemoireRAM.md
    mov bx, gdt               ; Addresse de la GDT dans le programme
    add ecx, ebx              ; (sélécteur << 4) + offset = addresse linéaire
    mov dword [gdtptr+2], ecx ; Copie de l'addresse linéaire dans la structure gdtptr
                              ; `gdtptr+2` parce que les deux premiers octets sont 
                              ; réservés à la base.

    ; arrêt des interruptions
    cli

    ; utilisation de la nouvelle gdt
    lgdt [gdtptr] ; passe l'addresse de la GDT (stockée dans gdtptr) à l'instruction 
                  ; lgdt

    ; passage au mode protégé
    mov eax, cr0
    or ax, 1     ; bit n°0 passé à 1
    mov cr0, eax

    ; réinitialsation des caches internes du processeur
    ; obligatoirement juste après le passage au mode protégé
    jmp next
    next:

    ; réinitialisation des segments de données
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax


    ; réinitialisation de la pile
    mov ss, ax
    mov esp, 0x9f000

; -------------------------- Lancement du kernel ------------------------------
    jmp dword 0x8:0x1000
; -----------------------------------------------------------------------------



;--- Variables ---
    bootDrv: db 0
    msgDebut db "Loading MeuhOS ...", 13, 10, 0

    gdt:
        db 0, 0, 0, 0, 0, 0, 0, 0
    gdt_cs:
        db 0xFF, 0xFF, 0x0, 0x0, 0x0, 10011011b, 11011111b, 0x0
    gdt_ds:
        db 0xFF, 0xFF, 0x0, 0x0, 0x0, 10010011b, 11011111b, 0x0
    gdtend:
    gdtptr: ; Espace mémoire réservé pour 
        dw 0 ; limite
        dd 0 ; base
;-----------------

;--- NOP jusqu'a 510 ---
    times 510-($-$$) db 144
    dw 0xAA55