class Programa {
	var property jurado
	var property cantantes
		
	method ganador() {
		return cantantes.max{can => jurado.forEach{jur => jur.evaluarCantante(can)}.sum()}
	}
}

class Cantante {
	var property nombre
	var property edad
	var property esMujer
	var property indumentaria = []
	var property bailaBien
	var property afinaron
	var property esJoven
	var property cancionElegida	
}

class Cancion {
	var property autor
	var property genero
}

class Genero {
	var property nombre
	var property tipo
	
	method aparienciaEsperada(cantante) {
		return tipo.concuerdaApariencia(cantante)
	}
}

class TipoGenero {
	var property indumentariaNecesaria
	method concuerdaApariencia(cantante) {
		return true
	}
}

object folklore inherits TipoGenero {
	override method concuerdaApariencia(cantante) {
		return indumentariaNecesaria.all{an => cantante.indumentaria().contains(an)}
	}
}

object tango inherits TipoGenero {
	override method concuerdaApariencia(cantante) {
		return cantante.edad() > 50 and indumentariaNecesaria.all{an => cantante.indumentaria().contains(an)} and cantante.afinaron()
	}
}

object cumbia inherits TipoGenero {
	override method concuerdaApariencia(cantante) {
		return cantante.bailaBien()
	}
}

object pop inherits TipoGenero {
}

const generosPropios = ["folklore","tango"]

class Juez {
	var property votoPositivo = 10
	var property votoNegativo = -5
	var property tipo
	
	method evaluarCantante(cantante) {
		return 0
	}
}

object machirulo inherits Juez {
	override method evaluarCantante(cantante) {
		if (cantante.esJoven() and cantante.esMujer()) {
			return votoPositivo
		} else {
			return votoNegativo
		}
	}
}

object tradicionalista inherits Juez {
	override method evaluarCantante(cantante) {
		if (self.generoElegidoEsNacional(cantante.cancionElegida())) {
			return votoPositivo
		} else {
			return votoNegativo
		}
	}
	method generoElegidoEsNacional(cancion) {
		return generosPropios.contains(cancion.genero().nombre())
	}
}

object tecnico inherits Juez {
	override method evaluarCantante(cantante) {
		if (cantante.cancionElegida().genero().aparienciaEsperada(cantante)) {
			return votoPositivo
		} else {
			return votoNegativo
		}
	}
}

class Publico inherits Juez {
	var juezConElQueSeIdentifica
	
	override method evaluarCantante(cantante) {
		if (juezConElQueSeIdentifica == null) {
			return votoPositivo / 5
		} else {
			return juezConElQueSeIdentifica.evaluarCantante(cantante) / 5
		}
	}
}
