import wollok.game.*

object sistemaSonido {
  var sonido = null

  method iniciar() {
    sonido = game.sound("sonidos/07FromOlympus.mp3")
    sonido.shouldLoop(true)
    sonido.volume(0.02)
    sonido.play()
  }

  // game.clear() borra todos los handlers de teclado, así que cada pantalla
  // debe re-registrar estas teclas al configurar su propio teclado.
  method configurarTeclas() {
    keyboard.plusKey().onPressDo({ self.subirVolumen() })
    keyboard.minusKey().onPressDo({ self.bajarVolumen() })
  }

  method subirVolumen() {
    sonido.volume((sonido.volume() + 0.1).min(1))
  }

  method bajarVolumen() {
    sonido.volume((sonido.volume() - 0.1).max(0))
  }
}
