import wollok.game.*
import sistemaDeSalas.mapa.*

class Alcance {
  const ancho
  const profundidad

  method radio() = (ancho - 1) / 2

  method enemigosEnAlcance(personaje) = self.objetosEnAlcance(personaje).filter { objeto => objeto.esEnemigo() }

  method posicionesDelAlcance(personaje) {
    const direccion = personaje.orientacionActual()
    const centro = personaje.position()

    return direccion.posicionesHaciaAdelante(centro, profundidad).map { centroDeFila => direccion.posicionesAdyacentes(centroDeFila, self.radio()) }.flatten()
  }

  method posicionesDelAlcanceDentroDelMapa(personaje) = self.posicionesDelAlcance(personaje).filter { posicion => mapa.estaDentroDelMapa(posicion) }

  method objetosEnAlcance(personaje) = self.posicionesDelAlcanceDentroDelMapa(personaje).map { posicion => game.getObjectsIn(posicion) }.flatten()
}
