import wollok.game.*
import menuInicio.*

object finDeJuego {
  method mostrarVictoria() {
    game.clear()
    game.boardGround("victoria.png") // PENDIENTE: reemplazar por el asset final de Nicole
    self.configurarVuelta()
  }

  method mostrarDerrota() {
    game.clear()
    game.boardGround("derrota.png") // PENDIENTE: reemplazar por el asset final de Nicole
    self.configurarVuelta()
  }

  method configurarVuelta() {
    keyboard.enter().onPressDo({ menuInicio.mostrar() })
  }
}
