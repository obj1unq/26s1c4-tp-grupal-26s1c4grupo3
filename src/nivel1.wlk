import wollok.game.*
import personajePrincipal.*
import direcciones.*
import armas.*
import enemigo.*
import mapa.*
import gestorArmas.*
import configuracionJuego.*
import nivel2.*

object nivel1 {
  const enemigos = #{}
  const puerta = game.at(22, 4)

  method iniciar() {
    if (!game.running()) {
      self.configurarMapa()
    }

    self.configurarPersonaje()
    self.configurarEnemigos()
    self.configurarArmas()
    self.agregarVisuales()
    self.configurarTeclado()
  }

  method configurarMapa() {
    configuracionJuego.iniciar()
    configuracionJuego.aplicarFondo("fondoPrimerMapa.png")
  }

  method configurarPersonaje() {
    prisionero.position_(game.at(12, 4))
    prisionero.orientacionActual(arriba)
    prisionero.inventario().clear()
    prisionero.armaEquipada(sinArma)
  }

  method configurarEnemigos() {
    enemigos.clear()

    enemigos.add(self.crearEnemigo(5, 5, 50, 15))
    enemigos.add(self.crearEnemigo(19, 5, 50, 15))
    enemigos.add(self.crearEnemigo(5, 18, 50, 15))
    enemigos.add(self.crearEnemigo(19, 18, 50, 15))
    enemigos.add(self.crearEnemigo(12, 12, 50, 15))
  }

  method crearEnemigo(x, y, vida, fuerza) {
    const enemigo = new EnemigoEsqueleto()
    enemigo.position_(game.at(x, y))
    enemigo.vida(vida)
    enemigo.fuerza(fuerza)
    return enemigo
  }

  method configurarArmas() {
    gestorArmas.iniciar()

    gestorArmas.agregarArma(espadaEnMapa, game.at(10, 6))
    gestorArmas.agregarArma(baculoEnMapa, game.at(12, 6))
    gestorArmas.agregarArma(arcoEnMapa, game.at(14, 6))
  }

  method agregarVisuales() {
    game.addVisual(prisionero)

    enemigos.forEach({ enemigo =>
      game.addVisual(enemigo)
    })

    gestorArmas.agregarVisuales()
  }

  method configurarTeclado() {
    keyboard.up().onPressDo({ self.moverYTransicionar(arriba) })
    keyboard.down().onPressDo({ self.moverYTransicionar(abajo) })
    keyboard.left().onPressDo({ self.moverYTransicionar(izquierda) })
    keyboard.right().onPressDo({ self.moverYTransicionar(derecha) })

    keyboard.w().onPressDo({ self.moverYTransicionar(arriba) })
    keyboard.s().onPressDo({ self.moverYTransicionar(abajo) })
    keyboard.a().onPressDo({ self.moverYTransicionar(izquierda) })
    keyboard.d().onPressDo({ self.moverYTransicionar(derecha) })

    keyboard.k().onPressDo({ prisionero.atacar() })
    keyboard.r().onPressDo({ self.reiniciar() })
    keyboard.enter().onPressDo({ gestorArmas.intentarElegirArma() })
  }

  method moverYTransicionar(direccion) {
    prisionero.mover(direccion)
    if (prisionero.position() == puerta.position()) {
      game.clear()
      nivel2.iniciar()
    }
  }

  method reiniciar() {
    game.clear()
    self.iniciar()
  }
}
