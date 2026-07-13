import wollok.game.*
import personajePrincipal.*
import armas.*

object gestorArmas {
  const armasDelNivel = []

  method armaYaElegida() = armasDelNivel.isEmpty()

  method agregarArma(armaEnMapa, posicion) {
    armaEnMapa.position(posicion)
    armasDelNivel.add(armaEnMapa)
  }

  method agregarVisuales() {
    armasDelNivel.forEach({ armaEnMapa => armaEnMapa.aparecer() })
  }

  method intentarElegirArma() {
    if (self.hayArmaEnLaPosicionDelPersonaje()) {
      self.elegirArma(self.armaEnLaPosicionDelPersonaje())
    }
  }

  method hayArmaEnLaPosicionDelPersonaje() =
    armasDelNivel.any({ armaEnMapa => armaEnMapa.position() == prisionero.position() })

  method armaEnLaPosicionDelPersonaje() =
    armasDelNivel.find({ armaEnMapa => armaEnMapa.position() == prisionero.position() })

  method elegirArma(armaEnMapa) {
    const armaReal = armaEnMapa.arma()
    prisionero.equiparArma(armaReal)
    self.quitarArmasDelNivel()
  }

  method quitarArmasDelNivel() {
    armasDelNivel.forEach({ armaEnMapa => armaEnMapa.desaparecer() })
    armasDelNivel.clear()
  }

  method configurarArmasIniciales() {
    armasDelNivel.clear()
    self.agregarArma(espadaEnMapa, game.at(10, 6))
    self.agregarArma(baculoEnMapa, game.at(12, 6))
    self.agregarArma(arcoEnMapa, game.at(14, 6))
  }
}

