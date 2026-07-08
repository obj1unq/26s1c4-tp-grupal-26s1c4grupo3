import wollok.game.*
import menuInicio.*
import configuracionJuego.*

object finDeJuego {
  method mostrarVictoria() {
    game.clear()
    configuracionJuego.aplicarFondo("victoria.png") // PENDIENTE: reemplazar por el asset final de Nicole
    self.configurarVuelta()
  }

  method mostrarDerrota() {
    game.clear()
    configuracionJuego.aplicarFondo("derrota.png") // PENDIENTE: reemplazar por el asset final de Nicole
    self.configurarVuelta()
  }

  method configurarVuelta() {
    keyboard.enter().onPressDo({ menuInicio.mostrar() })
  }
}
