object centro {
    const property aparatos = []
    const property pacientes = [] 

    method coloresDeAparatos() = aparatos.map({a=> a.color()}).asSet()
    method pacientesMenoresAOcho() = pacientes.filter({p => p.edad() < 8})
    method noPuedenRealizarRutina() = pacientes.filter({p=> !p.puedeRealizarRutina()})
    method estaEnOpticasCondiciones() = aparatos.all({a=> !a.necesitaMantenimiento()})
    method estaComplicado() = aparatos.count({a=> a.necesitaMantenimiento()}) > (aparatos.size() * 0.5)
    method registrarVisita() {
        aparatos.forEach({a => a.hacerMantenimientoSiEsNecesario()})
    }
}