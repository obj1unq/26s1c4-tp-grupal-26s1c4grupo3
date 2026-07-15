object mapa {

  const posicionesBloqueadas = [
    game.at(3, 21),
    game.at(4, 21),
    game.at(5, 21),
    game.at(6, 21),
    game.at(7, 21),
    game.at(8, 21),
    game.at(9, 21),
    game.at(10, 21),
    game.at(11, 21),
    game.at(13, 21),
    game.at(14, 21),
    game.at(15, 21),
    game.at(16, 21),
    game.at(17, 21),
    game.at(18, 21),
    game.at(19, 21),
    game.at(20, 21),
    game.at(21, 21)
  ]

  method estaBloqueada(posicion) =
    self.esUnBorde(posicion) ||
    posicionesBloqueadas.any { bloqueada => bloqueada == posicion }

  method esUnBorde(posicion) =
    posicion.x() <= 2 ||
    posicion.x() >= game.width() - 3 ||
    posicion.y() <= 4 ||
    posicion.y() >= game.height() - 3

  method estaDentroDelMapa(posicion) =
    posicion.x() >= 0 &&
    posicion.x() < game.width() &&
    posicion.y() >= 0 &&
    posicion.y() < game.height()

  method puedePisarse(posicion) =
    self.estaDentroDelMapa(posicion) &&
    !self.estaBloqueada(posicion)
}
