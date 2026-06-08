import armas.*
import mapa.*

object personaje {
  var property vida = 100
  var property fuerzaBase = 10
  const inventario = #{}
  var property estado = vivo
  var property arma = sinArma
  var property position = game.at(3, 3)
  
  method inventario() = inventario
  
  method image() = "personaje_frente_128.png"
  
  method puedeMoverseA(unaPosicion) = mapa.estaDentroDelMapa(unaPosicion) && estado.estaVivo()
  
  method mover(direccion) {
    const posicionAnterior = position
    const posicionNueva = direccion.siguiente(posicionAnterior)
    if (self.puedeMoverseA(posicionNueva)) {
      position = posicionNueva
    }
  }

  method poder() = arma.poder() + self.fuerzaBase()

  method equiparArma(unaArma) {
    inventario.add(unaArma)
    arma = unaArma
  }
}

object vivo {
  method estaVivo() = true
}