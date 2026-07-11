import enemigos.*
object fabricaEnemigos {

    method crearEsqueleto(posicion) = new EnemigoEsqueleto(position = posicion)

    method crearBestia(posicion) = new EnemigoBestia(position = posicion)

    method crearEsqueletos(posiciones) = posiciones.map { posicion => self.crearEsqueleto(posicion) }

    method crearBestias(posiciones) = posiciones.map { posicion => self.crearBestia(posicion) }

}
