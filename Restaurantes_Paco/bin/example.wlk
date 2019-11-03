class Estudiante {
	var property dinero
	var property platosProbados = []
	var property escuela
	var property girasAsistidas = []
	var property categoria
	
	method tieneBuenaOnda() {
		return true
	}
	method probarPlato(plato) {
		platosProbados.add(plato)
	}
	method asistirGira(gira) {
		girasAsistidas.add(gira)
	}
}

class Critico inherits Estudiante {
	var horasMirandoProgramas
	
	override method tieneBuenaOnda() {
		return horasMirandoProgramas / platosProbados.size() >= 10
	}
}

class Deglutidor inherits Estudiante {
	const tieneAuto
	
	override method tieneBuenaOnda() {
		return tieneAuto or platosProbados.size() > 20 
	}
}

class Chef {
	var property nombreTrabajo
	var property rubroTrabajo
}

class Gira {
	var property restOBod= []
	var property integrantes = []
	var dineroEstimado
	
	method valeLaPena() {
		return restOBod.all{rob => rob.valeLaPena(integrantes)}
	}
	method sumarIntegrante(integrante) {
		if (integrante.dinero() > dineroEstimado and integrante.tieneBuenaOnda()) {
			integrantes.add(integrante)
		} else {
			throw new Exception(message = "no estas apto para esta gira papa")
		}
	}
	method realizarGira() {
		restOBod.forEach{rob => rob.recibirClientes(integrantes)}
		integrantes.forEach{int => int.asistirGira(self)}
	}
}

class ResOBod {
	var property carta = []
	
	method recibirClientes(clientes) {
		clientes.forEach{cli => cli.probarPlato(carta.anyOne())}
	}
}


class Bodegon inherits ResOBod {

	method valeLaPena(integrantes) {
		return integrantes.size() <= carta.size()
	}
}

class Restaurante inherits ResOBod {
	var calificacion
	var chef
	var esExotico
	
	method valeLaPena(integrantes) {
		return (calificacion >= 3 and (chef.rubroTrabajo() == "programa de television" or chef.nombreTrabajo() == integrantes.head().escuela())) or esExotico
	}
}

