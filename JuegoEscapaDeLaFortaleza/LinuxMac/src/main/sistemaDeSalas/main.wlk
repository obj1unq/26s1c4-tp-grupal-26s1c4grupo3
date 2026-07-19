import wollok.game.*
import sistemaDeCombate.sistemaDirecciones.*
import sistemaDeCombate.playerCharacter.*
import visuales.hudArma.*
import visuales.menuInicio.*
import visuales.finDeJuego.*
import gestorArmas.*
import configuracionJuego.*
import recompensas.*
import fabricaEnemigos.*
import gestorDeNiveles.*
import sistemaSonido.*

class Puerta {
  const property posicion

  method fueAlcanzadaPor(personaje) = personaje.position() == posicion
}

object sinPuerta {
  method fueAlcanzadaPor(personaje) = true
}

class Sala {
  // Único reloj del juego: la sala tickea y les avisa a los enemigos cuánto tiempo
  // pasó; cada entidad administra sus propios tiempos internos (ej. cooldown del boss).
  const milisegundosPorTick = 600
  const enemigos = #{}
  var combateIniciado = false
  var recompensaActual = sinRecompensa
  var recompensaSpawneada = false

  // Hooks abstractos: cada SalaNivelX define lo que realmente varía por nivel.
  
  method fondo()

  method generadorDeEnemigos()

  method multiplicadorDificultad()

  // Valores compartidos por todas las salas hoy (por ahora, ver diseño); se pueden
  // overridear el día que alguna sala necesite algo distinto.
  method posicionesEnemigos() = [game.at(5, 18), game.at(19, 18), game.at(9, 20), game.at(15, 20), game.at(12, 18)]
  
  method posicionDeAparicion() = game.center()
  
  method orientacionDeAparicion() = abajo
  
  method puerta() = new Puerta(posicion = game.at(12, 21))
  
  method configuracionDeRecompensa() =
    new ConfiguracionDeRecompensa(
      candidatas = [fabricaDePocionDeCuracion, fabricaDeMejoraDeVidaMaxima],
      probabilidad = 30,
      posicion = game.at(12, 16)
    )

  method iniciar() {
    game.clear()
    combateIniciado = false
    recompensaSpawneada = false
    self.configurarMapa()
    self.configurarPersonaje()
    self.configurarEnemigos()
    self.configurarArmas()
    self.agregarVisuales()
    self.configurarTeclado()
    self.configurarComportamientoEnemigos()
    self.iniciarCombateSiCorresponde()
  }

  method configurarMapa() {
    configuracionJuego.aplicarFondo(self.fondo())
  }

  method configurarPersonaje() {
    prisionero.ubicarEn(self.posicionDeAparicion(), self.orientacionDeAparicion())
  }

  method configurarEnemigos() {
    enemigos.clear()
    const nuevosEnemigos = self.generadorDeEnemigos().crear(self.posicionesEnemigos())
    nuevosEnemigos.forEach { enemigo => enemigo.escalarPorDificultad(self.multiplicadorDificultad()) }
    enemigos.addAll(nuevosEnemigos)
  }

  // Hook: la sala regular no reparte armas. Solo SalaInicial lo hace (override).
  method configurarArmas() { }

  // La recompensa aparece recién al completar la sala (ver reaccionarSiSalaCompleta), no al entrar. 
  method intentarSpawnearRecompensa() {
    if (!recompensaSpawneada and self.salaCompleta()) {
      recompensaSpawneada = true
      self.spawnearRecompensa()
    }
  }

  method spawnearRecompensa() {
    const configuracion = self.configuracionDeRecompensa()
    recompensaActual = configuracion.decidirRecompensa()
    recompensaActual.aparecerEn(configuracion.posicion())
  }

  method agregarVisuales() {
    prisionero.aparecer()
    hudArma.aparecer()
  }

  method configurarTeclado() {
    keyboard.up().onPressDo({ self.moverYVerificar(arriba) })
    keyboard.down().onPressDo({ self.moverYVerificar(abajo) })
    keyboard.left().onPressDo({ self.moverYVerificar(izquierda) })
    keyboard.right().onPressDo({ self.moverYVerificar(derecha) })

    keyboard.w().onPressDo({ self.moverYVerificar(arriba) })
    keyboard.s().onPressDo({ self.moverYVerificar(abajo) })
    keyboard.a().onPressDo({ self.moverYVerificar(izquierda) })
    keyboard.d().onPressDo({ self.moverYVerificar(derecha) })

    keyboard.k().onPressDo({ prisionero.atacar() })
    keyboard.space().onPressDo({ prisionero.atacar() })
    keyboard.p().onPressDo({ self.abortarPartida() })
    sistemaSonido.configurarTeclas()
  }

  // Hook: por default el combate arranca directamente (ya hay arma equipada).
  // SalaInicial lo overridea para esperar a que se elija arma.
  method iniciarCombateSiCorresponde() {
    self.iniciarCombate()
  }

  method iniciarCombate() {
    combateIniciado = true
    enemigos.forEach { enemigo => enemigo.aparecer() }
  }

  method configurarComportamientoEnemigos() {
    game.onTick(milisegundosPorTick, "comportamientoDeEnemigos", { self.actuarEnemigos() })
  }

  method actuarEnemigos() {
    if (combateIniciado) {
      enemigos.filter { enemigo => enemigo.estaVivo() }.forEach { enemigo =>
        enemigo.pasarTiempo(milisegundosPorTick)
        enemigo.actuar(prisionero)
      }
      self.reaccionarSiSalaCompleta()
    }
  }

  method salaCompleta() = enemigos.all { enemigo => !enemigo.estaVivo() }

  method enemigosDeLaSala() = enemigos // getter util solo para tests

  method moverYVerificar(direccion) {
    prisionero.mover(direccion)
    self.intentarRecogerRecompensa()
    self.reaccionarSiSalaCompleta()
  }

  method reaccionarSiSalaCompleta() {
    self.intentarSpawnearRecompensa()
    self.intentarAvanzar()
  }

  method intentarRecogerRecompensa() {
    if (recompensaActual.fueRecogidaPor(prisionero)) {
      recompensaActual.aplicarEfecto(prisionero)
      recompensaActual.desaparecer()
      recompensaActual = sinRecompensa
    }
  }

  method puedeAvanzar() = self.salaCompleta() and self.puerta().fueAlcanzadaPor(prisionero)

  method intentarAvanzar() {
    if (self.puedeAvanzar()) {
      gestorDeNiveles.avanzar()
    }
  }

  // mostrar() hace game.clear(), que ya elimina el tick de enemigos junto con el resto de handlers.
  method abortarPartida() {
    menuInicio.mostrar()
  }
}

class SalaNivel1 inherits Sala {
  override method fondo() = "mapas/fondoPrimerNivel.png"
  override method generadorDeEnemigos() = generadorDeEsqueletos
  override method multiplicadorDificultad() = 1
}

class SalaNivel2 inherits Sala {
  override method fondo() = "mapas/fondoSegundoNivel.png"
  override method generadorDeEnemigos() = generadorDeBestias
  override method multiplicadorDificultad() = 1.4
}

class SalaNivel3 inherits Sala {
  override method fondo() = "mapas/fondoTercerNivel.png"
  override method generadorDeEnemigos() = generadorDeReyOscuro
  override method multiplicadorDificultad() = 1.8

  // Última sala antes del jefe: recompensa garantizada (no al azar) para llegar mejor parado.
  override method configuracionDeRecompensa() =
    new ConfiguracionDeRecompensa(
      candidatas = [fabricaDePocionDeCuracionGrande],
      probabilidad = 100,
      posicion = game.at(12, 16)
    )
}

class SalaBoss inherits Sala {

  method posicionDelBoss() = game.at(12, 21)
  override method posicionDeAparicion() = game.at(12, 5)
  override method fondo() = "mapas/fondoTercerNivel.png"
  override method generadorDeEnemigos() = generadorEnemigoFinal
  override method posicionesEnemigos() = [self.posicionDelBoss()]
  override method multiplicadorDificultad() = 1

  // La sala del boss no tiene puerta: al morir el boss se gana directamente.
  override method reaccionarSiSalaCompleta() {
    if (self.salaCompleta()) {
      finDeJuego.mostrarVictoria()
    }
  }
}

class SalaInicial inherits SalaNivel1 {
  override method configurarArmas() {
    gestorArmas.configurarArmasIniciales()
  }

  override method agregarVisuales() {
    super()
    gestorArmas.agregarVisuales()
  }

  override method iniciarCombateSiCorresponde() {
    // No arranca solo: espera ENTER parado sobre un arma (ver elegirArmaYComenzar).
  }

  override method configurarTeclado() {
    super()
    keyboard.enter().onPressDo({ self.elegirArmaYComenzar() })
  }

  method elegirArmaYComenzar() {
    gestorArmas.intentarElegirArma()
    if (gestorArmas.armaYaElegida() and !combateIniciado) {
      self.iniciarCombate()
    }
  }
}
