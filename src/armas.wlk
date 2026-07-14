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

  method archivoSonidoDeAtaque() = ""

  method reproducirSonidoDeAtaque() {
    const sonidoAtaque = game.sound(self.archivoSonidoDeAtaque())

    sonidoAtaque.volume(0.2)
    sonidoAtaque.play()
  }
}

object espada inherits Arma {

  override method poder() = 30

  override method alcance() = new Alcance(ancho = 3, profundidad = 2)

  override method iconoHud() = "inventario\\inventario_espada.png"

  override method stringVestimenta() = "guerrero"

  override method archivoSonidoDeAtaque() = "sonidos\\ataqueEspada.mp3"
}

object baculo inherits Arma {

  override method poder() = 20

  override method alcance() = new Alcance(ancho = 5, profundidad = 5)

  override method iconoHud() = "inventario\\inventario_baculo.png"

  override method stringVestimenta() = "mago"

  override method archivoSonidoDeAtaque() = "sonidos\\ataqueBaculo.mp3"
}

object arco inherits Arma {

  override method poder() = 90

  override method alcance() = new Alcance(ancho = 1, profundidad = 9)

  override method iconoHud() = "inventario\\inventario_arco.png"

  override method stringVestimenta() = "arquero"

  override method archivoSonidoDeAtaque() = "sonidos\\ataqueArco.mp3"

}

object sinArma inherits Arma {

  override method poder() = 0

  override method alcance() = new Alcance(ancho = 1, profundidad = 1)

  override method iconoHud() = "inventario\\inventario_vacio.png"

  override method stringVestimenta() = "personaje"

  override method reproducirSonidoDeAtaque() {
    // Sin arma no reproduce ningún sonido
  }
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

  override method image() = "armas\\espada.png"

  override method arma() = espada
}

object baculoEnMapa inherits ArmaEnMapa (position = game.at(12, 7)) {
  override method image() = "armas\\baculo.png"

  override method arma() = baculo
}

object arcoEnMapa inherits ArmaEnMapa (position = game.at(14, 7)) {

  override method image() = "armas\\arco.png"

  override method arma() = arco

  
}

