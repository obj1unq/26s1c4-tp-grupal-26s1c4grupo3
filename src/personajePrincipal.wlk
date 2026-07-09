import wollok.game.*
import armas.*
import mapa.*
import direcciones.*
import hudArma.*
import finDeJuego.*

object prisionero {
  var ubicacion = game.at(12, 3)
  var property vida = 100
  const fuerzaBase = 10
  var arma = sinArma
  var orientacionActual = arriba
  const inventario = #{ }

  method image() = "personaje-" + orientacionActual.stringImage() + ".png"
                                                                  // + arma.stringImage()
                                                                  // No implementado, reemplazado por icono fijo de arma por tiempo.
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

  method estaVivo() = vida > 0

  method poderDeAtaque() = fuerzaBase + arma.poder()

  method recibirAtaque(daño) {
    vida = (vida - daño).max(0)
    if (!self.estaVivo()) {
      finDeJuego.mostrarDerrota()
    }
  }

  method mover(direccion) {
    const posicionNueva = direccion.siguiente(self.position())
    if (self.puedeMoverseA(posicionNueva)) {
      self.position_(posicionNueva)
      self.orientacionActual(direccion)
    }
  }

  method puedeMoverseA(unaPosicion) = mapa.puedePisarse(unaPosicion)

  method obtenerArma(unArma) {
    inventario.add(unArma)
    self.equiparArma(unArma)
  }

  method equiparArma(unaArma) {
    arma = unaArma
    hudArma.actualizar(unaArma)
  }

  method atacar() {
    const enemigos = arma.enemigosEnAlcance(self)
    enemigos.forEach({ enemigo => enemigo.recibirAtaque(self.poderDeAtaque()) })
  }

  method reiniciarEstado() {
    vida = 100
    inventario.clear()
    self.equiparArma(sinArma)
  }

  method ubicarEn(unaPosicion, unaOrientacion) {
    self.position_(unaPosicion)
    self.orientacionActual(unaOrientacion)
  }
}
