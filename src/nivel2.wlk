import wollok.game.*
import personajePrincipal.*
import direcciones.*
import armas.*
import enemigo.*
import mapa.*
import gestorArmas.*
import configuracionJuego.*

object nivel2 {
  const enemigos = #{}

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
    configuracionJuego.aplicarFondo("fondoSegundoMapa.png")
  }

  method configurarPersonaje() {
    prisionero.position_(game.at(12, 4))
    prisionero.orientacionActual(arriba)
    prisionero.inventario().clear()
    prisionero.armaEquipada(sinArma)
  }

  method configurarEnemigos() {
    enemigos.clear()

    enemigos.add(self.crearEnemigo(5, 5, 70, 20))
    enemigos.add(self.crearEnemigo(19, 5, 70, 20))
    enemigos.add(self.crearEnemigo(5, 18, 70, 20))
    enemigos.add(self.crearEnemigo(19, 18, 70, 20))
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
    keyboard.up().onPressDo({ prisionero.mover(arriba) })
    keyboard.down().onPressDo({ prisionero.mover(abajo) })
    keyboard.left().onPressDo({ prisionero.mover(izquierda) })
    keyboard.right().onPressDo({ prisionero.mover(derecha) })

    keyboard.w().onPressDo({ prisionero.mover(arriba) })
    keyboard.s().onPressDo({ prisionero.mover(abajo) })
    keyboard.a().onPressDo({ prisionero.mover(izquierda) })
    keyboard.d().onPressDo({ prisionero.mover(derecha) })

    keyboard.k().onPressDo({ prisionero.atacar() })
    keyboard.r().onPressDo({ self.reiniciar() })
    keyboard.enter().onPressDo({ gestorArmas.intentarElegirArma() })
  }

  method reiniciar() {
    game.clear()
    self.iniciar()
  }
}
