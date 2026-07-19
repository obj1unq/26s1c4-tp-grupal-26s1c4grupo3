import wollok.game.*
import menuInicio.*
import sistemaDeSalas.configuracionJuego.*

object pantallaControles {
  method mostrar() {
    game.clear()
    configuracionJuego.aplicarFondo("carteles\\fondoGris.png")
    // Teclas ya están en la propia imagen de fondo.
    keyboard.enter().onPressDo({ self.volverAlMenu() })
  }

  method volverAlMenu() {
    menuInicio.mostrar()
  }
}
