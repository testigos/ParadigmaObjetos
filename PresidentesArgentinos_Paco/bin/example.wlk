class Pais {
	var property presidentes
	
	method presiMayorImPos() {
		return presidentes.max{pre => pre.imagenPositiva()}
	}
}

class Presidente {
	var property actos = []
	var aniosDesdeMuerte
	
	method imagenPositiva() {
		return actos.sum{act => act.impacto()} + aniosDesdeMuerte
	}
	method cumplirTodasPromesas() {
		actos.forEach{act => act.cumplirPromesa()}
	}
	method crearYRegistrarDenuncia(x,y,z) {
		actos.add(new Denuncias(cantPersonas = x, importancia = y, valorExtra = z))
	}
}

class Acto {
	var cantPersonas
	var importancia
	var property valorExtra
	
	method impacto() {
		return cantPersonas * importancia
	}
	method cumplirPromesa() {}
}

class InauguracionObras inherits Acto {
	override method impacto() {
		return super() + valorExtra.valor(cantPersonas)
	}
}

class ValorExtra {
	var property valor
}

object viales inherits ValorExtra {
	override method valor(cantPersonas) {
		return 10
	}
}

object habitacionales inherits ValorExtra {
	override method valor(cantPersonas) {
		return 20
	}
}

object salud inherits ValorExtra {
	override method valor(cantPersonas) {
		return 50
	}
}

class Discurso inherits Acto {
	override method impacto() {
		return super() * valorExtra.valor()
	}
}

object intensidadAplauso inherits ValorExtra {
	
}

class Promesa inherits Discurso {
	var property cumplida
	override method impacto() {
		if (cumplida) {
			return 2 * super()
		} else {
			return -(2 * super())
		}
	}
	override method cumplirPromesa() {
		cumplida = true
	}
}

class Denuncias inherits Acto {
	override method impacto() {
		return -(super() * valorExtra.valor(cantPersonas))
	}
}

object periodista inherits ValorExtra {
	override method valor(cantPersonas) {
		return cantPersonas / 2
	}
}

class Politico inherits ValorExtra {
	var cantSeguidores
	
	override method valor(cantPersonas) {
		return cantSeguidores.min(cantPersonas)
	}
}