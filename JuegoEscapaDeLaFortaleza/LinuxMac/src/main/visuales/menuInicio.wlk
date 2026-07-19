import wollok.game.*
import sistemaDeSalas.gestorDeNiveles.*
import pantallaControles.*
import sistemaDeSalas.configuracionJuego.*
import sistemaDeSalas.sistemaSonido.*
import pantallaClases.*

object menuInicio {
  method mostrar() {
    game.clear()
    configuracionJuego.aplicarFondo("carteles/menu_juego.jpg")
    self.configurarTeclado()
  }

  method configurarTeclado() {
    keyboard.enter().onPressDo({ self.empezar() })
    keyboard.c().onPressDo({ self.verControles() })
    sistemaSonido.configurarTeclas()
  }

  method empezar() {
    pantallaClases.mostrar()
}

  method verControles() {
    pantallaControles.mostrar()
  }

  
}
