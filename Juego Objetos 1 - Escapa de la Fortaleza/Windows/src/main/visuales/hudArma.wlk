import wollok.game.*

object hudArma {
  var iconoActual = ""

  method position() = game.at(20, 0)

  method image() = iconoActual

  method esEnemigo() = false

  method aparecer() {
    game.addVisual(self)
  }

  method actualizar(arma) {
    iconoActual = arma.iconoHud()
  }
}
