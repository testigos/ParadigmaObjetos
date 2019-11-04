
class ActoDeGobierno {
	var cantidadAfectados
	var importancia
	
	method impacto() = cantidadAfectados*importancia
	
	method cumplir() {}
}

//INAUGURACION DE OBRAS
class InauguracionDeObra inherits ActoDeGobierno{
	var naturalezaDeLaObra
	
	override method impacto() = naturalezaDeLaObra.naturaleza()*super()
}

class Naturaleza {
	var property naturaleza
}

const vial = new Naturaleza(naturaleza = 0.1)
const habitacional = new Naturaleza(naturaleza = 0.2)
const salud = new Naturaleza(naturaleza = 0.5)

// DENUNCIAS
class DenunciaPorTv inherits ActoDeGobierno {
	var property denunciante
	var audiencia
	
	override method impacto() = super()*denunciante.reaccion(audiencia)
}

class Periodista {
	method reaccion(audiencia) = audiencia/2
}

class Politico {
	var cantSeguidores
	method reaccion(audiencia) = audiencia.min(cantSeguidores)
}

//DISCURSO

class Discurso inherits ActoDeGobierno{
	var intensidadDelAplauso
	
	override method impacto() = super()*intensidadDelAplauso
}

class PromesaDeCampania inherits Discurso {
	var property descripcionPromesa
	var property estaCumplida = false
	
	override method cumplir() {
		estaCumplida = true
	}
	
	override method impacto() = super()*self.valor()
	
	method valor() {
		if(estaCumplida) return (2)
		else return (-1)
		
	}
}


