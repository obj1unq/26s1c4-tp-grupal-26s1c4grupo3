import wollok.game.*
import nivel1.*
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
    nivel1.iniciarNuevaPartida()
}

  method verControles() {
    pantallaControles.mostrar()
  }

  
}
