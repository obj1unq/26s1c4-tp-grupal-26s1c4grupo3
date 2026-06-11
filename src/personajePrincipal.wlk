import armas.*
import mapa.*
import direcciones.*

object personaje {
  var property position = game.at(3, 3)
  var vida = 100
  var fuerzaBase = 10
  var inventario = #{}
  var property armaEquipada = sinArma
  var property orientacionActual = derecha
  var estado = vivo
  
  method inventario() = inventario

  method image() = "personaje-" + orientacionActual.nombre() + ".png"
                                                      // + self.imagenSegunArma() 

  //method imagenSegunArma() = armaEquipada.imageActual()

  method poderDeAtaque() = fuerzaBase + armaEquipada.poder()

  method puedeMoverseA(unaPosicion) = mapa.estaDentroDelMapa(unaPosicion) //&& estado.estaVivo()
	
	method mover(direccion) {
		const posicionNueva = direccion.siguiente(position)
	
  	if (self.puedeMoverseA(posicionNueva)) {
			position = posicionNueva
      orientacionActual = direccion
		}
	}

  method equiparArma(arma) { 
    armaEquipada = arma
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


}


object vivo {
  method estaVivo() = true
}
