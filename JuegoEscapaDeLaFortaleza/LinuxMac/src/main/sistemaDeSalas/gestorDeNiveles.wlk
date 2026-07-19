import main.*
import sistemaDeCombate.playerCharacter.*
import visuales.finDeJuego.*

object gestorDeNiveles {
  const secuenciaDeSalas = [
    new SalaInicial(),
    new SalaNivel2(),
    new SalaNivel3(),
    new SalaBoss()
  ]

  var indiceActual = 0

  method salaActual() = secuenciaDeSalas.get(indiceActual)

  method iniciarPartida() {
    indiceActual = 0
    prisionero.prepararParaNuevaPartida()
    self.salaActual().iniciar()
  }

  method haySiguienteSala() = indiceActual < secuenciaDeSalas.size() - 1

  method avanzar() {
    if (self.haySiguienteSala()) {
      indiceActual += 1
      self.salaActual().iniciar()
    } else {
      // Sin salas pendientes, el juego está ganado (hoy la SalaBoss lo resuelve
      // sola al morir el boss, pero el gestor mantiene la semántica completa).
      finDeJuego.mostrarVictoria()
    }
  }
}
