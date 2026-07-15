import wollok.game.*

class Direccion {

    method stringImage()

    method siguiente(unaPosicion)

    method posicionesAdyacentes(centro, radio)

    method posicionesHaciaAdelante(centro, profundidad)
}

object arriba inherits Direccion{

    override method stringImage() = "arriba"

    override method siguiente(unaPosicion) = unaPosicion.up(1)

    override method posicionesAdyacentes(centro, radio) {
        return (centro.x() - radio .. centro.x() + radio).map { x => game.at(x, centro.y()) }
    }

    override method posicionesHaciaAdelante(centro, profundidad) {
        return (1..profundidad).map { p => game.at(centro.x(), centro.y() + p) }
    }
}

object abajo inherits Direccion{

    override method stringImage() = "abajo"
    
    override method siguiente(unaPosicion) = unaPosicion.down(1)

    override method posicionesAdyacentes(centro, radio) {
        return (centro.x() - radio .. centro.x() + radio).map { x => game.at(x, centro.y()) }
    }

    override method posicionesHaciaAdelante(centro, profundidad) {
        return (1..profundidad).map { p => game.at(centro.x(), centro.y() - p) }
    }
}

object izquierda inherits Direccion{

    override method stringImage() = "izquierda"

    override method siguiente(unaPosicion) = unaPosicion.left(1)

    override method posicionesAdyacentes(centro, radio) {
        return (centro.y() - radio .. centro.y() + radio).map { y => game.at(centro.x(), y) }
    }

    override method posicionesHaciaAdelante(centro, profundidad) {
        return (1..profundidad).map { p => game.at(centro.x() - p, centro.y()) }
    }
}

object derecha inherits Direccion{

    override method stringImage() = "derecha"
    
    override method siguiente(unaPosicion) = unaPosicion.right(1)

    override method posicionesAdyacentes(centro, radio) {
        return (centro.y() - radio .. centro.y() + radio).map { y => game.at(centro.x(), y) }
    }

    override method posicionesHaciaAdelante(centro, profundidad) {
        return (1..profundidad).map { p => game.at(centro.x() + p, centro.y()) }
    }
}


object buscadorDeDireccion {

    method diferenciaEnX(posicionActual, posicionObjetivo) = posicionObjetivo.x() - posicionActual.x()

    method diferenciaEnY(posicionActual, posicionObjetivo) = posicionObjetivo.y() - posicionActual.y()

    // Se prioriza el eje con MAYOR diferencia (evita que un eje ya alineado en 0 oscile al intentar re-alinearse).
    // Alternativa de diseño para un futuro nivel con obstáculos más complejos: priorizar el eje con MENOR
    // diferencia primero (alinear rápido un eje y despues avanzar recto en el otro) pero esto requeriria un resguardo
    // explicito para no mover un eje que ya esta en diferencia 0 y por consecuencia causar movimientos extraños.
    method xEsElEjeDominante(posicionActual, posicionObjetivo) =
        self.diferenciaEnX(posicionActual, posicionObjetivo).abs() > self.diferenciaEnY(posicionActual, posicionObjetivo).abs()

    method direccionEnX(posicionActual, posicionObjetivo) =
        if (self.diferenciaEnX(posicionActual, posicionObjetivo) > 0) derecha else izquierda

    method direccionEnY(posicionActual, posicionObjetivo) =
        if (self.diferenciaEnY(posicionActual, posicionObjetivo) > 0) arriba else abajo

    method direccionesCandidatas(posicionActual, posicionObjetivo) =
        if (self.xEsElEjeDominante(posicionActual, posicionObjetivo))
            [self.direccionEnX(posicionActual, posicionObjetivo), self.direccionEnY(posicionActual, posicionObjetivo)]
        else
            [self.direccionEnY(posicionActual, posicionObjetivo), self.direccionEnX(posicionActual, posicionObjetivo)]

    method direccionHacia(posicionActual, posicionObjetivo) =
        self.direccionesCandidatas(posicionActual, posicionObjetivo).first()

}

