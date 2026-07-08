# Nombre del juego (<- borrar y completar)

## Equipo de desarrollo

- Fernandez, Ramiro
- Perez, Nicole
- Sanchez, Geronimo

## Capturas 

(agregar)

## Reglas de Juego / Instrucciones

El juego comienza con el personaje dentro de alguno de los calabozos de una fortaleza, de la cual tendrá que escapar atravesando enemigos.
Para ello, va a poder encontrar recompensas que le brinden mas fuerza, vida o inclusive curen sus heridas. 
En cada sala que avance, tendra enemigos a los cuales vencer y al abrirse las puertas para avanzar va a obtener dichas recompensas. 
Las recompensas pueden ser un objeto especial que le mejore los atributos mientras lo posea, aumentos de estadisticas temporales o por unica vez o nada.
Ademas, para escapar con éxito tendrá que vencer a un jefe poderoso el cual requerirá haber hecho una buena elección de las recompensas previas para superar su poder de pelea. 



## Otros

- Objetos 1 c4, UNQ
- Version Wollok: "4.2.3"
- Una vez terminado, no tenemos problemas en que el repositorio sea público.

## Ejecutar localmente

Recomendado: usar Node.js v18 con `nvm` para evitar incompatibilidades con la CLI de Wollok.

Comandos rápidos:

```bash
# instalar/usar Node 18 (si tenés nvm)
nvm install 18
nvm use 18

# instalar wollok CLI (si no está instalada)
npm install -g wollok-ts-cli@latest

# ejecutar el juego (abre http://localhost:4200)
wollok run 'src.main.escapaDeLaFortaleza' --skipValidations --port 4200 -p .
```

También podés usar `nvm use 18` antes de cada sesión, o simplemente ejecutar `nvm install` si hay un archivo `.nvmrc` (se incluye en el repo).
