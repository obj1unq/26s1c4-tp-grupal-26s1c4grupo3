import wollok.game.*
import mapa.*
import direcciones.*

class Enemigo {
    var property position
    var vida
    const fuerza

    method vida() = vida // getter para verificar daño del PJ principal sobre los enemigos en los tests

    method image()

    method esEnemigo() = true

    method estaVivo() = vida > 0

    method recibirAtaque(daño) {
        vida = (vida - daño).max(0)
        //console.println("Recibí " + daño + " de daño, me quedan " + vida + " de vida") PARA VERIFICAR EN TERMINAL
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
    method estaEnRangoDeAtaque(objetivo) =
        (objetivo.position().x() - position.x()).abs() <= 1 and (objetivo.position().y() - position.y()).abs() <= 1

    method atacar(objetivo) {
        objetivo.recibirAtaque(fuerza)
    }

    method actuar(objetivo) {
        if (self.estaEnRangoDeAtaque(objetivo)) {
            self.atacar(objetivo)
        } else {
            self.perseguir(objetivo)
        }
    }

}

class EnemigoEsqueleto inherits Enemigo(vida = 100, fuerza = 15){

    override method image() = "enemigoPrimerMapa.png"
}

class EnemigoBestia inherits Enemigo(vida = 100,fuerza = 20) {
    override method image() = "enemigoSegundoMapa.png"
}