import wollok.game.*
import sistemaDeSalas.mapa.*
import sistemaDirecciones.*
import alcance.*
import player.*
import visuales.marcaSuelo.*
import cooldown.*

class PlayerEnemy inherits Player {
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

    // Hook de reloj: la sala (dueña del único reloj del juego) avisa cuánto tiempo
    // pasó en cada tick. La mayoría de los enemigos no lleva tiempos propios.
    method pasarTiempo(milisegundos) { }

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

class EnemigoEsqueleto inherits PlayerEnemy(vida = 100, fuerza = 15){

    override method image() = "enemigos/enemigoEsqueleto.png"
}

class EnemigoBestia inherits PlayerEnemy(vida = 100,fuerza = 20) {
    override method image() = "enemigos/enemigoBestia.png"
}
class EnemigoReyOscuro inherits PlayerEnemy(vida = 100,fuerza = 25) {
    override method image() = "enemigos/enemigoReyOscuro.png"
}

class EnemigoFinal inherits PlayerEnemy(vida = 1000, fuerza = 40) {
    var estado = inactivo
    const cooldownAtaque = new CooldownManager(totalCooldownTime = 1500)
    const tiempoDeCarga = 1000
    const duracionDelImpacto = 650
    const duracionDeMarcas = 300

    override method image() = estado.image()

    override method pasarTiempo(milisegundos) {
        cooldownAtaque.onTimePassed(milisegundos)
    }

    // Mientras carga o impacta el golpe, el boss queda quieto: lo decide su estado.
    override method actuar(objetivo) {
        if (estado.permiteActuar()) {
            super(objetivo)
        }
    }

    method actualizarEstado() {
        estado = estado.actualizarEstado(self)
    } 
    //{ if (estado = impacto) {estado = inactivo} }

    // El golpe no es instantáneo: al iniciar la carga se marca en el piso la zona
    // de impacto y el daño recién impacta cuando la carga termina, solo si el
    // objetivo sigue parado en la zona marcada (se puede esquivar).
    override method atacar(objetivo) {
        if (cooldownAtaque.estaListo()) {
            self.iniciarCarga(objetivo)
        }
    }

    method iniciarCarga(objetivo) {
        cooldownAtaque.activar()
        estado = atacando
        const marcas = self.marcarZonaDeImpacto()
        objetivo.superponerImage()
        self.superponerImage()
        game.schedule(tiempoDeCarga, { self.impactarSiSigueVivo(objetivo, marcas) })
    }

    method marcarZonaDeImpacto() {
        const marcas = self.alcance().posicionesDelAlcanceDentroDelMapa(self).map { posicion => new MarcaSuelo(position = posicion) }

        marcas.forEach { marca => marca.aparecer() }
        return marcas
    }

    // Si el boss murió durante la carga, el golpe pendiente se cancela.
    method impactarSiSigueVivo(objetivo, marcas) {
        if (self.estaVivo()) {
            self.impactar(objetivo, marcas)
        } else {
            self.limpiarMarcas(marcas)
        }
    }

    method impactar(objetivo, marcas) {
        estado = impacto
        self.reproducirSonidoDeImpacto()
        self.dañarSiEstaEnLaZona(objetivo, marcas)
        game.schedule(duracionDeMarcas, { self.limpiarMarcas(marcas) })
        game.schedule(duracionDelImpacto, { self.actualizarEstado() })
    }

    method dañarSiEstaEnLaZona(objetivo, marcas) {
        if (marcas.any { marca => marca.position() == objetivo.position() }) {
            objetivo.recibirAtaque(fuerza)
        }
    }

    method limpiarMarcas(marcas) {
        marcas.forEach { marca => marca.ocultar() }
    }

    method reproducirSonidoDeImpacto() {
        const sonidoImpacto = game.sound("sonidos/golpeBoss.mp3")

        sonidoImpacto.volume(0.2)
        sonidoImpacto.play()
    }
}


class EstadoDeAtaque {
    method image()

    method permiteActuar()

    method actualizarEstado() = inactivo
}

object inactivo inherits EstadoDeAtaque {
    override method image() = "enemigos/bossfinal.png"

    override method permiteActuar() = true
}

object atacando inherits EstadoDeAtaque {
    override method image() = "enemigos/bossfinalAtaca.png"

    override method permiteActuar() = false

    override method actualizarEstado() {}
}

object impacto inherits EstadoDeAtaque {
    override method image() = "enemigos/bossfinalImpacto.png"

    override method permiteActuar() = false

    
}
