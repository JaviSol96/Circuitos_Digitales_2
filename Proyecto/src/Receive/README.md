# Grupo-1-Digitales-II-2-2022
Este es el repositorio para el Grupo 1

## Indicaciones para commit changes
Definir una descripción clara y concisa que caracterice los cambios que se realizan en 
el código. 
Podría utilizarse la siguiente convención para especificar los cambios a
cada módulo, de manera que el docente también lleve claras las modificaciones.
- TXN: máquina de transmisión.
- SYNC : máquina de sincronización.
- RECP: máquina de recepción.

De esta manera, un ejemplo de commit sería el siguiente:
```
commit -m "[TXN] Modificando code groups para estado IDLE."
commit -m "[SYNC] Agregando módulos de estados descriptivos para la sincronización."
```
De esta manera podemos ver el flag de quien aporta al código y será fácil reconocer el commit donde
podría ubicarse un bug o algo necesario que requiera ser modificado.

Cuando se quiera realizar un fix, o cambio interno de algun archivo o fichero, se propone la siguiente forma
de comentar el cambio:

```
commit -m "[TXN/SYNC/RECV FIX] Agregando archivo borrado.
```
Asi se puede entender si el commit se trata de un codigo extra, o simplemente modificaciones a nivel 
de estructura del repositorio.
