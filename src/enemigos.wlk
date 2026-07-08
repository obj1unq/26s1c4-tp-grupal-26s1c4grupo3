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

    // movimiento autonomo:
    method puedeMoverseA(posicion) = mapa.puedePisarse(posicion)

    method moverA(posicion) {
        position = posicion
    }

    method estaEnLaMismaPosicion(objetivo) = position == objetivo.position()

    method direccionesCandidatas(objetivo) = buscadorDeDireccion.direccionesCandidatas(position, objetivo.position())

    method esDireccionUtil(direccion) = self.puedeMoverseA(direccion.siguiente(position))

    method direccionDisponibleHacia(objetivo) = self.direccionesCandidatas(objetivo).findOrDefault({ direccion => self.esDireccionUtil(direccion) }, null)

    method direccionParaAcercarseA(objetivo) =
        if (self.estaEnLaMismaPosicion(objetivo)) null else self.direccionDisponibleHacia(objetivo)

    method perseguir(objetivo) {
        const direccionElegida = self.direccionParaAcercarseA(objetivo)
        if (direccionElegida != null) {
            self.moverA(direccionElegida.siguiente(position))
        }
    }

    // comportamientos de ataque:
    //method atacar()

}

class EnemigoEsqueleto inherits Enemigo(vida = 100, fuerza = 15){
    
    override method image() = "enemigoPrimerMapa.png"
}