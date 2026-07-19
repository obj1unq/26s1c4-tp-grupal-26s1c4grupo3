import wollok.game.*

object sistemaSonido {
  var sonido = null

  method iniciar() {
    sonido = game.sound("sonidos/07FromOlympus.mp3")
    sonido.shouldLoop(true)
    sonido.volume(0.02)
    sonido.play()
  }

  method subirVolumen() {
    sonido.volume((sonido.volume() + 0.1).min(1))
  }

  method bajarVolumen() {
    sonido.volume((sonido.volume() - 0.1).max(0))
  }
}
