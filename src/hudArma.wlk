import wollok.game.*

object hudArma {
  var property iconoActual = ""

  method position() = game.at(24, 0)
  method image() = iconoActual

  method actualizar(arma) {
    iconoActual = arma.iconoHud()
  }
}
