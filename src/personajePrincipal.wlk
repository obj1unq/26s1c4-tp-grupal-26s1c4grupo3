import wollok.game.*
import armas.*
import mapa.*
import direcciones.*

object prisionero {
  var ubicacion = game.at(12, 3)
  var vida = 100
  var fuerzaBase = 10
  var arma = sinArma
  var orientacionActual = arriba
  const inventario = #{ }
  var property armaEquipada = sinArma
  //var estado = vivo
  //const property inventario = #{}

  method image() = "personaje-" + orientacionActual.stringImage() + arma.stringImage() + ".png"

  method position() = ubicacion
  method position_(nuevaPosicion) {
    ubicacion = nuevaPosicion
  }

  method orientacionActual() = orientacionActual

  method orientacionActual(nuevaOrientacion) {
    orientacionActual = nuevaOrientacion
  }

  method inventario() = inventario

  method esEnemigo() = false

  method poderDeAtaque() = fuerzaBase + arma.poder()
	
  method recibirAtaque(daño) {
    vida = (vida - daño).max(0)
  }

	method mover(direccion) {
		const posicionNueva = direccion.siguiente(self.position())
	
    if (self.puedeMoverseA(posicionNueva)) {
			self.position_(posicionNueva)
      self.orientacionActual(direccion)
		}
	}

  method puedeMoverseA(unaPosicion) = mapa.puedePisarse(unaPosicion) //&& estado.estaVivo()

  method obtenerArma(unArma) {
    inventario.add(unArma)
    self.equiparArma(unArma)
  }

  method equiparArma(unaArma) {
    arma = unaArma
    armaEquipada = unaArma
  }

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
