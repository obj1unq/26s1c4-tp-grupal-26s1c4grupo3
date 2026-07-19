import visuales.finDeJuego.*
import sistemaDeSalas.main.*
import fabricaEnemigos.*

class SalaBoss inherits Sala {

  method posicionDelBoss() = game.at(12, 21)
  override method posicionDeAparicion() = game.at(12, 5)
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
