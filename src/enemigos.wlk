import wollok.game.*
import mapa.*
import direcciones.*
import alcance.*
import serVivo.*
import marcaSuelo.*

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

    method direccionDisponibleHacia(objetivo) = self.direccionesCandidatas(objetivo).findOrDefault({ direccion => self.esDireccionUtil(direccion) }, sinDireccion)

    method direccionParaAcercarseA(objetivo) =
        if (self.estaEnLaMismaPosicion(objetivo)) sinDireccion else self.direccionDisponibleHacia(objetivo)

    method perseguir(objetivo) {
        self.moverA(self.direccionParaAcercarseA(objetivo).siguiente(position))
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
        const sonidoDeMuerte = game.sound("sonidos/muerteEnemigo.mp3")

        sonidoDeMuerte.volume(0.2)
        sonidoDeMuerte.play()
    }
}

class EnemigoEsqueleto inherits Enemigo(vida = 100, fuerza = 15){

    override method image() = "enemigos/enemigoEsqueleto.png"
}

class EnemigoBestia inherits Enemigo(vida = 100,fuerza = 20) {
    override method image() = "enemigos/enemigoBestia.png"
}
class EnemigoReyOscuro inherits Enemigo(vida = 200,fuerza = 30) {
    override method image() = "enemigos/enemigoReyOscuro.png"
}

class EnemigoFinal inherits Enemigo(vida = 300, fuerza = 40) {
    var property estado = inactivo

    override method image() = estado.image()

    override method atacar(objetivo) {
        if (estado.estaInactivo()) {
            estado = atacando
            game.schedule(400, {
                estado = impacto
                self.reproducirSonidoDeImpacto()
                self.mostrarImpactoEnSuelo(objetivo)
                objetivo.recibirAtaque(fuerza)
                game.schedule(650, { estado = inactivo })
            })
        }
    }

    method reproducirSonidoDeImpacto() {
        const sonidoImpacto = game.sound("sonidos/golpeBoss.mp3")

        sonidoImpacto.volume(0.2)
        sonidoImpacto.play()
    }

    method mostrarImpactoEnSuelo(objetivo) {
        const marcas = self.alcance().posicionesDelAlcanceDentroDelMapa(self).map { posicion => new MarcaSuelo(position = posicion) }

        marcas.forEach { marca => game.addVisual(marca) }
        self.pasarAlFrente(objetivo)
        game.schedule(300, { marcas.forEach { marca => marca.ocultar() } })
    }

    method pasarAlFrente(objetivo) {
        game.removeVisual(objetivo)
        game.addVisual(objetivo)
        game.removeVisual(self)
        game.addVisual(self)
    }
}

class EstadoDeAtaque {
    method image()
    method estaInactivo() = false
}

object inactivo inherits EstadoDeAtaque {
    override method image() = "enemigos/bossfinal.png"
    override method estaInactivo() = true
}

object atacando inherits EstadoDeAtaque {
    override method image() = "enemigos/bossfinalAtaca.png"
}

object impacto inherits EstadoDeAtaque {
    override method image() = "enemigos/bossfinalImpacto.png"
}
