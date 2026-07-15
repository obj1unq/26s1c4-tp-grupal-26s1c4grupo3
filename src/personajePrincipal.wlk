import wollok.game.*
import armas.*
import mapa.*
import direcciones.*
import hudArma.*
import finDeJuego.*
import serVivo.*

object prisionero inherits SerVivo (position = game.center(), vida = 100) {
  var vidaMaxima = 100
  var arma = sinArma
  const fuerzaBase = 10

  override method image() = "personaje\\" + arma.stringVestimenta() + "-" + orientacionActual.stringImage() + ".png"

  method poderDeAtaque() = fuerzaBase + arma.poder()

  override method morir() {
    finDeJuego.mostrarDerrota()
  }

  method mover(direccion) {
    const posicionNueva = direccion.siguiente(position)

    if (self.puedeMoverseA(posicionNueva)) self.ubicarEn(posicionNueva, direccion) 
  }

  method ubicarEn(unaPosicion, unaOrientacion) {
    self.moverA(unaPosicion)
    self.orientarA(unaOrientacion)
  }

  method puedeMoverseA(unaPosicion) = mapa.puedePisarse(unaPosicion)

  method equiparArma(unArma) {
    arma = unArma
    hudArma.actualizar(unArma)
  }

  method atacar() {
    const enemigos = arma.enemigosEnAlcance(self)
    enemigos.forEach({ enemigo => enemigo.recibirAtaque(self.poderDeAtaque()) })

    arma.reproducirSonidoDeAtaque()
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
