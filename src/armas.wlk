import personajePrincipal.*

class Arma {
    method nombre()
    
    method image() 

    method alcanceDelArma()

    method poder()
    
    method efectoSobre(personaje) = personaje.equiparArma(self)

    method position()
    
}
class Espada inherits Arma {

  override method alcanceDelArma() = 1

  override method poder() = 10
}

object espadaSimple inherits Espada { 
  
  override method nombre() = "Espada Simple"

  override method image() = "espadaSimple.png"

  override method poder() = super().poder() + 5

  override  method position() = game.center()

}


class Baculo inherits Arma {


}

class Arco inherits Arma {

}

object sinArma {
  method alcanceDelArma() = 0
  method poder() = 0
}