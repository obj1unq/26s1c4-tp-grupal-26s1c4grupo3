import wollok.game.*
import personajePrincipal.*
import armas.*

object gestorArmas {
  const armasDelNivel = []
  var armaYaElegida = false

  method armasDelNivel() = armasDelNivel

  method armaYaElegida() = armaYaElegida

  method iniciar() {
    armasDelNivel.clear()
    armaYaElegida = false
  }

  method agregarArma(arma, posicion) {
    arma.position_(posicion)
    armasDelNivel.add(arma)
  }

  method agregarVisuales() {
    armasDelNivel.forEach({ arma =>
      game.addVisual(arma)
    })
  }

  method intentarElegirArma() {
    if (!armaYaElegida && self.hayArmaEnLaPosicionDelPersonaje()) {
      self.elegirArma(self.armaEnLaPosicionDelPersonaje())
    }
  }

  method hayArmaEnLaPosicionDelPersonaje() =
    armasDelNivel.any({ armaEnMapa =>
      armaEnMapa.position() == prisionero.position()
    })

  method armaEnLaPosicionDelPersonaje() =
    armasDelNivel.find({ armaEnMapa =>
      armaEnMapa.position() == prisionero.position()
    })

  method elegirArma(armaEnMapa) {
    const armaReal = armaEnMapa.arma()

    prisionero.obtenerArma(armaReal)

    armaYaElegida = true
    self.quitarArmasDelNivel()

    game.say(prisionero, "Elegiste " + armaReal.nombre())
  }

  method quitarArmasDelNivel() {
    armasDelNivel.forEach({ armaEnMapa =>
      game.removeVisual(armaEnMapa)
    })

    armasDelNivel.clear()
  }
}
