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

object generadorDeReyOscuro inherits GeneradorDeEnemigos {
    override method crear(posiciones) = posiciones.map { posicion => new EnemigoReyOscuro(position = posicion) }
}

object generadorEnemigoFinal  inherits GeneradorDeEnemigos {
    override method crear(posiciones) = posiciones.map { posicion => new EnemigoFinal(position = posicion) }
}