import enemigos.*
object fabricaEnemigos {

    method crearEsqueleto(posicion, vida, fuerza) =
        new EnemigoEsqueleto(position = posicion, vida = vida, fuerza = fuerza)

    method crearBestia(posicion, vida, fuerza) =
        new EnemigoBestia(position = posicion, vida = vida, fuerza = fuerza)

    method crearEsqueletos(posiciones, vida, fuerza) {
        const enemigos = []

        posiciones.forEach({ posicion => enemigos.add(self.crearEsqueleto(posicion, vida, fuerza)) })

        return enemigos
    }

    method crearBestias(posiciones, vida, fuerza) {
        const enemigos = []

        posiciones.forEach({ posicion => enemigos.add(self.crearBestia(posicion, vida, fuerza)) })

        return enemigos
    }
}
