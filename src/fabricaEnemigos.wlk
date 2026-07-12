import enemigos.*

class GeneradorDeEnemigos {
    method crear(posiciones)
}

object generadorDeEsqueletos inherits GeneradorDeEnemigos {
    override method crear(posiciones) = posiciones.map { posicion => new EnemigoEsqueleto(position = posicion) }
}

object generadorDeBestias inherits GeneradorDeEnemigos {
    override method crear(posiciones) = posiciones.map { posicion => new EnemigoBestia(position = posicion) }
}
