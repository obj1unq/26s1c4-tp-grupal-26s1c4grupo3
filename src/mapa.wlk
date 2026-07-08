
object mapa {

  method estaBloqueada(posicion) =
  posicion.x() <= 0 ||
  posicion.x() >= 24 ||
  posicion.y() <= 0 ||
  posicion.y() >= 24

  method estaDentroDelMapa(posicion) =
    posicion.x() >= 0 && posicion.x() < game.width() &&
    posicion.y() >= 0 && posicion.y() < game.height()

  method puedePisarse(posicion) =
    self.estaDentroDelMapa(posicion) &&
    !self.estaBloqueada(posicion)
}
