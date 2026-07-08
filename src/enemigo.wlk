import wollok.game.*
import mapa.*
import direcciones.*

class Enemigo {
    var ubicacion = game.at(0, 0)
    var property vida
    var property fuerza

    method position() = ubicacion
    method position_(nuevaPosicion) {
        ubicacion = nuevaPosicion
    }

    method image()

    method bloqueaMovimiento() = true

    method esEnemigo() = true

    method estaVivo() = vida > 0

    method recibirAtaque(daño) {
        vida = (vida - daño).max(0)
        console.println("Recibí " + daño + " de daño, me quedan " + vida + " de vida")
        if (!self.estaVivo()) {
            self.morir()
        }
    }

    method morir() {
        game.removeVisual(self)
    }

    //method atacar()

}

class EnemigoEsqueleto inherits Enemigo(vida = 100, fuerza = 15){
    
    override method image() = "enemigoPrimerMapa.png"
}