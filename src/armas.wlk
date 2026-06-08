import personajePrincipal.*
import mapa.*

class Arma {
  const alcance
  const property poder

  //method alcanceDelArma() = alcance

  //method poder() = poderBase

  //method efectoSobre(personaje) = personaje.equiparArma(self)
  // No entendi el uso del mensaje

  method enemigosEnAlcance(personaje) {
    alcance.buscarEnemigos(personaje)
    return alcance.enemigosEnAlcance()
    // Wollok me obliga a poner el return para devolver la lista que "alcance.buscarEnemigos" modifica
    // Deberia acomodar de otra forma el codigo para no tener un metodo de orden y despues uno de consulta? O no es necesario ya que son subtareas?
  }
}

  override method alcanceDelArma() = 1

  override method poder() = 10
}

object espadaSimple inherits Espada { 
  
  override method nombre() = "Espada Simple"

  override method image() = "espadaSimple.png"

  override method poder() = super().poder() + 5

  override  method position() = game.center()

object espada inherits Arma(alcance = alcanceEspada, poder = 10) {

}


class Baculo inherits Arma {


}


class Arco inherits Arma {

}


object sinArma inherits Arma (alcance = alcanceSinArma, poder = 0){

}

// La idea de este objeto, ademas de hacer funcional el juego sin armas o sin el arma equipada, es definir si "alcance" puede ser una clase de la cual hereden los distintos tipos de alcance que habran.
object alcanceSinArma {
  var property position = game.at(0,0)
  const alcance = 1
  const property enemigosEnAlcance = []

  method buscarEnemigos(personaje) {
    enemigosEnAlcance.clear()
    position = personaje.position()
    self.buscarEnAlcance(personaje.orientacionActual())
  }

  method encontrarEnemigo(enemigo) {
    enemigosEnAlcance.add(enemigo)
  }

  method buscarEnAlcance(direccion) {
    alcance.times({ i => self.mover(direccion) })
  }

	method mover(direccion) {
		const posicionNueva = direccion.siguiente(position)
		if (mapa.estaDentroDelTablero(posicionNueva)) {
			position = posicionNueva
		}
	}
}



object alcanceEspada {
  var property position = game.at(0,0)
  const alcance = 1
  // primer prototipo sera solo dañar en linea recta, sin poder agregarle ancho al alcance
  const property enemigosEnAlcance = []

  method buscarEnemigos(personaje) {
    enemigosEnAlcance.clear()
    position = personaje.position()
    self.buscarEnAlcance(personaje.orientacionActual())
    // Hacer un recorrido donde el alcance se pare en una esquina del alcance y la recorra columna por columna
    // La idea es que durante ese movimiento de "alcance" por el tablero vaya haciendo colisiones con enemigos las cuales ejecuten encontrarEnemigo()
  }

  method encontrarEnemigo(enemigo) {
    enemigosEnAlcance.add(enemigo)
  }

  method buscarEnAlcance(direccion) {
    alcance.times({ i => self.mover(direccion) })
  }

  // Para que pueda contemplar un alcance tanto en largo como en ancho, podria utilizar times 2 veces
  // Un primer times, que evalua el alcance en ancho, Alcance se mueve a la primer columna de la izquierda y la verifica de abajo hacia arriba con un time que solo evalua columnas
  // Luego de terminar la columna, pasa a la siguiente fila hacia la derecha y vuelve a repetir ese time que evalua de abajo hacia arriba.
  // Una vez terminado el times principal, va a haber verificado todo el alcance.

	method mover(direccion) {
		const posicionNueva = direccion.siguiente(position)
		if (mapa.estaDentroDelTablero(posicionNueva)) {
			position = posicionNueva
		}
	}

  //method puedeMoverseA(unaPosicion) = mapa.estaDentroDelTablero(unaPosicion) 

  //method aumentarAlcance() {}
}





