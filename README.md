# Escapa de la fortaleza

Juego 2D hecho en Wollok Game para la materia Programación con Objetos (UNQ).

## Cómo probarlo

El proyecto se entrega listo para correr en la carpeta
[`Juego Objetos 1 - Escapa de la Fortaleza/`](<Juego Objetos 1 - Escapa de la Fortaleza>),
con una versión autocontenida por sistema operativo — `Windows/` y `Linux-Mac/` —, cada una
con su propio manual de juego e instrucciones de instalación (IDE de Wollok o línea de
comandos). Elegí la carpeta de tu sistema y ahí adentro tenés todo lo necesario.

## Equipo de desarrollo

- Fernandez, Ramiro
- Perez, Nicole
- Sanchez, Geronimo

## Reglas de juego

Un prisionero debe escapar de una fortaleza atravesando 3 salas, cada una más difícil que la anterior, hasta enfrentar al jefe final en una sala aparte.

### Elegir arma

Al arrancar la partida (sala inicial), el prisionero aparece frente a 3 armas, cada una con su propio alcance (ancho y profundidad del área de ataque) y poder:

- **Espada** — alcance corto y ancho (cuerpo a cuerpo).
- **Báculo** — alcance mediano y ancho (área).
- **Arco** — alcance angosto pero muy largo (a distancia).

Al pararse sobre un arma y confirmar con **ENTER**, las demás desaparecen y recién ahí los enemigos de la sala empiezan a acercarse.

### Combate

Cada sala tiene 5 enemigos que persiguen y atacan al prisionero cuerpo a cuerpo. El tipo de enemigo y su dificultad escalan por sala:

- **Sala 1 (inicial)** — Esqueletos.
- **Sala 2** — Bestias, un 40% más fuertes que en la sala 1.
- **Sala 3** — Rey Oscuro, un 80% más fuerte que en la sala 1.

Al recibir un golpe, el objetivo muestra brevemente una marca de herida. Una sala se completa al derrotar a todos sus enemigos, lo que habilita la puerta de salida hacia la siguiente. Al completar una sala hay una chance de que aparezca una recompensa (poción de curación o mejora de vida máxima) que el prisionero puede recoger antes de avanzar.

### Jefe final

Tras las 3 salas se llega a la sala del jefe final: un enemigo único, mucho más resistente que el resto, que persigue igual que los demás enemigos pero cuyo ataque tiene cooldown propio y una animación de 3 fases (carga → impacto, dejando marcas en el suelo del área golpeada → vuelta a reposo). Al vencerlo se gana la partida.

Si la vida del prisionero llega a 0 en cualquier momento (contra cualquier enemigo, incluido el jefe), se pierde. En ambos casos se vuelve al menú principal.

## Controles

- **ENTER**: empezar la partida / elegir arma / confirmar.
- **WASD** o **flechas**: moverse.
- **K** o **space**: atacar con el arma equipada.
- **C**: ver la pantalla de controles (desde el menú principal).
- **P**: volver al menú principal.
- **+** / **-**: subir o bajar el volumen de la música.

## Tests

Los tests unitarios están en `src/main/test/tests.wtest` (71 tests).

## Otros

- Objetos 1 c4, UNQ
- Versión Wollok: `4.2.3`
- Una vez terminado, no tenemos problemas en que el repositorio sea público.
