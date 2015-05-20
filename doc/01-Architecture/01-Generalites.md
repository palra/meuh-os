Avant de commencer, lisez le dossier `00-Prerequis`.

# Généralités

## La mémoire d'un ordinateur

La mémoire ne stocke que des bits.
Les bits sont regroupés par octets, et la plus petite portion de données
que l'on peut manipuler est l'octet.

Pour représenter un nombre entier, on utilise usuellement deux octets. 
Prenons `A2 78`, on peut le représenter en mémoire de deux manières différentes

En big endian :

```
+--------+----+----+----
| Numéro |  0 |  1 |  2 
+--------+----+----+----
| Donnée | A2 | 78 | .. 
+--------+----+----+----
```

En little endian :

```
+--------+----+----+----
| Numéro |  0 |  1 |  2 
+--------+----+----+----
| Donnée | 78 | A2 | .. 
+--------+----+----+----
```

 - **big endian** : octets de poids forts (qui codent pour les valeurs les plus élevées) d'abord
 - **little endian** : octets de poids faible (qui codent pour les valeurs les plus faibles) d'abord

Seul l'ordre des octets change, les octets conservent le même ordre d'écriture.

Les processeurs x86 (ceux que pratiquement tout le monde a sur leur ordinateur) sont en little endian.

## Le processeur

### Fonctionnement général

Un processeur a un jeu d'instructions, c'est à dire un ensemble de fonctions qu'il peut appliquer sur des données. Ces données viennent de la mémoire de l'ordinateur, et les calculs vont se faire en copiant ce que l'on veut manipuler dans les registres du processeur.

Un registre est un espace mémoire du processeur, qui est très petit (leur taille varie entre 1 octet et un double-mot pour les processeurs 32 bits). On effectue des opérations sur ces registres, puis on en fait ce qu'on veut.

### 8 bits ? 16 bits ? 32 bits ?

Un processeur n bits est un processeur capable de faire des calculs sur des séquences binaires de n bits. Un processeur 16 bits a des instructions permettant de faire des calculs sur des mots.

### Registres d'un processeur 32 bits

#### Registres de travail

Ces registres sont utilisés pour les calculs à proprement parler de notre code métier. Comme on parle d'un processeur 32 bits, ces registres font 32 bits :

 - **EAX** : Registre accumulateur, utilisé pour le stockage de la valeur de retour d'opérations
 - **EBX** : Registre de base, utilisé comme pointeur de données
 - **ECX** : Registre compter, utilisé pour stocker des compteurs (pour une boucle par exemple)
 - **EDX** : Registre de données, utilisé pour les opérations mathématiques et les entrées/sorties

Chacun de ces registres est constitué d'un registre de 16 bit, correspondant aux 16 bits de poids faible du registre E-X : *AX*, *BX*, *CX* et *DX*.

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