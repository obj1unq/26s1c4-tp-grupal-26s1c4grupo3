import wollok.game.*
import configuracionJuego.*
import gestorDeNiveles.*

object pantallaClases {

  method mostrar() {
    game.clear()
    configuracionJuego.aplicarFondo("fondoPrimerNivel.png")
    game.addVisual(cartelDeClases)

    keyboard.enter().onPressDo({
      gestorDeNiveles.iniciarPartida()
    })
  }
}

object cartelDeClases {

  method position() = game.at(0, 0)

  method image() = "CartelClases.png"

  method esEnemigo() = false
}
