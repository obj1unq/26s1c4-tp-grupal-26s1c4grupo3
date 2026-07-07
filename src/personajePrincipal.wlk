import armas.*
import mapa.*
import direcciones.*

object prisionero {
  var property position = game.at(12, 3)
  var vida = 100
  var fuerzaBase = 10
  var arma = sinArma
  var orientacionActual = arriba
  //var estado = vivo
  //const property inventario = #{}

  method image() = "personaje-" + orientacionActual.stringImage() + arma.stringImage() + ".png"

  method orientacionActual() = orientacionActual

  method esEnemigo() = false

  method poderDeAtaque() = fuerzaBase + arma.poder()
	
  method recibirAtaque(daño) {
    vida = (vida - daño).max(0)
  }

	method mover(direccion) {
		const posicionNueva = direccion.siguiente(position)
	
    if (self.puedeMoverseA(posicionNueva)) {
			position = posicionNueva
      orientacionActual = direccion
		}
	}

  method puedeMoverseA(unaPosicion) = mapa.puedePisarse(unaPosicion) //&& estado.estaVivo()

  method obtenerArma(unArma) { arma = unArma }

// Por ahora solo tendra un arma, que es la inicial.

  // method equiparArma(unaArma) { 
  //   if (!inventario.contains(unaArma)) {
  //     self.error("No podes equipar un arma que no tenes")
  //   }
  //   armaEquipada = unaArma
  // } 

  // method encontrarObjeto(objeto) {
  //   if(!self.hayLugar()){ 
  //     //Lo dejo por si hay alguna limitacion en inventario
  //     self.error("No tengo lugar en inventario!")
  //     self.obtenerObjeto(objeto)
  //   }
  // }
  
  method atacar() {
    const enemigos = arma.enemigosEnAlcance(self)
    enemigos.forEach({ enemigo => enemigo.recibirAtaque(self.poderDeAtaque()) })
  }

}


object vivo {
  method estaVivo() = true
}
