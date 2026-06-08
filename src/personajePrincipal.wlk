import armas.*
import mapa.*
import direcciones.*

object personaje {
  var property position = game.at(3, 3)
  var vida = 100
  var fuerzaBase = 10
  var arma = sinArma
  var property orientacionActual = derecha
  var estado = vivo
  //const property inventario = #{}

  method image() = "personaje-" + orientacionActual.nombre() + ".png"

  //method vida() = vida

  method poderDeAtaque() = fuerzaBase + arma.poder()

  method puedeMoverseA(unaPosicion) = mapa.estaDentroDelMapa(unaPosicion) //&& estado.estaVivo()
	
	method mover(direccion) {
		const posicionNueva = direccion.siguiente(position)
	
  	if (self.puedeMoverseA(posicionNueva)) {
			position = posicionNueva
      orientacionActual = direccion
		}
	}

  method equiparArma(unArma) { arma = unArma }
  
  method atacar() {
    const enemigos = arma.enemigosEnAlcance(self)
    enemigos.forEach({ enemigo => enemigo.recibirAtaque(self.poderDeAtaque()) })
  }


}


object vivo {
  method estaVivo() = true
}
