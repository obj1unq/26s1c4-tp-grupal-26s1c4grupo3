import wollok.game.*
import nivel1.*
import pantallaControles.*

object menuInicio {
  method mostrar() {
    game.clear()
    game.boardGround("fondoGris.png") // PENDIENTE: reemplazar por el asset final de Nicole (texto "ENTER: empezar" / "C: controles")
    self.configurarTeclado()
  }

  method configurarTeclado() {
    keyboard.enter().onPressDo({ self.empezar() })
    keyboard.c().onPressDo({ self.verControles() })
  }

  method empezar() {
    nivel1.iniciar()
  }

  method verControles() {
    pantallaControles.mostrar()
  }
}
