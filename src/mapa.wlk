
object mapa {
  
  method estaDentroDelMapa(posicion) = 
    posicion.x() >= 0 && posicion.x() < game.width() &&
    posicion.y() >= 0 && posicion.y() < game.height()
}