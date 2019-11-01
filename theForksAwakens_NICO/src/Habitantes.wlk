import fuerza.*

class Arma {
	var property potencia
}

class Habitante {
	var property inteligencia
	var property valentia
	
	method poder() = inteligencia + valentia
}

class Soldado inherits Habitante {
	var property armas 
	
	override method poder() = super() + armas.sum{arma => arma.potencia()}
}

class Maestro inherits Habitante {
	var property lado 
	var property cantidadMidiclorianos
	var property sableDeLuz
	var property tiempo
	
	override method poder() = super() + lado.poderDelSable(sableDeLuz,tiempo) + cantidadMidiclorianos.div(1000)
	
	method vivirSuceso(suceso) {
		lado.desencadenarSuceso(suceso,self)
	}
	
	method incrementarTiempo(cant) {
		tiempo+=1
	}
	
	method tipoDeMaestro() = lado.nombreDeSusMaestros()
}