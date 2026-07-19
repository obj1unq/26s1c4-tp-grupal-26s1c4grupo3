import wollok.game.*
import azar.*
import sistemaDeCombate.objetoDelTablero.*

class Recompensa inherits ObjetoDelTablero {
  var property position = null

  method image()

  method aplicarEfecto(personaje)

  method aparecerEn(unaPosicion) {
    position = unaPosicion
    game.addVisual(self)
  }

  method fueRecogidaPor(personaje) = personaje.position() == position

  method desaparecer() {
    game.removeVisual(self)
  }
}

class PocionDeCuracion inherits Recompensa {
  const property cantidadDeCuracion = 30

  override method image() = "recompensas\\pocionDeCuracion.png"

  override method aplicarEfecto(personaje) {
    personaje.curar(cantidadDeCuracion)
  }
}

class MejoraDeVidaMaxima inherits Recompensa {
  const incremento = 20

  override method image() = "recompensas\\mejoraDeVidaMaxima.png"

  override method aplicarEfecto(personaje) {
    personaje.aumentarVidaMaxima(incremento)
  }
}

object sinRecompensa {
  method fueRecogidaPor(personaje) = false
  method aparecerEn(unaPosicion) { }
  method aplicarEfecto(personaje) { }
  method desaparecer() { }
}

// factory de recompensas
class FabricaDeRecompensa {
  method crear()
}

object fabricaDePocionDeCuracion inherits FabricaDeRecompensa {
  override method crear() = new PocionDeCuracion()
}

object fabricaDePocionDeCuracionGrande inherits FabricaDeRecompensa {
  override method crear() = new PocionDeCuracion(cantidadDeCuracion = 60)
}

object fabricaDeMejoraDeVidaMaxima inherits FabricaDeRecompensa {
  override method crear() = new MejoraDeVidaMaxima()
}


// Consulta pura: decide SI aparece recompensa y CUÁL, sin tocar el mapa.
// Quien orqueste (Sala) es responsable de llamar aparecerEn() como paso aparte.
class ConfiguracionDeRecompensa {
  const candidatas   // lista de FabricaDeRecompensa: [fabricaDePocionDeCuracion, ...]
  const probabilidad // 0..100: chance de que aparezca algo al completar la sala
  const property posicion

  method decidirRecompensa() =
    if (self.hayCandidatas() and azar.ocurreConProbabilidad(probabilidad)) candidatas.anyOne().crear() else sinRecompensa

  method hayCandidatas() = !candidatas.isEmpty()
}

