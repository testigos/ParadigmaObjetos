import eventos.*
import pajaros.*

object isla {
	var property pajaros = []
	
	method pajarosFuertes() = pajaros.filter{pajaro => pajaro.esFuerte()}
	
	method fuerzaTotal() = self.pajarosFuertes().sum{pajaro => pajaro.fuerza()}
	
	method eventoEnLaIsla(evento) {
		pajaros.forEach{pajaro => evento.desencadenarEvento(pajaro)}
	}
	
	method atacarIslaCerdito() {
		pajaros.forEach{pajaro => islaDeCerditos.recibirAtaque(pajaro)}
	}
}

object islaDeCerditos {
	var property obstaculos = []
	
	method fueConquistada() = obstaculos.isEmpty()
	
	method eliminarObstaculo(obstaculo) {obstaculos.remove(obstaculo)} 
	
	method recibirAtaque(pajaro) {
		if(pajaro.puedeDerribar(obstaculos.head()) and !self.fueConquistada())
			self.eliminarObstaculo(obstaculos.head())
	}
	
}
