import mapa.*
import direcciones.*

class Enemigo {
    var property position
    var vida
    const fuerza

    method vida() = vida // getter para verificar daño del PJ principal sobre los enemigos en los tests

    method image()

    method bloqueaMovimiento() = false

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