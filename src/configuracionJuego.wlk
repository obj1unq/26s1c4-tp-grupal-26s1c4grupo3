import wollok.game.*

object configuracionJuego {
  method iniciar() {
    game.title("escapaDeLaFortaleza")
    game.width(25)
    game.height(25)
    game.cellSize(64)
  }

  method aplicarFondo(unFondo) {
    game.boardGround(unFondo)
  }
}
