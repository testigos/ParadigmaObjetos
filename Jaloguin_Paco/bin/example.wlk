class Barrio {
	var property nenes = []
	
	method tresNenesConMasCaramelos() {
		return nenes.sortedBy{nen1, nen2 => nen1.caramelos() > nen2.caramelos()}.take(3)
	}
	method elementosUsadosBlaBlaBla() {
		return nenes.filter{nen => nen.caramelos() > 10}.map{nen => nen.elementosPuestos()}.asSet()
	}
}

class Legion {
	var property miembros = []
	
	method capacidadDeAsustar() {
		return miembros.sum{mm => mm.capacidadDeAsustar()}
	}
	method caramelos() {
		return miembros.sum{mm => mm.caramelos()}
	}
	method lider() {
		return miembros.max{mm => mm.capacidadDeAsustar()}
	}
	method asustarAdulto(adulto) {
		adulto.meAsuste(self)
	}
}

class Nene {
	var property elementosPuestos = []
	var property actitud
	var property caramelos
	var property estado

	method capacidadDeAsustar() {
		return elementosPuestos.sum{elem => elem.susto()} * actitud
	}
	method asustarAdulto(adulto) {
		adulto.meAsuste(self)
	}
	method recibirCaramelos(cantidad) {
		caramelos += cantidad
	}
	method comerCaramelo(cantidad) {
		if (cantidad >= 10) {
			estado.modificar(self,cantidad)
		} else {
			if (estado.salud() != "enCama") {
				caramelos -= cantidad
			} else {
				throw new Exception(message = "no podes comer mas caramelos sabandija")
			}
		}
	}
}

object sano {
	var property salud = "sano"
	method modificar(nene,cantidad) {
		nene.estado(empachado)
		nene.caramelos(nene.caramelos() + cantidad)
	}
}

object empachado {
	var property salud = "empachado"
	method modificar(nene,cantidad) {
		nene.estado(enCama)
		nene.actitud(nene.actitud() / 2)
		nene.caramelos(nene.caramelos() + cantidad)
	}
}

object enCama {
	var property salud = "enCama"
	method modificar(nene,cantidad) {
		nene.actitud(0)
	}
}

class Maquillaje {
	var property susto = 3
}

class Traje {
	var property personaje
	method susto() {
		personaje.susto()
	}
}

class Tierno {
	method susto() {
		return 2
	}
}

const winniePooh = new Tierno()
const sullivan = new Tierno()

class Terrorifico {
	method susto() {
		return 5	
	}
}

const jason = new Terrorifico()
const georgeBush = new Terrorifico()


class Adulto {
	var property caramelos
	var property nenesQueMeQuisieronAsustar = []
	
	method tolerancia() {
		return 10 * nenesQueMeQuisieronAsustar.count{nen => nen.caramelos() > 15}
	}
	method meAsuste(nene) {
		nenesQueMeQuisieronAsustar.add(nene)
		if (self.tolerancia() < nene.capacidadDeAsustar()) {
			nene.recibirCaramelos(self.tolerancia() / 2)
		}
	}
}

class Abuelo inherits Adulto {
	override method meAsuste(nene) {
		nene.recibirCaramelos(self.tolerancia() / 4)
	}
}

class AdultoNecio inherits Adulto {
	override method meAsuste(nene) {
	}
}

