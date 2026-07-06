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

    method proximaPosicion(direccion) =
        direccion.siguiente(position)

    method hayObjetoQueBloqueaEn(posicion) =
        game.getObjectsIn(posicion).any({ objeto =>
            objeto != self && objeto.bloqueaMovimiento()
        })

    method puedeMover(direccion) {
        const posicionNueva = self.proximaPosicion(direccion)

        return mapa.puedePisarse(posicionNueva) &&
            !self.hayObjetoQueBloqueaEn(posicionNueva)
    }

    method mover(direccion) {
        if (self.puedeMover(direccion)) {
            position = self.proximaPosicion(direccion)
        }
    }

    method moverEnPrimeraDireccionPosible(primerDireccion, segundaDireccion) {
        if (self.puedeMover(primerDireccion)) {
            self.mover(primerDireccion)
        } else if (self.puedeMover(segundaDireccion)) {
            self.mover(segundaDireccion)
        }
    }

    method moverRodeandoEnVertical() {
        if (position.x() % 2 == 0) {
            self.moverEnPrimeraDireccionPosible(arriba, abajo)
        } else {
            self.moverEnPrimeraDireccionPosible(abajo, arriba)
        }
    }

    method moverRodeandoEnHorizontal() {
        if (position.y() % 2 == 0) {
            self.moverEnPrimeraDireccionPosible(izquierda, derecha)
        } else {
            self.moverEnPrimeraDireccionPosible(derecha, izquierda)
        }
    }

    method perseguir(unPersonaje) {
        if (self.estaAlLadoDe(unPersonaje)) {
            unPersonaje.recibirAtaque(fuerza)
        } else {
            self.moverHacia(unPersonaje)
        }
    }

    method moverHacia(unPersonaje) {
        const posicionObjetivo = unPersonaje.position()
        const direccionHorizontal =
            self.direccionHorizontalHacia(posicionObjetivo)

        const direccionVertical =
            self.direccionVerticalHacia(posicionObjetivo)

        const distanciaX =
            (posicionObjetivo.x() - position.x()).abs()

        const distanciaY =
            (posicionObjetivo.y() - position.y()).abs()

        if (distanciaX > distanciaY) {
            if (self.puedeMover(direccionHorizontal)) {
                self.mover(direccionHorizontal)
            } else if (distanciaY > 0 && self.puedeMover(direccionVertical)) {
                self.mover(direccionVertical)
            } else {
                self.moverRodeandoEnVertical()
            }
        } else {
            if (self.puedeMover(direccionVertical)) {
                self.mover(direccionVertical)
            } else if (distanciaX > 0 && self.puedeMover(direccionHorizontal)) {
                self.mover(direccionHorizontal)
            } else {
                self.moverRodeandoEnHorizontal()
            }
        }
    }

    method direccionHorizontalHacia(posicionObjetivo) {
        if (posicionObjetivo.x() > position.x()) {
            return derecha
        }

        return izquierda
    }

    method direccionVerticalHacia(posicionObjetivo) {
        if (posicionObjetivo.y() > position.y()) {
            return arriba
        }

        return abajo
    }

    method estaAlLadoDe(unPersonaje) {
        const posicionObjetivo = unPersonaje.position()

        const distanciaHorizontal =
            (position.x() - posicionObjetivo.x()).abs()

        const distanciaVertical =
            (position.y() - posicionObjetivo.y()).abs()

        return distanciaHorizontal + distanciaVertical <= 1
    }
}
