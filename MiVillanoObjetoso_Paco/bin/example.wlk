class Ciudad {
	var objetos
	var temperatura
	
	method cambiarTemperatura(x) {
		temperatura += x
	}
	method fueRobado(objeto) {
		objetos.remove(objeto)
	}
}

class Arma {
	var property nombre
	var property potencia
}

const rayoCongelante = new Arma(nombre = "rayo congelante", potencia = 10)
const rayoEncogedor = new Arma(nombre = "rayo encogedor", potencia = 15)

class Villano {
	var property minions
	var property ciudad
	var property maldadesPlanificadas
	var property maldadesRealizadas
	
	method nuevoMinion() {
		minions.add(new Minion(armas = [rayoCongelante], cantBananas = 5, cantMaldadesRealizadas = 0))
	}
	method otorgarArma(minion,arma) {
		minion.nuevoArma(arma)
	}
	method alimentar(minion,cantidad) {
		minion.comer(cantidad)
	}
	method nivelDeConcentracion(minion) {
		minion.concentracion()
	}
	method esPeligroso(minion) {
		minion.esPeligroso()
	}
	method darSuero(minion) {
		minion.absorberSuero()
	}
	method ejercitoPara(maldad) {
		return minions.filter{min => maldad.estaApto(min)}
	}
	method planificarMaldad(maldad) {
		maldadesPlanificadas.add(new PlanORealizacion(maldadd = maldad, minions = self.ejercitoPara(maldad)))
		return self.ejercitoPara(maldad)
	}
	method realizarMaldad(maldad) {
		if (maldadesPlanificadas.contains(maldad)) {
			maldad.realizar(ciudad,self.ejercitoPara(maldad))
			maldadesRealizadas.add(new PlanORealizacion(maldadd = maldad, minions = self.ejercitoPara(maldad)))
		} else {
			self.planificarMaldad(maldad)
			self.realizarMaldad(maldad)
		}
	}
	method minionMasUtil() {
		return maldadesRealizadas.map{mal => mal.minions()}.max{min => min.cantMaldadesRealizadas()}
	}
	method minionMasInutil() {
		return maldadesRealizadas.map{mal => mal.minions()}.filter{min => min.cantMaldadesRealizadas() == 0}
	}
}

class PlanORealizacion {
	var property maldadd
	var property minions
}

class Congelar {
	var property concentracionNecesaria = 500
	
	method estaApto(minion) {
		return minion.armas().map{arm => arm.nombre()}.contains("rayo congelante") and minion.concentracion() == concentracionNecesaria
	}
	method realizar(ciudad,minions) {
		ciudad.cambiarTemperatura(-30)
		minions.forEach{min => min.comer(10)}
		minions.forEach{min => min.realizarMaldad()}
	}
}

class Robar {
	var objetivo
	
	method estaApto(minion) {
		return minion.esPeligroso() and objetivo.estaApto(minion)
	}
	method realizar(ciudad,minions) {
		ciudad.fueBorrado(self)
		objetivo.robar(minions)
		minions.forEach{min => min.realizarMaldad()}
	}
}

class Piramide {
	var altura
	
	method estaApto(minion) {
		return minion.concentracion() >= altura / 2
	}
	method robar(minions) {
	}
}

class Suero {
	method estaApto(minion) {
		return minion.cantBananas() >= 100 and minion.concentracion() >= 23
	}
	method robar(minions) {
		minions.forEach{min => min.absorberSuero()}
	}
}

class Luna {
	method estaApto(minion) {
		return minion.armas().contains(rayoEncogedor)
	}
	method robar(minions) {
		minions.forEach{min => min.nuevoArma(rayoCongelante)}
	}
}

class Minion {
	var property armas
	var property color = amarillo 
	var cantBananas
	var property cantMaldadesRealizadas
	
	method esPeligroso() {
		return color.esPeligroso(self)
	}
	method absorberSuero() {
		cantBananas -= 1
		color.absorberSuerto(self)
	}
	method nuevoArma(arma) {
		armas.add(arma)
	}
	method concentracion() {
		return color.concentracion(self)
	}
	method armaMasPoderosa() {
		return armas.max{arm => arm.potencia()}
	}
	method comer(cantidad) {
		cantBananas += cantidad
	}
	method realizarMaldad() {
		cantMaldadesRealizadas += 1
	}
}

object amarillo {
	method esPeligroso(minion) {
		return minion.armas().size() > 2
	}
	method absorberSuero(minion) {
		minion.color(violeta)
		minion.armas().clear()
	}
	method concentracion(minion) {
		return minion.armaMasPoderosa().potencia() + minion.cantBananas()
	}
}

object violeta {
	method esPeligroso(minion) {
		return true
	}
	method absorberSuero(minion) {
		minion.color(verde)
	}
	method concentracion(minion) {
		return minion.cantBananas()
	}
}

object verde {
	method esPeligroso(minion) {
		return false
	}
	method absorberSuero(minion) {
		minion.color(amarillo)
		minion.realizarMaldad()
	}
	method concentracion(minion) {
		return minion.cantBananas() / 2
	}
}

