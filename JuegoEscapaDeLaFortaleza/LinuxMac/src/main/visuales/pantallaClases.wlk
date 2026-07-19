import wollok.game.*
import sistemaDeSalas.configuracionJuego.*
import sistemaDeSalas.gestorDeNiveles.*
import sistemaDeSalas.sistemaSonido.*
import sistemaDeCombate.objetoDelTablero.*

object pantallaClases {

  method mostrar() {
    game.clear()
    configuracionJuego.aplicarFondo("mapas\\fondoPrimerNivel.png")
    game.addVisual(cartelDeClases)

    keyboard.enter().onPressDo({
      gestorDeNiveles.iniciarPartida()
    })
    sistemaSonido.configurarTeclas()
  }
}

object cartelDeClases inherits ObjetoDelTablero {

  method position() = game.at(0, 0)

  method image() = "carteles\\CartelClases.png"
}
