import wollok.game.*
import gestorDeNiveles.*
import pantallaControles.*
import configuracionJuego.*
import pantallaClases.*

object menuInicio {
  method mostrar() {
    game.clear()
    configuracionJuego.aplicarFondo("carteles/menu_juego.jpg")
    self.configurarTeclado()
  }

  method configurarTeclado() {
    keyboard.enter().onPressDo({ self.empezar() })
    // keyboard.c().onPressDo({ self.verControles() })
  }

  method empezar() {
    pantallaClases.mostrar()
}

  method verControles() {
    pantallaControles.mostrar()
  }

  
}
