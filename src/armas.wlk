import personajePrincipal.*
import mapa.*

class Arma {
  const alcance
  const property poder

  method image() 

  method position()

  method nombre() 

  method enemigosEnAlcance(personaje) {
    alcance.buscarEnemigos(personaje)
    return alcance.enemigosEnAlcance()
    // Wollok me obliga a poner el return para devolver la lista que "alcance.buscarEnemigos" modifica
    // Deberia acomodar de otra forma el codigo para no tener un metodo de orden y despues uno de consulta? O no es necesario ya que son subtareas?
  }
}

object espada inherits Arma (alcance = alcanceEspada, poder = 10) {

  override method nombre() = "Espada"

  override method image() = "espadaSimple.png"

  override method position() = game.center()
}


object baculo inherits Arma (alcance = alcanceBaculo, poder = 10) {

  override method nombre() = "Baculo"

  override method image() = ""

  override method position() = game.center()

}


object arco inherits Arma (alcance = alcanceArco, poder = 50) {

  override method nombre() = "Arco"

  override method image() = ""

  override method position() = game.center()

}

object sinArma inherits Arma (alcance = alcanceSinArma, poder = 0){
  
  override method nombre() = "Sin Arma"

  override method image() = ""

  override method position() = game.center()
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
		if (mapa.estaDentroDelMapa(posicionNueva)) {
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
    //alcance.times({ i => self.mover(direccion) })
  }

  // AYUDA DE NICO:
  
  // Para que pueda contemplar un alcance tanto en largo como en ancho, podria utilizar times 2 veces
  // Un primer times, que evalua el alcance en ancho, Alcance se mueve a la primer columna de la izquierda y la verifica de abajo hacia arriba con un time que solo evalua columnas
  // Luego de terminar la columna, pasa a la siguiente fila hacia la derecha y vuelve a repetir ese time que evalua de abajo hacia arriba.
  // Una vez terminado el times principal, va a haber verificado todo el alcance.

  // Recorrer las posiciones con este metodo y preguntarle al juego si hay o no un objeto con esta posicion
  // getObjectsIn(position), devuelve una coleccion
  
  // Definir rango (x,y), do, doble for each o map
  // Primer metodo que obtiene los objetos de todas las posiciones del rango con getObjectsIn, flatten para unirlos y despues foreach para afectar el daño.
  // Todos los objetos que pueda detectar tienen que entender el mensaje recibir daño, osea ser polimorfico
  // aquellos objetos que no sean enemigos o los que correspondan recibir daño, no haran nada, pero seran polimorficos para evitar ifs


  // 2da opcion Poco probable q funcione:
  // Generar N objetos alcance que todos se crean y todos generan colisiones al mismo tiempo, generando muchos objetos en varias posiciones a la vez



	// method mover(direccion) {
	// 	const posicionNueva = direccion.siguiente(position)
	// 	if (mapa.estaDentroDelMapa(posicionNueva)) {
	// 		position = posicionNueva
	// 	}
	// }

  //method puedeMoverseA(unaPosicion) = mapa.estaDentroDelMapa(unaPosicion) 

  //method aumentarAlcance() {}
}


object alcanceArco {

}

object alcanceBaculo {

}




