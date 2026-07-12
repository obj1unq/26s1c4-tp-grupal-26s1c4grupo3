import sala.*
import personajePrincipal.*
import nivelBoss.*

object gestorDeNiveles {
  const secuenciaDeSalas = [
    new SalaInicial(),
    new SalaNivel1(),
    new SalaNivel2(),
    new SalaNivel2(),
    new SalaNivel3(),
    new SalaNivel3()
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
      nivelBoss.iniciar()
    }
  }
}
