import personas.*

class Pocion {
	var property ingredientes 
	
	method efectoEn(persona) = ingredientes.forEach{ingrediente => ingrediente.afectarPersona(persona)}
}

class Ingrediente {
	var cantidad
}

class DulceDeLeche inherits Ingrediente{
	method afectarPersona(persona) {
		persona.aumentarFuerza(10)
		if(persona.puedePelear())
			persona.aumentarResistencia(2)
	}
}

class Muerdago inherits Ingrediente{
	method afectarPersona(persona) {
		persona.aumentarFuerza(cantidad)
		if(cantidad > 5)
			persona.recibirDano(persona.resistencia()/2)
	}
}

class AceiteDeRoca inherits Ingrediente{
	method afectarPersona(persona) {
		persona.aumentarFuerza((cantidad-1)*persona.fuerza())
	}
}

class ZumoZanahoria inherits AceiteDeRoca{
	override method afectarPersona(persona) {
		super(persona)
		persona.aumentarResistencia(1)
	}
}