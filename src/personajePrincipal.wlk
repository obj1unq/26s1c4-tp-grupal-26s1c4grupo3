import armas.*
import mapa.*

object personaje {
  var property vida = 100
  var property fuerzaBase = 10
  const inventario = #{}
  var property estado = vivo
  var property arma = sinArma
  var property image = "personaje-frente_128.png"

  method inventario() = inventario
  
  var property position = game.at(3, 3)

  method fuerzaBase() = fuerzaBase

  method vida() = vida

  method puedeMoverseA(unaPosicion) = mapa.estaDentroDelTablero(unaPosicion) && estado.estaVivo()
	
	method mover(direccion) {
		const posicionAnterior = position
		const posicionNueva = direccion.siguiente(posicionAnterior)
		if (self.puedeMoverseA(posicionNueva)) {
			position = posicionNueva
      self.cambiarImagen(direccion)
		}
	}
  method equiparArma(unaArma) {
    inventario.add(unaArma)
    arma = unaArma
  }
  
  method cambiarImagen(direccion) {
    image = ("personaje-" + direccion.orientacion()) + ".png"
  }
  


}

object vivo {
  method estaVivo() = true
}