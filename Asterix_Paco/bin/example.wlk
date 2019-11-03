class Combatiente {
	method poder() {
		return 0
	}
	method recibirDano(valor) {}
	method estaEnCombate() {
		return true
	}
	method pelearContra(contrincante) {
		if (self.estaEnCombate()) {
				[self,contrincante].min{com => com.poder()}.recibirDano((self.poder()-contrincante.poder()).abs())
		}
	}
}

class Grupo inherits Combatiente {
	var property personas
	
	override method poder() {
		return personas.filter{per => per.estaEnCombate()}.sum{per => per.poder()}
	}
	override method estaEnCombate() {
		return personas.all{per => per.estaEnCombate()}
	}
	override method recibirDano(valor) {
		self.personasMasPoderosas(10).forEach{per => per.recibirDano(valor / self.personasMasPoderosas(10).size())}
	}
	method personasMasPoderosas(valor) {
		return personas.sortBy{per => per.poder()}.take(valor)
	}
}

class Legion inherits Grupo {
	var property formacion
	
	override method poder() {
		return formacion.poder(super())
	}
	override method recibirDano(valor) {
		formacion.recibirDano(valor,self)
	}
}

class Tortuga {
	method poder(valor) {
		return 0
	}
	method recibirDano(valor,legion) {
		throw new Exception (message = "somos tortuga papa, no nos duele nada")
	}
}

class EnCuadro {
	var property cantidadAdelante
	
	method poder(valor) {
		return valor
	}
	method recibirDano(valor,legion) {
		legion.personasMasPoderosas(cantidadAdelante).forEach{per => per.recibirDano(valor / legion.personasMasPoderosas(cantidadAdelante).size())}
	}
}

class FrontemAllargate {
	method poder(valor) {
		return valor + valor / 10	
	}
	method recibirDano(valor,legion) {
		legion.personasMasPoderosas(legion.personas().size()).forEach{per => per.recibirDano(2 * valor / legion.personasMasPoderosas(legion.personas().size()).size())}
	}
}

class Persona inherits Combatiente {
	var property fuerza
	var property resistencia
	
	method cambiarFuerza(valor) {
		fuerza += valor
	}
	method cambiarResistencia(valor) {
		resistencia += valor
	}
	override method poder() {
		return fuerza * resistencia
	}
	override method recibirDano(valor) {
		self.cambiarResistencia(-valor)
	}
	override method estaEnCombate() {
		return resistencia > 0
	}
	method beberPocion(pocion) {
		pocion.soyBebidaPor(self)
	}
	override method pelearContra(contrincante) {
		
	}
}

class Pocion {
	var property ingredientes
	method soyBebidaPor(persona) {
		ingredientes.forEach{ing => ing.efectuarEn(persona)}
	}
}

class Ingrediente {
	var property cantidad
	
	method efectuarEn(persona) {
	}
}

class DulceDeLeche inherits Ingrediente {
	override method efectuarEn(persona) {
		persona.cambiarFuerza(10)
		if (persona.estaEnCombate().negate()) {
			persona.resistencia(2)
		}
	}
}

class ManojoDeMuerdago inherits Ingrediente {
	override method efectuarEn(persona) {
		persona.cambiarFuerza(cantidad)
		if (cantidad > 5) {
			persona.resistencia(persona.resistencia() - persona.resistencia() / 2)
		}
	}
}

class AceiteDeRoca inherits Ingrediente {
	override method efectuarEn(persona) {
		persona.cambiarFuerza(persona.fuerza()*(cantidad - 1))
	}
}

class ZumoDeZanahoria inherits AceiteDeRoca {
	override method efectuarEn(persona) {
		super(persona)
		persona.cambiarResistencia(1)
	}
}