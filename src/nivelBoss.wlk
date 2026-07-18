import finDeJuego.*
import sala.*
import fabricaEnemigos.*

class SalaBoss inherits Sala {

  method posicionDelBoss() = game.center()
  override method fondo() = "mapas\\fondoTercerNivel.png"
  override method generadorDeEnemigos() = generadorEnemigoFinal
  override method posicionesEnemigos() = [self.posicionDelBoss()]
  override method multiplicadorDificultad() = 1

  override method reaccionarSiSalaCompleta() {
    if (self.salaCompleta()) {
      finDeJuego.mostrarVictoria()
    }
  }
}

object nivelBoss {
  const property sala = new SalaBoss()

  method iniciar() {
    sala.iniciar()
  }
}
