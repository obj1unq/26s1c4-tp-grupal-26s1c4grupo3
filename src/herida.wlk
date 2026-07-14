import wollok.game.*

class MarcaHerida {
  const objetivo

  method position() = objetivo.position()

  method image() = "heridaSangrado.png"

  method esEnemigo() = false
}

object gestorHeridas {
  var marcaActual = null

  method mostrarEn(objetivo) {
    self.eliminarHeridaAnterior()

    marcaActual = new MarcaHerida(objetivo = objetivo)
    game.addVisual(marcaActual)

    game.onTick(500, "quitarHerida", {
      self.ocultarHerida()
    })
  }

  method eliminarHeridaAnterior() {
    if (marcaActual != null) {
      game.removeVisual(marcaActual)
      game.removeTickEvent("quitarHerida")
    }
  }

  method ocultarHerida() {
    game.removeVisual(marcaActual)
    marcaActual = null
    game.removeTickEvent("quitarHerida") //Como onTick es un evento repetitivo, hay que eliminarlo. De lo contrario, intentaría ejecutar ocultarHerida() nuevamente cada 500 milisegundos.
  }
}