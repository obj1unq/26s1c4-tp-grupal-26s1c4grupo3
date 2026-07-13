import wollok.game.*
import mapa.*

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

class Arma {

  method poder()

  method alcance()

  method iconoHud()

  method enemigosEnAlcance(personaje) = self.alcance().enemigosEnAlcance(personaje)

  method stringVestimenta()
}

object espada inherits Arma {

  override method poder() = 30

  override method alcance() = new Alcance(ancho = 3, profundidad = 2)

  override method iconoHud() = "inventario_espada.png"

  override method stringVestimenta() = "guerrero"
}

object baculo inherits Arma {

  override method poder() = 20

  override method alcance() = new Alcance(ancho = 5, profundidad = 5)

  override method iconoHud() = "inventario_baculo.png"

  override method stringVestimenta() = "mago"
}

object arco inherits Arma {

  override method poder() = 90

  override method alcance() = new Alcance(ancho = 1, profundidad = 9)

  override method iconoHud() = "inventario_arco.png"

  override method stringVestimenta() = "arquero"
}

object sinArma inherits Arma {

  override method poder() = 0

  override method alcance() = new Alcance(ancho = 1, profundidad = 1)

  override method iconoHud() = "inventario_vacio.png"

  override method stringVestimenta() = "personaje"
}


// Armas en mapa

class ArmaEnMapa {
  var property position 

  method image()

  method arma()

  method esEnemigo() = false

  method aparecer() {
    game.addVisual(self)
  }
  method desaparecer() {
    game.removeVisual(self)
  }
}

object espadaEnMapa inherits ArmaEnMapa (position = game.at(10, 7)) {

  override method image() = "espada.png"

  override method arma() = espada
}

object baculoEnMapa inherits ArmaEnMapa (position = game.at(12, 7)) {
  override method image() = "baculo.png"

  override method arma() = baculo
}

object arcoEnMapa inherits ArmaEnMapa (position = game.at(14, 7)) {

  override method image() = "arco.png"

  override method arma() = arco

  
}

