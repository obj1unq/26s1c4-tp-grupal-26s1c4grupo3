import wollok.game.*

class MarcaHerida {
  const objetivo

  method position() = objetivo.position()

  method image() = "heridaSangrado.png"

  method esEnemigo() = false

  method ocultar() {
    game.removeVisual(self)
  }
}

object sinHerida {
  method ocultar() { }
}
