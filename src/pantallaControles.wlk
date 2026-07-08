import wollok.game.*
import menuInicio.*

object pantallaControles {
  method mostrar() {
    game.boardGround("fondoGris.png") // PENDIENTE: reemplazar por el asset final de Nicole. Detalle de teclas a incluir:
                                      // WASD/flechas = moverse, K = atacar, Enter = elegir arma / confirmar, R = reiniciar nivel
                                      // Podria utilizarse las flechas para atacar direccionalmente mas alla de donde este mirando actualmente Prisionero.
    keyboard.enter().onPressDo({ self.volverAlMenu() })
  }

  method volverAlMenu() {
    menuInicio.mostrar()
  }
}
