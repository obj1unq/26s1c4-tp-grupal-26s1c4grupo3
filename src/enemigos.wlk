import wollok.game.*
import mapa.*
import direcciones.*
import alcance.*
import serVivo.*

class Enemigo inherits SerVivo {
    var fuerza

    override method esEnemigo() = true

    method escalarPorDificultad(multiplicador) {
        vida = (vida * multiplicador).round()
        fuerza = (fuerza * multiplicador).round()
    }

    override method morir() {
        self.reproducirSonidoDeMuerte()
        game.removeVisual(self)
    }

    method orientarHacia(objetivo) {
        if (!self.estaEnLaMismaPosicion(objetivo)) {
            self.orientarA(buscadorDeDireccion.direccionHacia(position, objetivo.position()))
        }
    }

    // movimiento autonomo:
    method puedeMoverseA(posicion) = mapa.puedePisarse(posicion)

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
    method alcance() = new Alcance(ancho = 3, profundidad = 1)

    method estaEnRangoDeAtaque(objetivo) = self.alcance().posicionesDelAlcance(self).contains(objetivo.position())

    method atacar(objetivo) {
        objetivo.recibirAtaque(fuerza)
    }

    method actuar(objetivo) {
        if (objetivo.estaVivo()) {
            self.orientarHacia(objetivo)
            self.reaccionarA(objetivo)
        }
    }

    method reaccionarA(objetivo) {
        if (self.estaEnRangoDeAtaque(objetivo)) {
            self.atacar(objetivo)
        } else {
            self.perseguir(objetivo)
        }
    }

    method reproducirSonidoDeMuerte() {
        const sonidoDeMuerte = game.sound("sonidos\\muerteEnemigo.mp3")

        sonidoDeMuerte.volume(0.2)
        sonidoDeMuerte.play()
    }
}

class EnemigoEsqueleto inherits Enemigo(vida = 100, fuerza = 15){

    override method image() = "enemigos\\enemigoEsqueleto.png"
}

class EnemigoBestia inherits Enemigo(vida = 100,fuerza = 20) {
    override method image() = "enemigos\\enemigoBestia.png"
}
