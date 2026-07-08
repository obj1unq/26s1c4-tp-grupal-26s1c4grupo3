import wollok.game.*

object hudArma {
  var property iconoActual = ""

  method position() = game.at(20, 0)
  method image() = iconoActual

  method actualizar(arma) {
    iconoActual = arma.iconoHud()
  }
}
