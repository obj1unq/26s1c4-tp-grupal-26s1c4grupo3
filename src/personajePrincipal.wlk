import armas.*
import mapa.*
import direcciones.*

object personaje {
  var property position = game.at(3, 3)
  var vida = 100
  var fuerzaBase = 10
  var arma = sinArma
  var orientacionActual = derecha
  //const property inventario = #{}
  //var estado = vivo
  // Atributos comentados por no haber sido requeridos por ahora.

  method image() = "personaje_frente_128.png"

  method poderDeAtaque() = fuerzaBase + arma.poder()

  //method vida() = vida

  method puedeMoverseA(unaPosicion) = mapa.estaDentroDelTablero(unaPosicion) //&& estado.estaVivo()
	
	method mover(direccion) {
		const posicionNueva = direccion.siguiente(position)
	
  	if (self.puedeMoverseA(posicionNueva)) {
			position = posicionNueva
      orientacionActual = direccion
		}
	}

  method orientacionActual() = orientacionActual

  method equiparArma(unArma) { arma = unArma }
  
  method atacar() {
    const enemigos = arma.enemigosEnAlcance(self)
    enemigos.forEach({ enemigo => enemigo.recibirAtaque(self.poderDeAtaque()) })
  }

}


// object vivo {
//   method estaVivo() = true
// }
