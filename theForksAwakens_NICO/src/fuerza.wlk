class Planeta {
	var property habitantes 
	
	method poderDe(grupoDeHabitantes)= grupoDeHabitantes.sum{ habitante => habitante.poder()}
	
	method poder() = self.poderDe(habitantes) 	

	method masPoderosos() = habitantes.sortedBy({ unHabitante, otroHabitante => unHabitante.poder() > otroHabitante.poder()}).take(3)
	
	method tieneOrden() = self.poderMasPoderosos() >= self.poder() / 2

	method poderMasPoderosos() = self.poderDe(self.masPoderosos())
}

class Fuerza {
	
	method desencadenarSuceso(suceso,maestro) {
		maestro.incrementarTiempo(1)
	}
}

class LadoLuminoso inherits Fuerza {
	var property nombreDeSusMaestros = "jedi"
	var pazInterior = 1000
	
	method constanteDeFuerza() = pazInterior
	
	method poderDelSable(sableDeLuz,tiempo) = sableDeLuz.potencia()*tiempo
	
	override method desencadenarSuceso(suceso,maestro) {
		super(suceso,maestro)
		pazInterior = pazInterior + suceso.cargaEmocional()
		if(!self.tienePaz()) {
			maestro.lado(new LadoOscuro())
		}
	}
	
	method tienePaz() = pazInterior > 0
}


class LadoOscuro inherits Fuerza{
	var property nombreDeSusMaestros = "sith"
	var odio = 1000
	
	method constanteDeFuerza() = odio
	
	method poderDelSable(sableDeLuz,tiempo) = 2*(sableDeLuz.potencia())+tiempo
	
	override method desencadenarSuceso(suceso,maestro) {
		super(suceso,maestro)
		odio+=odio*10/100
		if(self.emocionMayorQueElOdio(suceso)) {
			maestro.lado(new LadoLuminoso())
		}
	}
	
	method emocionMayorQueElOdio(suceso) = suceso.cargaEmocional() >= odio
}

class Suceso {
	var property cargaEmocional
}