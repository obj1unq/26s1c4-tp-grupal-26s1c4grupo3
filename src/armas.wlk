import personajePrincipal.*

class Arma {
    const alcance = 0
    const poderBase = 0

    method alcanceDelArma() = alcance
    method efectoSobre(personaje) = personaje.equiparArma(self)
    method poder() = poderBase
}
class Espada inherits Arma {


}


class Baculo inherits Arma {


}

class Arco inherits Arma {

}

object sinArma {
  method alcanceDelArma() = 0
  method poder() = 0
}