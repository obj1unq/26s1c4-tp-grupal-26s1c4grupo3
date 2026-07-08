import wollok.game.*
import menuInicio.*
import configuracionJuego.*

object finDeJuego {
  method mostrarVictoria() {
    game.clear()
    configuracionJuego.aplicarFondo("cartel_victoria.jpg")
    self.configurarVuelta()
  }

  method mostrarDerrota() {
    game.clear()
    configuracionJuego.aplicarFondo("cartel_derrota.jpg")
    self.configurarVuelta()
  }

  method configurarVuelta() {
    keyboard.enter().onPressDo({ menuInicio.mostrar() })
  }
}
