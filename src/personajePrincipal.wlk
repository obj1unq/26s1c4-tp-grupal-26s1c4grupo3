import wollok.game.*
import armas.*
import mapa.*
import direcciones.*
import hudArma.*
import finDeJuego.*

object prisionero {
  var property position = game.at(12, 3)
  var property vida = vidaMaxima
  var vidaMaxima = 100
  var orientacionActual = arriba
  var arma = sinArma
  const fuerzaBase = 10

  method image() = "personaje-" + orientacionActual.stringImage() + ".png"

  method esEnemigo() = false

  method orientacionActual() = orientacionActual // Getter solo para test

  method estaVivo() = vida > 0

  method poderDeAtaque() = fuerzaBase + arma.poder()

  method recibirAtaque(daño) {
    vida = (vida - daño).max(0)
    if (!self.estaVivo()) {
      finDeJuego.mostrarDerrota()
    }
  }

  method mover(direccion) {
    const posicionNueva = direccion.siguiente(position)

    if (self.puedeMoverseA(posicionNueva)) self.ubicarEn(posicionNueva, direccion) 
  }

  method ubicarEn(unaPosicion, unaOrientacion) {
    position = unaPosicion
    orientacionActual = unaOrientacion
  }

  method puedeMoverseA(unaPosicion) = mapa.puedePisarse(unaPosicion)

  method equiparArma(unArma) {
    arma = unArma
    hudArma.actualizar(unArma)
  }

  method atacar() {
    const enemigos = arma.enemigosEnAlcance(self)
    enemigos.forEach({ enemigo => enemigo.recibirAtaque(self.poderDeAtaque()) })
  }

  method curar(cantidad) {
    vida = (vida + cantidad).min(vidaMaxima)
  }

  method aumentarVidaMaxima(cantidad) {
    vidaMaxima += cantidad
    vida += cantidad
  }

  method prepararParaNuevaPartida() {
    self.equiparArma(sinArma)
    vidaMaxima = 100
    vida = vidaMaxima
  }

}
