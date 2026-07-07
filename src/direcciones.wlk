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
