
const palabrasInaceptables = ["puta"]

class Agresion {
	var property lugar
	var property personaQueEfectuo
	var property palabrasUtilizadas
	
	method esGrave() = palabrasUtilizadas.any{palabra => palabrasInaceptables.contains(palabra)}
	
	method esIgnea() = palabrasUtilizadas.contains("fuego")
	
	method cumpleRequisitos(familiaresDeLaVicima) = self.esGrave() and familiaresDeLaVicima.contains(personaQueEfectuo)
}

class AgresionFisica inherits Agresion {
	var property elementoUtilizado
	
	override method esGrave() = true
	
	override method esIgnea() = super() or elementoUtilizado.esCombustible()
}

class ElementosAgresivos {
	var nombre
	
	method esCombustible() = nombre == "combustible"
}





