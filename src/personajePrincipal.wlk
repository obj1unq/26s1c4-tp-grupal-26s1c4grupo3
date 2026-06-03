object personaje {
  var vida = 100
  var fuerzaBase = 10
  const inventario = #{}

  var property position = game.at(3, 3)

  method fuerzaBase() = fuerzaBase
  method vida() = vida
  method image() = "personaje"

  method mover(direccion) {}
}