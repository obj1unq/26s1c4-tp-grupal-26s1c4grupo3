import wollok.game.*
import sistemaDeCombate.objetoDelTablero.*

class MarcaSuelo inherits ObjetoDelTablero {
  const property position

  method image() = "efectos/grietaSuelo.png"

  method aparecer() {
    game.addVisual(self)
  }

  method ocultar() {
    game.removeVisual(self)
  }
}
