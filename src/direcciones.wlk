import wollok.game.*

object arriba {
    method siguiente(unaPosicion) = unaPosicion.up(1)

    method nombre() = "arriba"
}

object abajo {
    method siguiente(unaPosicion) = unaPosicion.down(1)

    method nombre() = "abajo"
}

object izquierda {
    method siguiente(unaPosicion) = unaPosicion.left(1)

    method nombre() = "izquierda"
}

object derecha {
    method siguiente(unaPosicion) = unaPosicion.right(1)

    method nombre() = "derecha"
}
