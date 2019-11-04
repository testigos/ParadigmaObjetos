
class Emocion {
	
	method afectarPersona(persona,recuerdo) {}
	
	method negar(recuerdo) = false
}

object alegria inherits Emocion{
	override method afectarPersona(persona,recuerdo) {
			if(persona.felicidadMayorA(500))
				persona.agregarPensamientoCentral(recuerdo)
	}
	
	override method negar(recuerdo) = true
}

object tristeza inherits Emocion{
	override method afectarPersona(persona,recuerdo) {
			persona.agregarPensamientoCentral(recuerdo)
			persona.disminuirFelicidadEn(0.1)
	}
	
	override method negar(recuerdo) {
		return recuerdo.emocion() == alegria
	}
}

const disgusto = new Emocion()
const furia = new Emocion()
const temor = new Emocion()



class EmocionCompuesta inherits Emocion {
	var emociones
	
	method esAlegre() = emociones.contains(alegria)
	
	override method negar(recuerdo) = emociones.forEach{emocion => emocion.negar(recuerdo)}
	
	override method afectarPersona(persona,recuerdo) {
		emociones.forEach{emocion => emocion.afectarPersona(persona,recuerdo)}
	}
}