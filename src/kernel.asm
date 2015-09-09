[BITS 16]
[ORG 0x0]

jmp start

%include "./util.inc"

start:
	; Initialisation des segments
	mov ax, 0x100
	mov ds, ax ; Data segment
	mov es, ax ; Extended data segment

	; Affichage du message
end:
	mov si, msgKernel
	call print
	jmp end

msgKernel: db "Hello world, from the Kernel !", 13, 10, 0