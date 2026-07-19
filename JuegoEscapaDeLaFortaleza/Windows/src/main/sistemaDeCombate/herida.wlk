import wollok.game.*
import objetoDelTablero.*

class MarcaHerida inherits ObjetoDelTablero {
  const objetivo

  method position() = objetivo.position()

  method image() = "heridaSangrado.png"

  method ocultar() {
    game.removeVisual(self)
  }
}

object sinHerida {
  method ocultar() { }
}
