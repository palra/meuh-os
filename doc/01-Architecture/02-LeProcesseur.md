# Le processeur

## Fonctionnement général

Un processeur a un jeu d'instructions, c'est à dire un ensemble de fonctions qu'il peut appliquer sur des données. Ces données viennent de la mémoire de l'ordinateur, et les calculs vont se faire en copiant ce que l'on veut manipuler dans les registres du processeur.

Un **registre** est un espace mémoire du processeur, qui est très petit (leur taille varie entre 1 octet et un double-mot pour les processeurs 32 bits) et très rapide. On effectue des opérations sur ces registres, après les avoir chargés avec les valeurs voulues, depuis toutes les sources possibles et imaginables.

Pour exécuter un programme, il est chargé en mémoire (dans la RAM), puis le processeur exécute les instructions contenues dans le programme. Cela suppose que le processeur connaît l'adresse vers le programme en mémoire.

## 8 bits ? 16 bits ? 32 bits ?

Un processeur n bits est un processeur capable de faire des calculs sur des séquences binaires de n bits. Un processeur 16 bits a des instructions permettant de faire des calculs sur des mots.

## Registres d'un processeur 32 bits

### Registres de travail

Ces registres sont utilisés pour les calculs à proprement parler de notre code métier. Comme on parle d'un processeur 32 bits, ces registres font 32 bits :

 - **EAX** : Registre accumulateur, utilisé pour le stockage de la valeur de retour d'opérations
 - **EBX** : Registre de base, utilisé comme pointeur de données
 - **ECX** : Registre compter, utilisé pour stocker des compteurs (pour une boucle par exemple)
 - **EDX** : Registre de données, utilisé pour les opérations mathématiques et les entrées/sorties

Chacun de ces registres est constitué d'un registre de 16 bit, correspondant aux 16 bits de poids faible du registre `E-X` (E pour Extended): *AX*, *BX*, *CX* et *DX*.

Chacun de ces registres se décomposent en 2 registres de 8 bits : un registre *-X* se décompose en deux registres **-L** et **-H** (remplacer `-` par la lettre du registre), *-L* représentant l'octet faible (low) et *-H* l'octet fort (high)

```
+--------------------------------------------------+
|                       |             |            |
| .................... EAX .. AH ... AX ... AL ... |
|                       |             |            |
+--------------------------------------------------+
                                                     
+--------------------------------------------------+
|                       |             |            |
| .................... EBX .. BH ... BX ... BL ... |
|                       |             |            |
+--------------------------------------------------+
                                                     
+--------------------------------------------------+
|                       |             |            |
| .................... ECX .. CH ... CX ... CL ... |
|                       |             |            |
+--------------------------------------------------+
                                                     
+--------------------------------------------------+
|                       |             |            |
| .................... EDX .. DH ... DX ... DL ... |
|                       |             |            |
+--------------------------------------------------+
```

### Registres de segment


 - CS : Code Segment, utilisé pour stocker une adresse de segment vers un "code" du programme. Registre inaccessible directement, on passe par des opérandes pour modifier sa valeur.
 - DS : Data Segemnt, pour stocke une adresse de segment vers des données.
 - ES, FS, GS : Data Segments alternatifs
 - SS : Stack Segment, stocke l'adresse de la pile (voir plus bas)

### Registres de contrôle et de statut

Ces registres ont une taille de 32 bits, car ils sont étendus (d'où le `E`), et se décomposent en un sous registre de 16 bit comme vu en haut.

 - ESP : Stack Pointer, on va voir ça plus bas.
 - EIP : Instruction Pointer, contient l'adresse de la prochaine instruction à exécuter. Inacessible directemenent, uniquement via des opérandes (jmp, call, ret ...)
 - EDI : Destination Index, voir ESI
 - ESI : Source Index, utilisé pour des opérations de copie de suite d'octets
 - EFLAG : encore un peu plus bas

TODO : stack, flags