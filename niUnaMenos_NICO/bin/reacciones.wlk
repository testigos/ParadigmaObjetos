object miedoso {
	method comoReaccionaria(agresion,persona) = false
	
	method amenazadoDeMuerte() = self
}

class Paciente {
	var umbralDeTolerancia = 2
	
	method comoReaccionaria(agresion,persona) = umbralDeTolerancia >= persona.cantidadAgresionesMismaPersona(agresion)

	method amenazadoDeMuerte() = new Paciente(umbralDeTolerancia = 2*umbralDeTolerancia)
}

object aguerrida {
	
	method comoReaccionaria(agresion,persona) = persona.tieneAgresionesGravesYPersonales()
	
	method amenazadoDeMuerte() = new Paciente(umbralDeTolerancia = 5)
}

object militante {
	
	method comoReaccionaria(agresion,persona) = true

	method amenazadoDeMuerte() = aguerrida
}
