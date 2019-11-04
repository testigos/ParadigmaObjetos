class IslaPajaro {
	var property pajaros
	
	method fuertes() {
		return pajaros.filter{paj => paj.fuerza() > 50}
	}
	method fuerza() {
		pajaros.sum{paj => paj.fuerza()}
	}
	method realizarEvento(evento) {
		evento.realizar(pajaros)
	}
	method atacarIslaPorcina(isla) {
		pajaros.forEach{paj => paj.atacar(isla)}
	}
	method recuperaronLosHuevos(isla) {
		return isla.obstaculos().size() == 0
	}
	method nuevoPajaro(pajaro) {
		pajaros.add(pajaro)
	}
}

class SesionManejoIra {
	method realizar(pajaros) {
		pajaros.forEach{paj => paj.cambiarIra(-5)}
	}
}

class InvasionDeChanchos {
	var cantChanchos
	
	method realizar(pajaros) {
		cantChanchos.div(100).times{pajaros.forEach{paj => paj.enojarse()}}
	}
}

class FiestaSorpresa {
	var homenajeados
	
	method realizar(pajaros) {
		pajaros.filter{paj => homenajeados.contains(paj)}.forEach{pa => pa.enojarse()}
	}
}

class SerieEventos {
	var eventos
	
	method realizar(pajaros) {
		eventos.forEach{ev => ev.realizar(pajaros)}
	}
}

class IslaPorcina {
	var property obstaculos
	
	method recibirAtaque(pajaro) {
		if (obstaculos.first().soyDerribadoPor(pajaro)) {
			obstaculos.remove(obstaculos.first())
		}
	}
}

class Obstaculo {
	var property ancho
	
	method resistencia() {
		return ancho
	}
	method soyDerribadoPor(pajaro) {
		return self.resistencia() < pajaro.fuerza()
	}
}

class ParedVidrio inherits Obstaculo {
	override method resistencia() {
		return super() * 10
	}
}

class ParedMadera inherits Obstaculo {
	override method resistencia() {
		return super() * 25
	}
}

class ParedPiedra inherits Obstaculo {
	override method resistencia() {
		return super() * 50
	}
}

class CerdoObrero inherits Obstaculo {
	override method resistencia() {
		return 50
	}
}

class CerdoArmado inherits Obstaculo {
	var proteccion
	
	override method resistencia() {
		return 10 * proteccion
	}
}

class Pajaro {
	var ira
	
	method fuerza() {
		return 2 * ira
	}
	method enojarse() {
		ira *= 2
	}
	method enojarseNVeces(n) {
		
	}
	method cambiarIra(valor) {
		ira += valor
	}
	method atacar(isla) {
		isla.recibirAtaque(self)
	}
}

class Red inherits Pajaro {
	var cantEnojo
	
	override method fuerza() {
		return super() * 5 * cantEnojo
	}
	override method enojarse() {
		super()
		cantEnojo += 1
	}
}

class Bomb inherits Pajaro {
	var tope = 9000
	override method fuerza() {
		if (super() < tope) {
			return super()
		} else {
			return tope
		}
	}
}

class Chuck inherits Pajaro {
	var velocidad
	
	override method fuerza() {
		if (velocidad < 80) {
			return 150
		} else {
			return 150 + (5 * (velocidad - 80))
		}
	}
	override method enojarse() {
		velocidad *= 2
	}
	override method cambiarIra(valor) {}
}

class Terrence inherits Red {
	var multiplicador
	
	override method fuerza() {
		return super() * multiplicador
	}
}

class Matilda inherits Pajaro {
	var huevos
	
	override method fuerza() {
		return super() + huevos.sum{hu => hu.fuerza()}
	}
	override method enojarse() {
		huevos.add(new Huevo(peso = 2))
	}
}

class Huevo {
	var property peso
	
	method fuerza() {
		return peso
	}
} 