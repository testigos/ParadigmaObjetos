class Combatiente {
	
	method pelearContra(combatiente) {
		if(combatiente.puedePelear()) {
			combatiente.menosPoderoso().recibirDano(self.poder())
		} else {
			throw new Exception(message = "El grupo esta fuera de combate, no puede pelear")
		}
	}
	
	method poder()
}

class Persona inherits Combatiente {
	var property fuerza
	var property resistencia
	
	method aumentarFuerza(cant) {
		fuerza+=cant
	}
	method aumentarResistencia(cant) {
		fuerza+=cant
	}
	
	method puedePelear() = resistencia == 0
	
	override method poder() = fuerza*resistencia
	
	method recibirDano(cant) {
		resistencia = 0.max(resistencia-cant)
	}
	
	method tomarPocion(pocion) {
		pocion.efectoEn(self)
	}
	
	method menosPoderoso() = self
}

class Grupo inherits Combatiente {
	var guerreros
	const cantAdelante = 10
	
	override method poder() = guerreros.sum{guerrero => guerrero.poder()}
	
	method losQueVanAdelante() = guerreros.sortBy{guerrero => guerrero.poder()}.take(cantAdelante)
	
	method recibirDano(dano) {
		self.losQueVanAdelante().forEach{guerrero => guerrero.recibirDanio(dano/self.losQueVanAdelante().size())}
	
	}
	
	method puedePelear() = self.losQueVanAdelante().all{x => x.puedePelear()}
	
	method menosPoderoso() = self.losQueVanAdelante().last()
}

class Legion inherits Grupo {
	const poderMinimo
	
	var property formacion
	
	override method poder() = formacion.poder(super())
	override method recibirDano(cant) {
		formacion.recibirDano(cant,guerreros)
	}
	
	method recibirNuevoDano(dano,cant) {
		guerreros.losQueVanAdelante(cant).forEach{guerrero => guerrero.recibirDanio(dano/guerreros.losQueVanAdelante(cant).size())}
	}
	
	method losQueVanAdelante(cant) = guerreros.sortBy{guerrero => guerrero.poder()}.take(cant)
	
}

object tortuga {
	
	method poder() = 0
	method recibirDano(dano,legion) {}
}

object enCuadro {
	var cantAdelante
	
	method poder(poder) = poder
	
	method recibirDano(dano,legion) {
		legion.recibirNuevoDanio(dano,cantAdelante)
	}
}

object frontemAllargate {
	
	method poder(poder) = poder*0.1
	
	method recibirDano(dano,legion) {
		legion.recibirNuevoDanio(2*dano,legion.guerreros().size()/2)
	}
}