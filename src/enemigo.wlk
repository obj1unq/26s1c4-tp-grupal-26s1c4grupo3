class Enemigo {
    var vida
    var fuerza

    method esEnemigo() = true

    method recibirAtaque(daño) {
        vida -= daño.max(0)
    }
}