class PajarosComunes {
	var property ira = 0

	method fuerza() = 2*ira
	
	method esFuerte() = self.fuerza() > 50
	
	method enojarse() {}
	
	method tranquilizarse() {ira -= 5}
	
	method puedeDerribarObstaculo(obstaculo) = self.fuerza() > obstaculo.resistencia()
	
	method derribarObstaculo(isla,obstaculo) {
		if(self.puedeDerribarObstaculo(obstaculo))
			isla.eliminarObstaculo(obstaculo)
		else
			throw new Exception(message = "No tiene la suficiente energia")
	}
}

class Terrences inherits PajarosComunes {
	var rencor = 0
	var multiplicador
	
	override method fuerza() = 10*rencor*multiplicador
	
	override method enojarse() {rencor+=1}
	
}

const red = new Terrences(multiplicador = 1)

object bomb inherits PajarosComunes {
	var topeMaximo = 9000
	
	
	override method fuerza() = super().min(topeMaximo)
}

object chuck inherits PajarosComunes {
	var velocidad
	
	var diferencialDeVelocidad = 80 - velocidad
	
	override method fuerza() = 150 + 5*0.max(diferencialDeVelocidad)
	
	override method enojarse() {
		velocidad*=2
	}
	
	override method tranquilizarse() {}
}

object matilda inherits PajarosComunes {
	var huevos = []
	
	override method fuerza() = 2*ira + huevos.sum{huevo => huevo.fuerza()}
}

class Huevo {
	var peso
	
	method fuerza() = peso
}

class Pared {
	var property anchoPared
	const material
	method resistencia() = anchoPared*material
}

const vidrio = 5
const madera = 25
const piedra = 50

class Cerditos {
	var defensa 
	method resistencia() = 10*defensa
}
