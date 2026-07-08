import wollok.game.*

object configuracionJuego {

  method iniciar() {
    game.title("escapaDeLaFortaleza")
    game.width(25)
    game.height(25)
    game.cellSize(64)
  }

  method aplicarFondo(unFondo) {
    fondo.cambiarA(unFondo)
    game.addVisual(fondo)
  }
}

object fondo {
  var property imagenActual = ""

  method position() = game.at(0, 0)
  method image() = imagenActual

  method cambiarA(unaImagen) {
    imagenActual = unaImagen
  }
}
