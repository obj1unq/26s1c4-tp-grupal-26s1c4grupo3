import wollok.game.*
import mapa.*

class Alcance {
  const ancho
  const profundidad

  method ancho() = ancho
  method profundidad() = profundidad
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

object espada {
  const alcance = new Alcance(ancho = 3, profundidad = 2)
  const property poder = 30

  method image() = "espadaNivel1.png"
  //method stringImage() = "" No utilizado aun, explicado en Prisionero.
  method nombre() = "Espada"
  method iconoHud() = "inventario_espada.png" // PENDIENTE: reemplazar por el ícono de HUD final (Nicole)
  method enemigosEnAlcance(personaje) = alcance.enemigosEnAlcance(personaje)
}

object espadaEnMapa {
  var ubicacion = game.at(10, 6)

  method position() = ubicacion
  method position_(nuevaPosicion) {
    ubicacion = nuevaPosicion
  }

  method image() = "espadaNivel1.png"
  method arma() = espada
  method esEnemigo() = false
}

object baculo {
  const alcance = new Alcance(ancho = 5, profundidad = 5)
  const property poder = 20

  method image() = "baculoNivel1.png"
  //method stringImage() = "" No utilizado aun, explicado en Prisionero.
  method nombre() = "Báculo"
  method iconoHud() = "inventario_baculo.png" // PENDIENTE: reemplazar por el ícono de HUD final (Nicole)
  method enemigosEnAlcance(personaje) = alcance.enemigosEnAlcance(personaje)
}

object baculoEnMapa {
  var ubicacion = game.at(12, 6)

  method position() = ubicacion
  method position_(nuevaPosicion) {
    ubicacion = nuevaPosicion
  }

  method image() = "baculoNivel1.png"
  method arma() = baculo
  method esEnemigo() = false
}

object arco {
  const alcance = new Alcance(ancho = 1, profundidad = 9)
  const property poder = 90

  method image() = "arcoNivel1.png"
  //method stringImage() = "" No utilizado aun, explicado en Prisionero.
  method nombre() = "Arco"
  method iconoHud() = "inventario_arco.png" // PENDIENTE: reemplazar por el ícono de HUD final (Nicole)
  method enemigosEnAlcance(personaje) = alcance.enemigosEnAlcance(personaje)
}

object arcoEnMapa {
  var ubicacion = game.at(14, 6)

  method position() = ubicacion
  method position_(nuevaPosicion) {
    ubicacion = nuevaPosicion
  }

  method image() = "arcoNivel1.png"
  method arma() = arco
  method esEnemigo() = false
}

object sinArma {
  const alcance = new Alcance(ancho = 1, profundidad = 1)
  const property poder = 0

  method image() = ""
  //method stringImage() = "" No utilizado aun, explicado en Prisionero.
  method nombre() = "Sin arma"
  method iconoHud() = "inventario_vacio.png" 
  method enemigosEnAlcance(personaje) = alcance.enemigosEnAlcance(personaje)
}
