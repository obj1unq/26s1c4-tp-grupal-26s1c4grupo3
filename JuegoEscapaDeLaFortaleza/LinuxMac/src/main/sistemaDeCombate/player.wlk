import wollok.game.*
import sistemaDirecciones.*
import herida.*

class Player {
  var position
  var property vida
  var herida = sinHerida
  var orientacionActual = abajo

  method position() = position

  method orientacionActual() = orientacionActual

  method aparecer() {
    game.addVisual(self)
  }

  method moverA(unaPosicion) {
    position = unaPosicion
  }

  method orientarA(unaDireccion) {
    orientacionActual = unaDireccion
  }

  method image()

  method esEnemigo() = false

  method estaVivo() = vida > 0

  method recibirAtaque(daño) {
    vida = (vida - daño).max(0)
    self.recibirHerida()
    if (!self.estaVivo()) {
      self.morir()
    }
  }

  method morir()

  method recibirHerida() {
    herida.ocultar() // si golpean de nuevo antes de los 500ms, hay que sacar la marca anterior antes de perder su referencia
    herida = new MarcaHerida(objetivo = self)
    game.addVisual(herida)
    game.schedule(500, { self.ocultarHerida() })
  }

  method ocultarHerida() {
    herida.ocultar()
    herida = sinHerida
  }
}
