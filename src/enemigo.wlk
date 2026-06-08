class Enemigo {
    var vida
    var fuerza

    method recibirAtaque(daño) {
        vida -= daño.max(0)
    }
}