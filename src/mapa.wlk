
object mapa {

  method estaBloqueada(posicion) =
  posicion.x() <= 2 ||
  posicion.x() >= 22 ||
  posicion.y() <= 2 ||
  posicion.y() >= 22

  method estaDentroDelMapa(posicion) =
    posicion.x() >= 0 && posicion.x() < game.width() &&
    posicion.y() >= 0 && posicion.y() < game.height()

  method puedePisarse(posicion) =
    self.estaDentroDelMapa(posicion) &&
    !self.estaBloqueada(posicion)
}
