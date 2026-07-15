import wollok.game.*
import herida.*

class SerVivo {
  var position
  var property vida
  var herida = sinHerida

  method position() = position

  method moverA(unaPosicion) {
    position = unaPosicion
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
