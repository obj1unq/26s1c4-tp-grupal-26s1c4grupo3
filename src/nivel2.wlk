import wollok.game.*
import personajePrincipal.*
import direcciones.*
import armas.*
import enemigos.*
import mapa.*
import gestorArmas.*
import configuracionJuego.*
import hudArma.*
import nivel3.*

object nivel2 {
  const enemigos = #{}
  const puerta = game.at(12, 22)
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

    enemigos.add(new EnemigoEsqueleto(position = game.at(5, 19), vida = 70, fuerza = 20))
    enemigos.add(new EnemigoEsqueleto(position = game.at(19, 19), vida = 70, fuerza = 20))
    enemigos.add(new EnemigoEsqueleto(position = game.at(9, 21), vida = 70, fuerza = 20))
    enemigos.add(new EnemigoEsqueleto(position = game.at(15, 21), vida = 70, fuerza = 20))
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
    }
  }

  method nivelCompleto() = enemigos.all({ enemigo => !enemigo.estaVivo() })

  method enemigosDelNivel() = enemigos // getter para tests 

  method llegoALaPuerta() = prisionero.position() == puerta

  method moverYTransicionar(direccion) {
    prisionero.mover(direccion)
    if (self.llegoALaPuerta() and self.nivelCompleto()) {
      self.transicionarANivel3()
    }
  }

  method transicionarANivel3() {
    nivel3.iniciar()
  }

  method reiniciar() {
    self.iniciar()
  }
}
