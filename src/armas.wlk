import personajePrincipal.*

class Arma {
  const alcance
  const property poder

  method alcanceDelArma() = alcance

  //method poder() = poderBase

  //method efectoSobre(personaje) = personaje.equiparArma(self)
  // No entendi el uso del mensaje

  method enemigosEnAlcance(personaje) {
    alcance.buscarEnemigos()
    alcance.enemigosEnAlcance()
  }
}


object espada inherits Arma(alcance = alcanceEspada, poder = 10) {

}


class Baculo inherits Arma {


}


class Arco inherits Arma {

}


object sinArma {
  const property alcance = 0
  const property poder = 0
}



object alcanceEspada {
  var property position = game.at(0,0)
  const alcance = new Pair(x = 1, y = 1)

  const property enemigosEnAlcance = []

  method buscarEnemigos(personaje) {
    enemigosEnAlcance.clear()
    position = personaje.position()
    // Hacer un recorrido donde el alcance se pare en una esquina del alcance y la recorra columna por columna
    // La idea es que durante ese movimiento de "alcance" por el tablero vaya haciendo colisiones con enemigos las cuales ejecuten encontrarEnemigo()
  }

  method encontrarEnemigo(enemigo) {
    enemigosEnAlcance.add(enemigo)
  }

  //method aumentarAlcance() {}
}





