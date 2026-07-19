import wollok.game.*
import sistemaDeCombate.objetoDelTablero.*

object hudArma inherits ObjetoDelTablero {
  var iconoActual = ""

  method position() = game.at(20, 0)

  method image() = iconoActual

  method aparecer() {
    game.addVisual(self)
  }

  method actualizar(arma) {
    iconoActual = arma.iconoHud()
  }
}
