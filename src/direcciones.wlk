import wollok.game.*

object arriba {
    method siguiente(unaPosicion) = unaPosicion.up(1)

}

object abajo {
    method siguiente(unaPosicion) = unaPosicion.down(1)

}

object izquierda {
    method siguiente(unaPosicion) = unaPosicion.left(1)
}

object derecha {
    method siguiente(unaPosicion) = unaPosicion.right(1)
}
