import wollok.game.*
import menuInicio.*
import sistemaDeSalas.configuracionJuego.*

object pantallaControles {
  method mostrar() {
    game.clear()
    configuracionJuego.aplicarFondo("fondoGris.png")
    // Teclas listadas en la propia imagen de fondo: WASD/flechas moverse, K o SPACE atacar,
    // ENTER confirmar/elegir arma, P menú, +/- volumen, C controles.
    keyboard.enter().onPressDo({ self.volverAlMenu() })
  }

  method volverAlMenu() {
    menuInicio.mostrar()
  }
}
