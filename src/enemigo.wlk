import mapa.*
import direcciones.*

class Enemigo {
    var property position
    var vida
    var fuerza

    method image()

    method bloqueaMovimiento() = true

    method esEnemigo() = true

    method recibirAtaque(daño) {
        vida -= daño.max(0)
    }

    method estaVivo() = vida > 0

}

class EnemigoEsqueleto inherits Enemigo(vida = 100, fuerza = 15){
    
    override method image() = "enemigoPrimerMapa.png"
}