import wollok.game.*
import menuInicio.*
import sistemaDeSalas.configuracionJuego.*

object finDeJuego {
  method mostrarVictoria() {
    game.clear()
    configuracionJuego.aplicarFondo("carteles/cartel_victoria.jpg")
    self.configurarVuelta()
  }

  method mostrarDerrota() {
    game.clear()
    configuracionJuego.aplicarFondo("carteles/cartel_derrota.jpg")
    self.configurarVuelta()
  }

  method configurarVuelta() {
    keyboard.enter().onPressDo({ menuInicio.mostrar() })
  }
}
