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

 - ESP : Stack Pointer
 - EIP : Instruction Pointer, contient l'adresse de la prochaine instruction à exécuter. Inacessible directemenent, uniquement via des opérandes (jmp, call, ret ...)
 - EDI : Destination Index, voir ESI
 - ESI : Source Index, utilisé pour des opérations de copie de suite d'octets
 - EFLAG : encore un peu plus bas

## La pile

Pour manipuler nos données, nous avons les 4 registres de travail EAX, EBX, ECX et EDX. Imaginons que pendant l'exécution de notre programme nous voulons passer la main à un sous-programme, histoire de ne pas se répéter et de simplifier les choses. Ce sous-programme travaillera sur les même registres de travail. Avant de lui passer la main, il faut donc sauvegarder l'état de ces registres avant de continuer. On utilise donc une pile, plus spécifiquement une pile FIFO (First In First Out).

Le principe : on réserve en mémoire une zone dédiée à stocker l'état de ces registres. Pour faire cela, on utilise les deux registres de pile :

 - SS contient l'adresse du segment de la pile en mémoire
 - ESP est l'offset à ajouter à SS pour atteindre le dernier élément stocké dans la pile (rappelez vous, notation linéaire d'une addresse ...)

En représentant la mémoire de manière graphique, on a :

```
+-------+  0x100000 (en supposant que la RAM aie une taille de 0x100000 octets)
|       |          
|       |          
|       |          
|       |          
|       |          
|       |          
|       |          
+-------+  SS:ESP  
|   +   |          
|   |   |          
|   |   |          
|   |   |          
|   |   |          
|   v   |          
+-------+  SS:00   
|       |          
|       |          
|       |          
|       |          
|       |          
|       |          
|       |          
+-------+  0x0     
```

Lorsque l'on veut ajouter un élément à la pile :

 1. Le processeur va à l'adresse SS:ESP
 2. Il retire à ESP la taille des données à insérer (concrètement, la taille du registre)
 2. Il ajoute les données à insérer à la nouvelle adresse SS:ESP

```
+-------+  0x100000    +-------+  0x100000    +-------+  0x100000
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
+-------+              +-------+              +-------+          
|10010..|  SS:ESP      |10010..|              |10010..|          
|   +   |              |00101..|  SS:ESP      |00101..|          
|   |   |              |   +   |              |10111..|  SS:ESP  
|   |   |              |   |   |              |   x   |          
|   |   |              |   |   |              |   |   |          
|   v   |              |   v   |              |   v   |          
+---+---+  SS:00       +---+---+  SS:00       +---+---+  SS:00   
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
+-------+  0x0         +-------+  0x0         +-------+  0x0     
                                                                 
ESP = 0x10             ESP = 0x0F             ESP = 0x0E         
```

Inversement, lorsque l'on veut récupérer le dernier élément de la pile :

 1. Le processeur va à l'adresse SS:ESP
 2. Il lit le dernier élément, et le supprime de la pile
 3. Il incrémente ESP de la taille de la donnée supprimée

```
+-------+  0x100000    +-------+  0x100000    +-------+  0x100000
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
+-------+              +-------+              +-------+          
|10010..|              |10010..|              |10010..|  SS:ESP  
|00101..|              |00101..|  SS:ESP      |   +   |          
|10111..|  SS:ESP      |   +   |              |   |   |          
|   x   |              |   |   |              |   |   |          
|   |   |              |   |   |              |   |   |          
|   v   |              |   v   |              |   v   |          
+---+---+  SS:00       +---+---+  SS:00       +---+---+  SS:00   
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
|       |              |       |              |       |          
+-------+  0x0         +-------+  0x0         +-------+  0x0     
                                                                 
ESP = 0x0E             ESP = 0x0F             ESP = 0x10         
```

TODO : flags