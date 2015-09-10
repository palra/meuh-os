# Interruptions

Documentation de toutes les interruptions utilisées

## Servies de l'interruption **0x13**

Interruptions portant sur la manipulation des disques

### Sélection de disque, registre DL

*DL = 0x00* : disquette n°0 (A: pour la notation "Windows")
*DL = 0x01* : disquette n°1
*DL = 0x00* + *i* : disquette n°*i*

*DL = 0x80* : disque dur n°0
*DL = 0x81* : disque dur n°1
*DL = 0x80* + *i* : disque dur n°*i*

### Fonctions, registre AH

#### AH = 0x00 : réinitialisation des disques durs

Réinitialise l'état du disque *DL* (position de la tête de lecture, et autres paramètres).
Il ne s'agit pas de tout effacer !

Exemple : réinitialisation du disque 3

```asm
	xor ax, ax ; remet à zéro le registre `ax`, équivalent à mov ax, 0
	mov dl, 0x03
	int 0x13 ; Here comes the magic !
```

#### AH = 0x02 : lire secteurs depuis disque

Paramètres : 

 * AL : numéro de secteur de fin (le premier secteur est le **numéro 1**, et **pas** le *numéro 0* !!)
 * CH : cylindre de début (le premier cylindre est le **numéro 0**, lui !)
 * CL : secteur de début (le premier secteur est le **numéro 1**)
 * DH : tête de lecture (la première est la **numéro 0**)

Exemple : lire les 5 premiers secteurs du disque 0 :

```asm
	mov ah, 2  ; Fonction n°2
	mov al, 6  ; On s'arrête au secteur n°6
	xor ch, ch ; On met le registre `ch` à 0 : numéro du cylindre
	mov cl, 1  ; Secteur de début, le 1er
	xor dh, dh ; Tête de lecture n°0, en général y'en a qu'une seule de tête
	int 0x13   ; On exécute le tout !
```