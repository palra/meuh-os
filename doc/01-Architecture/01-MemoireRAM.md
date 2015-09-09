## La mémoire d'un ordinateur

### Endianness

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

### Représentation linéaire d'une adresse

A chaque octet on associe une adresse. Le premier octet aura pour adresse 0, le second 1, le troisième 10, le quatrième 11 ...

Pour représenter une adresse en mémoire, on va utiliser deux mots (8 octets) que l'on notera XXXX:YYYY (X et Y étant des nombres hexadécimaux)

 - XXXX : **adresse de segment**
 - YYYY : **adresse d'offset**

Pour faire la correspondance entre cette notation et l'adresse en mémoire, on procède ainsi :

```
Segment    xxxx xxxx xxxx xxxx
Offset   +           yyyy yyyy yyyy yyyy
Adresse    zzzz zzzz zzzz zzzz zzzz zzzz
```

Adresse = Segment * 0x10 (16) + Offset

Une adresse peut être donc pointée par plusieurs de ces notations.
