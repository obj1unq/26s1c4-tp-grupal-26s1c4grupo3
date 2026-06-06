import armas.*
import mapa.*

object personaje {
  var property vida = 100
  var property fuerzaBase = 10
  const inventario = #{}
  var property estado = vivo
  var property arma = sinArma

  method inventario() = inventario
  
  var property position = game.at(3, 3)

  method fuerzaBase() = fuerzaBase

  method vida() = vida

  method image() = "personaje_frente_128.png"

  method puedeMoverseA(unaPosicion) = mapa.estaDentroDelTablero(unaPosicion) && estado.estaVivo()
	
	method mover(direccion) {
		const posicionAnterior = position
		const posicionNueva = direccion.siguiente(posicionAnterior)
		if (self.puedeMoverseA(posicionNueva)) {
			position = posicionNueva
		}
	}
  method equiparArma(unaArma) {
    inventario.add(unaArma)
    arma = unaArma
  }
  
}

object vivo {
  method estaVivo() = true
}
