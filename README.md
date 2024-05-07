## Projet Labo SSI

Projet réalisé durant notre 2nd année qui a comme objectif d'acquérir des compétences dans la programmation de langage de bas niveau

### Sujet : Création d'un keylogger en assembleur. Précisément en NASM x86 32-bits

1 - Le code va créer un fichier key.log dans le répertoire /tmp qui va  enregistrer les touches du clavier. \
\
2 - Le keylogger lira ensuite en temps réel un fichier 'eventX' dans le répertoire /dev/input qui est le fichier qui représentera comme périphérique d'entrée le clavier. \
\
3 - Le code fera ensuite une série de conditions pour sélectionner la bonne partie en hexadécimal qui représentera la touche pressée sur le clavier. \
\
4 - Il transformera cette valeur en décimale qui servira d'index dans une chaîne de caractères qui représentera notre clavier puis écrira la valeur trouvée dans le fichier key.log.


### Utilisation :
Clone le répo :
```git clone https://github.com/quentin-csg/Projet-SSI-B2.git```

Rendre les scripts bash exécutables qui vont automatiser l'assemblage du fichier et la liaison pour créer l'exécutable :
```chmod +x ./code1/elf.sh ./code2/elf.sh ./finalCode/elf.sh```

Exécuter les codes assembleur :
```sudo ./elf.sh code.asm```
 
