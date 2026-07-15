import wollok.game.*
import personajePrincipal.*
import armas.*
import hudArma.*

object gestorArmas {
  const armasDelNivel = []

  method armaYaElegida() = armasDelNivel.isEmpty()

  method agregarArma(armaEnMapa) {
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
    hudArma.actualizar(armaReal)
    self.quitarArmasDelNivel()
  }

  method quitarArmasDelNivel() {
    armasDelNivel.forEach({ armaEnMapa => armaEnMapa.desaparecer() })
    armasDelNivel.clear()
  }

  method configurarArmasIniciales() {
    armasDelNivel.clear()
    self.agregarArma(espadaEnMapa)
    self.agregarArma(baculoEnMapa)
    self.agregarArma(arcoEnMapa)
  }
}

