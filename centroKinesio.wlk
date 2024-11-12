class Paciente {
  var edad
  var nivelMuscular
  var nivelDolor
  const property rutina = []

  method edad() = edad
  method aumentarEdad() {edad += 1}
  method nivelMuscular() = nivelMuscular  
  method nivelDolor() = nivelDolor
  method cambiarNivelDolor(valor) { nivelDolor = valor}
  method cambiarNivelMuscular(valor) { nivelMuscular = valor}
  method agregarAparato(unAparato) { rutina.add(unAparato) }
  method agregarMuchosAparatos(aparatos) { rutina.addAll(aparatos) }
  method sacarUnAparato(unAparato) { rutina.remove(unAparato) }

  method puedeUsarBici() = edad > 8  
  method puedeUsarMinitramp() = nivelDolor < 20
  method puedeUsarAparato(unAparato) = unAparato.puedeUsarAparatoEn(self)  
  
  method puedeRealizarRutina() = rutina.all({a=> a.puedeUsarAparatoEn(self)})
  
  method hacerRutina(){
    if(!self.puedeRealizarRutina()) self.error("El paciente no puede realizar la rutina")

      rutina.forEach({a=> a.usarAparatoEn(self)})

  }

}

class PacienteResistente inherits Paciente {
  override method hacerRutina() {
    super()
    nivelMuscular += rutina.size() 
  }
}
class PacienteCaprichoso inherits Paciente {
  override method puedeRealizarRutina() = super() && rutina.any({a=> a.esDeColor("rojo")})
  override method hacerRutina(){
    super()
    rutina.forEach({a=> a.usarAparatoEn(self)})
  }
}
class PacienteDeRapidaRecuperacion inherits Paciente {
  override method hacerRutina(){
    super()
    self.cambiarNivelDolor(nivelDolor -3)
  }
}


class Aparato {
  var property color = "blanco"

  method esDeColor(unColor) = color == unColor
  method puedeUsarAparatoEn(unPaciente) = true
  method usarAparatoEn(unPaciente)
  method necesitaMantenimiento()
  method hacerMantenimiento()
  method hacerMantenimientoSiEsNecesario() {
    if(self.necesitaMantenimiento()) self.hacerMantenimiento()
  }
  
  
}

class Magneto inherits Aparato {
  var imantacion

  method imantacion() = imantacion
  override method usarAparatoEn(unPaciente){
    unPaciente.cambiarNivelDolor(unPaciente.nivelDolor() - unPaciente.nivelDolor() * 0.1)
    self.perderImantacion()
  }
  method perderImantacion() { imantacion = 0.max(imantacion -1)}
  override method necesitaMantenimiento() = imantacion < 100
  override method hacerMantenimiento() { 800.min(imantacion + 500)}
  
}
class Bicicleta inherits Aparato {
  var cantDesajustesDeTornillos
  var cantPerdidasDeAceite

  override method puedeUsarAparatoEn(unPaciente) = unPaciente.edad() > 8
  override method usarAparatoEn(unPaciente) { 
    const dolorPrevio = unPaciente.nivelDolor()
    if(!unPaciente.puedeUsarBici()) self.error("El paciente no tiene edad suficiente")
      
      unPaciente.cambiarNivelDolor(0.max(unPaciente.nivelDolor() - 4))
      unPaciente.cambiarNivelMuscular(unPaciente.nivelMuscular() + 3)
    if ( unPaciente.edad().between(30, 50) && dolorPrevio > 30){
      self.desajustarTornillos()
      self.perderAceite()
    } else if (dolorPrevio > 30){
      self.desajustarTornillos()
    }
  }
  method desajustarTornillos() {cantDesajustesDeTornillos += 1}
  method perderAceite() {cantPerdidasDeAceite += 1}
  method cantDesajustesDeTornillos() = cantDesajustesDeTornillos
  method cantPerdidasDeAceite() = cantPerdidasDeAceite

  override method necesitaMantenimiento() =  cantDesajustesDeTornillos >= 10 ||
                                             cantPerdidasDeAceite >= 5
  override method hacerMantenimiento() {
    cantDesajustesDeTornillos = 0
    cantPerdidasDeAceite = 0
   }
}
class Minitramp inherits Aparato {
  
  override method puedeUsarAparatoEn(unPaciente) = unPaciente.nivelDolor() < 20
  override method usarAparatoEn(unPaciente) {
    if (self.puedeUsarAparatoEn(unPaciente)){
      unPaciente.cambiarNivelMuscular(unPaciente.nivelMuscular() + unPaciente.edad() * 0.1) 
    }
  }

  override method necesitaMantenimiento() = false
  override method hacerMantenimiento() {}
}