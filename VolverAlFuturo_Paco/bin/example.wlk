class Destino {
	var property personajes
}

class Viaje {
	var viajeros = []
	var property combustible
	
	method viajarA(destino,fecha) {
		viajeros.forEach{via => via.realizarViaje(self)}
	}
	method subirPasajero(pasajero) {
		viajeros.remove(pasajero)
	}
	method bajarPasajero(pasajero) {
		viajeros.remove(pasajero)
	}
	method antepasadosDe(personaje,destino) {
		return destino.personajes().filter{per => per.apellido() == personaje.apellido() and per.esMayor()}
	}
	method huboUnProblemaCon(personaje,fecha) {
		viajeros.forEach{via => via.elementos().filter{elem => elem.fecha() > fecha}.forEach{ele => ele.descripcion("BTTF" + ele.descripcion())}}
		viajeros.forEach{via => via.elementos().forEach{elem => elem.eliminarPersonaje(personaje)}}
	}
} 

object plutonio {
	method causarEfecto(viajero) {
		viajero.cambiarAltura(-1)
	}
}

object nafta {
	method causarEfecto(viajero) {
		if (viajero.esMayor()) {
			viajero.cambiarEdad(-10)
		} else {
			viajero.cambiarEdad(5)
		}
	}
}

object energia {
	method causarEfecto(viajero) {
		if (viajero.elementos().size() > 0) {
			viajero.elementos().remove(viajero.elementos().min{elem => elem.fecha()})
		} else {
			throw new Exception (message = "no tenes ningun elemento banana")
		}
	}
}

object basura {
	method causarEfecto(viajero) {
		viajero.cambiarEdad(-2)
		viajero.cambiarAltura(1)
	}
}

class Personaje {
	var property edad
	var property altura
	var property apellido
	var property elementos = []
	
	method esMayor() {
		return self.edad() > 50
	}
	method tieneElementoPropio() {
		return elementos.any{elem => elem.esDueno(self) or elem.aparece(self)}
	}
	method realizarViaje(viaje) {
		viaje.combustible().causarEfecto(self)
	}
	method cambiarEdad(valor) {
		edad += valor 
	}
	method cambiarAltura(valor) {
		altura += valor
	}
}

class Elemento {
	var property descripcion
	var property fecha
	
	method esDueno(dueno) {
		return false
	}
	method aparece(persona) {
		return false
	}
	method eliminarPersonaje(persona) {}
}

class Documentacion inherits Elemento {
	var property personajesAparecen = []
	
	override method aparece(persona) {
		return personajesAparecen.contains(persona)
	}
	override method eliminarPersonaje(persona) {
		personajesAparecen.remove(persona)
	}
}

class ElementoFueraEpoca inherits Elemento {
	var property duenoOriginal
	
	override method esDueno(dueno) {
		return duenoOriginal == dueno
	}
}

const recorte = new Documentacion(descripcion = "recorte de revista universitaria", fecha = 2016)
const foto1 = new Documentacion(descripcion = "foto el con un reloj", fecha = 1885, personajesAparecen = [emmett])
const perro = new Elemento(descripcion = "perro einsten", fecha = 1980)
const control = new Elemento(descripcion = "control remoto", fecha = 1985)
const lentes = new Elemento(descripcion = "lentes", fecha = 1985)
const emmett = new Personaje(edad = 71, altura = 180, apellido = "brown", elementos = [lentes,control,perro,foto1,recorte])
const patineta = new ElementoFueraEpoca(descripcion = "patineta", fecha = 2015, duenoOriginal = marty)
const foto2 = new Documentacion(descripcion = "foto con sus hermanos", fecha = 1985, personajesAparecen = [marty])
const marty = new Personaje(edad = 25, altura = 170, apellido = "mcfly", elementos = [patineta,foto2])
const jennifer = new Personaje(edad = 26, altura = 150, apellido = "parker")
