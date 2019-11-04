class Minion {
	var property armas
	var property color = amarillo
	var property bananas
	
	method cantArmas() = armas.size()
	
	method esPeligroso() = color.esPeligroso(self)
	
	method tieneMasArmasQue(cant) = armas.size() > cant
	
	method perderBananas(cant) {
		bananas-=cant
	}
	
	method tomarSuero() {
		color.cambiar(self)
	}
	
	method perderArmas() = armas.clear()
	
	method concentracion() = color.concentracionSegunColor(self)
	
	method potenciaArmaMasPotente() = armas.max{arma => arma.potencia()}.potencia()
	
	method alimentar(cant) {
		bananas+= cant
	}
	
	method otorgarArma(arma) {
		armas.add(arma)
	}
	
	method tieneUn(nombre) = armas.any{arma => arma.nombre() == nombre}
	
	method concentracionMayorA(cant) = self.concentracion() > cant
	
	method cantBananasMayorA(cant) = bananas > cant
}

// COLORES

object amarillo {
	
	method cambiar(minion) {
		minion.perderArmas()
		minion.perderBananas(1)
		minion.color(violeta)
	}
	
	method esPeligroso(minion) = minion.tieneMasArmasQue(2)
	
	method concentracionSegunColor(minion) = minion.potenciaArmaMasPotente()*minion.bananas()

}

object violeta {
	
	method cambiar(minion) {
		minion.perderBananas(1)
		minion.color(verde)
	}
	
	method esPeligroso(minion) = true
	
	method concentracionSegunColor(minion) {
		return minion.bananas()
	}
} 

object verde {
	method cambiar(minion) {
		minion.perderBananas(2)
		minion.color(amarillo)
	}
	
	method esPeligroso(minion) = false
	
	method concentracionSegunColor(minion) {
		return minion.bananas().div(2)
	}
}

//ARMAS

class Arma {
	var property nombre
	var property potencia
}