import wollok.game.*

class MarcaSuelo {
  const property position

  method image() = "efectos/grietaSuelo.png"

  method esEnemigo() = false

  method ocultar() {
    game.removeVisual(self)
  }
}
