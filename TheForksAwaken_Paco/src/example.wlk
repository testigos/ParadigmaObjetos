class Habitante {
	var property inteligencia
	var property valentia
	
	method poder() {
		return valentia + inteligencia
	}
}

class Soldado inherits Habitante {
	var property armas = []	
	
	override method poder() {
		return super() + armas.sum{eq => eq.potencia()}
	}
}

class Arma {
	var property potencia
}

class Planeta {
	var property habitantes = []
	
	method poder() {
		return habitantes.sum{hab => hab.poder()}
	}
	method poseeOrden() {
		return habitantes.sortedBy{hab1,hab2 => hab1.poder() > hab2.poder()}.take(3).sum{hab => hab.poder()} >= self.poder() / 2
	}
}

class Maestro inherits Habitante {
	var property mc
	var property ladoFuerza
	var property tiempoComoJediOSith
	var sable = new Arma()

	override method poder() {
		return super() + mc/1000 + ladoFuerza.potencia(sable,tiempoComoJediOSith)
	}
	method vivirSuceso(suceso) {
		ladoFuerza.vivirSuceso(suceso,self)
		tiempoComoJediOSith += 1
	}
}

class Luminoso {
	var property pazUOdio
	
	method vivirSuceso(suceso,maestro) {
		pazUOdio += suceso.cargaEmocional()
		self.cambiarDeLado(maestro)
	}
	method cambiarDeLado(maestro) {
		if (pazUOdio < 0) {
			maestro.ladoFuerza(new Oscuro(pazUOdio = 1000))
		} else {}	
	}
	method potencia(sable,tiempoComoJediOSith) {
		return sable.potencia() * tiempoComoJediOSith
	}
}

class Oscuro {
	var property pazUOdio
	
	method vivirSuceso(suceso,maestro) {
		if (pazUOdio >= suceso.cargaEmocional()) {
			pazUOdio += pazUOdio / 10
		} else {
			self.cambiarDeLado(maestro)
		}
	}
	method cambiarDeLado(maestro) {
		maestro.ladoFuerza(new Luminoso(pazUOdio = 500))
	}
	method potencia(sable,tiempoComoJediOSith) {
		return 2 * sable.potencia() + tiempoComoJediOSith
	}
}

class Suceso {
	var property cargaEmocional
}