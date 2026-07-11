import wollok.game.*
import personajePrincipal.*
import direcciones.*
import gestorArmas.*
import configuracionJuego.*
import hudArma.*
import finDeJuego.*
import fabricaEnemigos.*

object nivel3 {
  const enemigos = #{}
  var combateIniciado = false

  method iniciar() {
    game.clear()
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
    configuracionJuego.aplicarFondo("fondoTercerMapa.png")
  }

  method configurarPersonaje() {
    prisionero.prepararParaNivel()
    prisionero.ubicarEn(game.at(12, 4), arriba)
  }

  method configurarEnemigos() {
    enemigos.clear()

    const enemigosDelNivel = fabricaEnemigos.crearEsqueletos(self.posicionesEnemigos(), self.vidaEnemigos(), self.fuerzaEnemigos())
    enemigosDelNivel.forEach({ enemigo => enemigos.add(enemigo) })
  }

  method posicionesEnemigos() = [game.at(5, 18), game.at(19, 18), game.at(9, 20), game.at(15, 20), game.at(12, 20)]

  method vidaEnemigos() = 90

  method fuerzaEnemigos() = 25

  method configurarArmas() {
    gestorArmas.configurarArmasIniciales()
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
    prisionero.reiniciarVida()
    self.iniciar()
  }
}
