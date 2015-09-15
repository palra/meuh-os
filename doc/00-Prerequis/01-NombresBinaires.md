# Représenter des données en binaire

## Vocabulaire

Binaire : système numérique avec que des 0 ou des 1

 - 0 ou 1 : **bit**
 - 8 bits : **octet** (*byte*)
 - 2 octets : **mot** (*word*)
 - 4 octets, 2 mots : **double-mot** (*double-word*)
 - 16 octets, 8 mots ou 4 double-mots : **paragraphe** (*paragraph*)

## Arithmétique, ou comment représenter des nombres en binaires ?

### Non signée (nombres positifs)

Prenons l'octet : `1001011`
Cet octet représente un nombre codée sans signe (nombre positif).

```
+-----------------------------------------------+    
| Multiplicande |128| 64| 32| 16|  8|  4|  2|  1|    
+-----------------------------------------------+    
|En puiss. de 2 |2^7|2^6|2^5|2^4|2^3|2^2|2^1|2^0|    
+-----------------------------------------------+    
                | 1 | 0 | 0 | 0 | 1 | 0 | 1 | 1 |    
                +-----------------------------------+
                |128| 64|   |   | 8 |   | 2 | 1 |203|
                +-----------+---+---+---+---+-------+
```

Il correspond au nombre *203*.

### Opérations

#### Addition

On additionne colonne par colonne en sachant que :

 * 0 + 0 = 0
 * 0 + 1 = 1 + 0 = 1
 * 1 + 1 = 0 avec une retenue

Faisons `11001101` + `10001010`

```
    +---+---+---+---+---+---+---+---+
  1 |   |   |   | 1 |   |   |   |   |
    +-------------------------------+
    | 1 | 1 | 0 | 0 | 1 | 1 | 0 | 1 |
+-----------------------------------+
| + | 1 | 0 | 0 | 0 | 1 | 0 | 1 | 0 |
+-----------------------------------+
  1  | 0 | 1 | 0 | 0 | 0 | 0 | 1 | 1 |
    +---+---+---+---+---+---+---+---+
```

Cela donne 0100011. Oui, il y a eu un dépassement de 
capacité.

#### Complément à deux

Pour avoir le complément à deux d'une série binaire :

 - *Inverser* tous les bits
 - Faire l'*addition* de la séquence obtenu et 1

C2 de 1001 :

 - *Inversion* : `0110`
 - *Addition* : `0110` + `0001` = `0111`

C2 de 0100 :
 - *Inversion* : `1011`
 - *Addition* : `1011` + `0001` = `1100`

#### Soustraction

A - B = A + C2(B)

Exemple : 8 - 1 = `1000` - `0001` = `1000` + `1111` = `0111`

### Attention aux dépassement de capacité !

Bien qu'en maths 1000 + 1111 = 10111, on **DOIT** ignorer les bits qui dépassent,
parce que *c'est comme ça qu'un processeur fera*.
Pour un processeur, `1000` + `1111` = `0111` car on additione 4 bits.
En revanche, `0000 1000` + `0000 1111` = `0001 0111`