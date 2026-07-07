import armas.*
import mapa.*
import direcciones.*

object personaje {
  var property position = game.at(17, 20)
  var vida = 100
  var fuerzaBase = 10
  const property inventario = #{}
  var armaEquipada = sinArma
  var orientacionActual = arriba
  var estado = vivo

  method image() = "personaje-" + orientacionActual.stringImage() + ".png"
                                                      // + self.imagenSegunArma() 

  //method imagenSegunArma() = armaEquipada.imageActual()

  method esEnemigo() = false

  method poderDeAtaque() = fuerzaBase + armaEquipada.poder()

  method puedeMoverseA(unaPosicion) = mapa.puedePisarse(unaPosicion) //&& estado.estaVivo()
	
	method mover(direccion) {
		const posicionNueva = direccion.siguiente(position)
	
    if (self.puedeMoverseA(posicionNueva)) {
			position = posicionNueva
      orientacionActual = direccion
		}
	}

  method equiparArma(unaArma) { 
    if (!inventario.contains(unaArma)) {
      self.error("No podes equipar un arma que no tenes")
    }

    armaEquipada = unaArma
  }

  // method obtener(arma) {
  //   inventario.add(arma)
  // }
 
  // method encontrarObjeto(arma) {
  //   if(!self.hayLugar()){ 
  //     //Lo dejo por si hay alguna limitacion en inventario
  //     self.error("No tengo lugar en inventario!")
  //     self.obtenerArma(arma)
  //   }
  // }
  
  method atacar() {
    const enemigos = armaEquipada.enemigosEnAlcance(self)
    enemigos.forEach({ enemigo => enemigo.recibirAtaque(self.poderDeAtaque()) })
  }

  method recibirAtaque(daño) {
    vida -= daño.max(0)
  }


}


object vivo {
  method estaVivo() = true
}
