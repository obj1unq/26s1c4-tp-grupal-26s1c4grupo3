import wollok.game.*
import personajePrincipal.*
import direcciones.*
import armas.*
import enemigos.*
import mapa.*
import gestorArmas.*
import configuracionJuego.*
import hudArma.*
import finDeJuego.*

object nivel3 {
  const enemigos = #{}
  var combateIniciado = false

  method iniciar() {
    combateIniciado = false
    self.configurarMapa()
    self.configurarPersonaje()
    self.configurarEnemigos()
    self.configurarArmas()
    self.agregarVisuales()
    self.configurarTeclado()
    self.configurarComportamientoEnemigos()
  }

  method configurarMapa() {
    configuracionJuego.aplicarFondo("fondoSegundoMapa.png") // PENDIENTE: crear un fondo propio para el nivel 3
  }

  method configurarPersonaje() {
    prisionero.position_(game.at(12, 4))
    prisionero.orientacionActual(arriba)
    prisionero.inventario().clear()
    prisionero.armaEquipada(sinArma)
  }

  method configurarEnemigos() {
    enemigos.clear()

    enemigos.add(new EnemigoEsqueleto(position = game.at(5, 18), vida = 90, fuerza = 25))
    enemigos.add(new EnemigoEsqueleto(position = game.at(19, 18), vida = 90, fuerza = 25))
    enemigos.add(new EnemigoEsqueleto(position = game.at(9, 20), vida = 90, fuerza = 25))
    enemigos.add(new EnemigoEsqueleto(position = game.at(15, 20), vida = 90, fuerza = 25))
    enemigos.add(new EnemigoEsqueleto(position = game.at(12, 20), vida = 90, fuerza = 25))
  }

  method configurarArmas() {
    gestorArmas.iniciar()

    gestorArmas.agregarArma(espadaEnMapa, game.at(10, 6))
    gestorArmas.agregarArma(baculoEnMapa, game.at(12, 6))
    gestorArmas.agregarArma(arcoEnMapa, game.at(14, 6))
  }

  method agregarVisuales() {
    game.addVisual(prisionero)
    game.addVisual(hudArma)
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
    keyboard.enter().onPressDo({ self.elegirArmaYComenzar() })
  }

  method elegirArmaYComenzar() {
    gestorArmas.intentarElegirArma()
    if (gestorArmas.armaYaElegida() and !combateIniciado) {
      self.iniciarCombate()
    }
  }

  method iniciarCombate() {
    combateIniciado = true
    enemigos.forEach({ enemigo => game.addVisual(enemigo) })
  }

  method configurarComportamientoEnemigos() {
    game.onTick(700, "comportamientoDeEnemigos", { self.actuarEnemigos() })
  }

  method actuarEnemigos() {
    if (combateIniciado) {
      enemigos.filter({ enemigo => enemigo.estaVivo() }).forEach({ enemigo => enemigo.actuar(prisionero) })
      if (self.nivelCompleto()) {
        finDeJuego.mostrarVictoria()
      }
    }
  }

  method nivelCompleto() = enemigos.all({ enemigo => !enemigo.estaVivo() })

  method enemigosDelNivel() = enemigos // getter para tests

  method reiniciar() {
    game.clear()
    self.iniciar()
  }
}
