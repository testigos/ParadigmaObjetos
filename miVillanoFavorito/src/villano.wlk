import minions.*
import ciudad.*

class Villano {
	var minions
	var ciudadEnLaQueVive
	var maldadesRealizadas = []
	var maldadesPlanificadas = []
	
	method nuevoMinion() {
		minions.add(new Minion(armas = [new Arma(nombre = "rayo congelador", potencia = 10)], color = amarillo, bananas = 5))
	}
	
	method realizarMaldad(maldad) {
		if(self.planifiqueMaldad(maldad)) {
			maldad.realizar(ciudadEnLaQueVive)
			maldadesRealizadas.add(maldad)
			maldadesPlanificadas.remove(maldad)
		} else {
			throw new Exception(message = "Debes planificar la maladad antes de realizarla")
		}
		
	}
	
	method planifiqueMaldad(maldad) {
		return maldadesPlanificadas.contains(maldad)
	}
	
	method planificarMaldad(maldad) {
		maldad.asignarMinions(minions)
		maldadesPlanificadas.add(maldad)
	}
	
	method cantidadMaldadesDeMinion(minion) = maldadesRealizadas.flatmap{maldad => maldad.minionsAsignados()}.occurencesOf(minion)
	
	method minionMasUtil() = minions.max{minion => self.cantidadMaldadesDeMinion(minion)}
	
	method minionMenosUtil() = minions.filter{minion => self.cantidadMaldadesDeMinion(minion) == 0}
	
}

//MALDAD
class Maldad {
	var property minionsAsignados = []
	
	method asignarMinions(minions) {
		minionsAsignados = minions.filter{minion => self.esAsignable(minion)}
	}
	
	method esAsignable(minion)
	
	method realizar(ciudad) {
		if(minionsAsignados.isEmpty())
			throw new Exception(message = "No hay minions para realizarla")
	}
}

class Congelar inherits Maldad {
	
	override method esAsignable(minion) = minion.tieneUn('rayo congelante') and minion.concentracionMayorA(500)
	
	override method realizar(ciudad) {
		super(ciudad)
		ciudad.bajarTemperatura(30)
		minionsAsignados.forEach{minion => minion.alimentar(10)}
	}
}

class Robo inherits Maldad {
	var objetoARobar
	
	override method esAsignable(minion) = minion.esPeligroso() and objetoARobar.condicion(minion)
	
	override method realizar(ciudad) {
		super(ciudad)
		ciudad.perder(objetoARobar)
		minionsAsignados.forEach{minion => objetoARobar.premiar(minion)}
	}
}

//OBJETOS ROBABLES
class Piramide {
	var altura
	
	method condicion(minion) = minion.concentracionMayorA(altura/2)
	method premiar(minion) = minion.alimentar(10)
}

object sueroMutante {
	
	method condicion(minion) = minion.cantBananasMayorA(100) and minion.concentracionMayorA(23)
	method premiar(minion) = minion.tomarSuero()
}

object laLuna {
	
	method condicion(minion) = minion.tieneUn("rayo para encoger")
	method premiar(minion) {
		var rayoPremiado = new Arma(nombre = "rayo congelante", potencia = 10)
		minion.otorgarArma(rayoPremiado)
	} 
}