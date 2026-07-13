
object mapa {

  method estaBloqueada(posicion) {
    return  posicion.x() <= 2               ||
            posicion.x() >= game.width()-3  ||
            posicion.y() <= 2               ||
            posicion.y() >= game.height()-3
  }

  method estaDentroDelMapa(posicion) {
    return  posicion.x() >= 0 && posicion.x() < game.width() &&
            posicion.y() >= 0 && posicion.y() < game.height()
  }

  method puedePisarse(posicion) = self.estaDentroDelMapa(posicion) && !self.estaBloqueada(posicion)
}
