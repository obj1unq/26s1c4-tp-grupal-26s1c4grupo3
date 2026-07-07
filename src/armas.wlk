//import personajePrincipal.*
import mapa.*
//import wollok.game.*

class Arma {
  const alcance
  const property poder

  method image() 

  //method position()
  // Creo que no vamos a necesitar un metodo position porque cuando elija x arma va a definir un valor de image
  // y en base a ese valor de image va a cambiar la imagen del personaje, 
  // pero no necesariamente el objeto Arma debe existir en el tablero

  //method nombre() 
  // Creo que en ningun momento vamos a necesitar el nombre del arma.

  method enemigosEnAlcance(personaje) = alcance.enemigosEnAlcance(personaje)
  
}

object espada inherits Arma (alcance = new Alcance(ancho = 3, profundidad = 1), poder = 40) {

  override method image() = "espadaSimple.png"

}


object baculo inherits Arma (alcance = new Alcance(ancho = 5, profundidad = 10), poder = 30) {

  override method image() = ""

}


object arco inherits Arma (alcance = new Alcance(ancho = 11, profundidad = 20), poder = 50) {

  override method image() = ""

}

object sinArma inherits Arma (alcance = new Alcance(ancho = 1, profundidad = 1), poder = 0){

  override method image() = ""

}


class Alcance {
  const ancho       // Siempre debe ser impar para no romper el funcionamiento de radio() y el calculo posterior.
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





