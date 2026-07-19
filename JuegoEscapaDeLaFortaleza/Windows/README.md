# Escapa de la fortaleza 1.9.4 (versión Windows)

Juego 2D hecho en Wollok Game para la materia Programación con Objetos (UNQ).

Esta carpeta es autocontenida: tiene el código (`src/`), los assets (`assets/`) y la
configuración (`package.json`) necesarios para correr el juego en **Windows**. No hace falta
nada más que lo que está acá adentro.

## Equipo de desarrollo

- Fernandez, Ramiro
- Perez, Nicole
- Sanchez, Geronimo

## Reglas de juego

Un prisionero debe escapar de una fortaleza atravesando 3 salas, cada una más difícil que la
anterior, hasta enfrentar al jefe final en una sala aparte.

### Elegir arma

Al arrancar la partida (sala inicial), el prisionero aparece frente a 3 armas, cada una con
su propio alcance (ancho y profundidad del área de ataque) y poder:

- **Espada** — alcance corto y ancho (cuerpo a cuerpo).
- **Báculo** — alcance mediano y ancho (área).
- **Arco** — alcance angosto pero muy largo (a distancia).

Al pararse sobre un arma y confirmar con **ENTER**, las demás desaparecen y recién ahí los
enemigos de la sala empiezan a acercarse.

### Combate

Cada sala tiene 5 enemigos que persiguen y atacan al prisionero cuerpo a cuerpo. El tipo de
enemigo y su dificultad escalan por sala:

- **Sala 1 (inicial)** — Esqueletos.
- **Sala 2** — Bestias, un 40% más fuertes que en la sala 1.
- **Sala 3** — Rey Oscuro, un 80% más fuerte que en la sala 1.

Al recibir un golpe, el objetivo muestra brevemente una marca de herida. Una sala se completa
al derrotar a todos sus enemigos, lo que habilita la puerta de salida hacia la siguiente. Al
completar una sala hay una chance de que aparezca una recompensa (poción de curación o mejora
de vida máxima) que el prisionero puede recoger antes de avanzar.

### Jefe final

Tras las 3 salas se llega a la sala del jefe final: un enemigo único, mucho más resistente que
el resto, que persigue igual que los demás enemigos pero cuyo ataque tiene cooldown propio y
una animación de 3 fases (carga → impacto, dejando marcas en el suelo del área golpeada →
vuelta a reposo). Al vencerlo se gana la partida.

Si la vida del prisionero llega a 0 en cualquier momento (contra cualquier enemigo, incluido
el jefe), se pierde. En ambos casos se vuelve al menú principal.

## Controles

- **ENTER**: empezar la partida / elegir arma / confirmar.
- **WASD** o **flechas**: moverse.
- **K** o **SPACE**: atacar con el arma equipada.
- **C**: ver la pantalla de controles (desde el menú principal).
- **P**: volver al menú principal.
- **+** / **-**: subir o bajar el volumen de la música.

## Instalación y ejecución (Windows)

Hay dos formas de correrlo: con el **IDE de Wollok** (no requiere terminal) o con la **línea
de comandos**.

### Opción A — IDE de Wollok (recomendado)

1. Descargar e instalar Wollok desde [wollok.org](https://www.wollok.org/) (versión 4.2.3 o
   compatible).
2. **File → Open Folder** y seleccionar esta carpeta completa (`Windows`), no un archivo
   suelto.
3. Abrir `src/main/main.wpgm` en el explorador de archivos del IDE.
4. Correr con el botón de **Run** (▶) del editor (o clic derecho → *Run Wollok Program*). Se
   abre el juego en el navegador integrado.
5. Para los tests: abrir `src/main/test/tests.wtest` y correr con el mismo botón (o clic
   derecho → *Run Wollok Tests*).

### Opción B — Línea de comandos (wollok-ts-cli)

Requiere [Node.js](https://nodejs.org/) (versión 18 o superior).

1. Instalar el CLI (una sola vez):
   ```
   npm install -g wollok-ts-cli
   ```
2. Abrir una terminal **dentro de esta carpeta** (`Windows`).
3. Correr el juego:
   ```
   wollok run src.main.main.escapaDeLaFortaleza
   ```
   Se abre en el navegador, puerto por defecto `4200`.
4. Correr los tests:
   ```
   wollok test
   ```
   Deberían pasar los 85 tests.
