import armas.*
import mapa.*

object personaje {
  var property position = game.at(3, 3)
  var vida = 100
  var fuerzaBase = 10
  //var estado = vivo
  var arma = sinArma
  //const property inventario = #{}

  method image() = "personaje_frente_128.png"

  method poderDeAtaque() = fuerzaBase + arma.poder()

  //method vida() = vida

  method puedeMoverseA(unaPosicion) = mapa.estaDentroDelTablero(unaPosicion) //&& estado.estaVivo()
	
	method mover(direccion) {
		const posicionNueva = direccion.siguiente(position)
		if (self.puedeMoverseA(posicionNueva)) {
			position = posicionNueva
		}
	}

  method equiparArma(unArma) {
    //inventario.add(unaArma)
    arma = unArma
  }
  
  method atacar() {
    const enemigos = arma.enemigosEnAlcance(self)
    enemigos.forEach({ enemigo => enemigo.recibirDaño(self.poderDeAtaque()) })
  }

}

object vivo {
  method estaVivo() = true
}
