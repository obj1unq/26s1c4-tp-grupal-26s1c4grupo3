// Superclase de todo lo que se dibuja en el tablero: por defecto nada es un enemigo.
// Los enemigos (PlayerEnemy) overridean esEnemigo() para que Alcance pueda filtrar objetivos.
class ObjetoDelTablero {
  method esEnemigo() = false
}
