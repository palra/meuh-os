[BITS 32]
[ORG 0x1000]

jmp start
start:
    mov byte [0xB8B40], 'H'
    mov byte [0xB8B41], 0x0E
    mov byte [0xB8B42], 'e'
    mov byte [0xB8B43], 0x0E
    mov byte [0xB8B44], 'l'
    mov byte [0xB8B45], 0x0E
    mov byte [0xB8B46], 'l'
    mov byte [0xB8B47], 0x0E
    mov byte [0xB8B48], 'o'
    mov byte [0xB8B49], 0x0E
    mov byte [0xB8B4A], ' '
    mov byte [0xB8B4B], 0x0E
    mov byte [0xB8B4C], 'W'
    mov byte [0xB8B4D], 0x0E
    mov byte [0xB8B4E], 'o'
    mov byte [0xB8B4F], 0x0E
    mov byte [0xB8B50], 'r'
    mov byte [0xB8B51], 0x0E
    mov byte [0xB8B52], 'l'
    mov byte [0xB8B53], 0x0E
    mov byte [0xB8B54], 'd'
    mov byte [0xB8B55], 0x0E
    mov byte [0xB8B56], '!'
    mov byte [0xB8B57], 0b10001100
end:
	jmp end