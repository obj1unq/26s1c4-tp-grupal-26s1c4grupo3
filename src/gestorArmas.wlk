import wollok.game.*
import personajePrincipal.*
import armas.*

object gestorArmas {
  const armasDelNivel = []
  var armaYaElegida = false

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
  }

  method quitarArmasDelNivel() {
    armasDelNivel.forEach({ armaEnMapa =>
      game.removeVisual(armaEnMapa)
    })

    armasDelNivel.clear()
  }

  method configurarArmasIniciales() {
    self.iniciar()

    self.agregarArma(espadaEnMapa, game.at(10, 6))
    self.agregarArma(baculoEnMapa, game.at(12, 6))
    self.agregarArma(arcoEnMapa, game.at(14, 6))
  }
}
