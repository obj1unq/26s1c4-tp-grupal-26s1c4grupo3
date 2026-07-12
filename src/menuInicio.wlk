import wollok.game.*
import gestorDeNiveles.*
import pantallaControles.*
import configuracionJuego.*

object menuInicio {
  method mostrar() {
    game.clear()
    configuracionJuego.aplicarFondo("menu_juego.jpg")
    self.configurarTeclado()
  }

  method configurarTeclado() {
    keyboard.enter().onPressDo({ self.empezar() })
    // keyboard.c().onPressDo({ self.verControles() })
  }

  method empezar() {
    gestorDeNiveles.iniciarPartida()
  }

  method verControles() {
    pantallaControles.mostrar()
  }

  
}
