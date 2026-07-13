import wollok.game.*
import azar.*

class Recompensa {
  var property position = null

  method image()

  method aplicarEfecto(personaje)

  method esEnemigo() = false

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
  const cantidadDeCuracion = 30

  override method image() = "manzana.png" // placeholder, PENDIENTE: asset final

  override method aplicarEfecto(personaje) {
    personaje.curar(cantidadDeCuracion)
  }
}

class MejoraDeVidaMaxima inherits Recompensa {
  const incremento = 20

  override method image() = "llegada.png" // placeholder, PENDIENTE: asset final

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
    if (azar.ocurreConProbabilidad(probabilidad)) candidatas.anyOne().crear() else sinRecompensa
}

