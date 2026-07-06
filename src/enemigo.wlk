import mapa.*
import direcciones.*

class Enemigo {
    var vida
    var fuerza
    var property position

    method image() = "enemigoPrimerMapa.png"

    method bloqueaMovimiento() = true

    method recibirAtaque(daño) {
        vida -= daño.max(0)
    }

    method estaVivo() = vida > 0

}