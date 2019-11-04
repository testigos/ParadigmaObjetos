class Ninio {
	var elementos
	var property actitud
	var property caramelos
	var property salud
	
	method capacidadSusto() = actitud*elementos.sum{el => el.susto()}
	
	method asustar(adulto) {
		caramelos+=adulto.seAsusta(self)
	}
	
	method noEstaEnCama() = salud != enCama
	method comerCaramelos(cant) {
		if(caramelos < 0) {
			throw new Exception(message = "No tenes tantos caramelos para comer")
		}
		salud.modificarSaludSegun(cant,self)
		caramelos -= cant
	}
	
	method reducirMitadActitud() {
		actitud=actitud.div(2)
	}
}

object maquillaje {
	method susto() = 3
}

class TrajeTierno {
	method susto() = 2
}

class TrajeTerrorifico {
	method susto() = 5
}

object sano {
	method modificarSalud(caramelosComidos,persona) {
		if (caramelosComidos > 10) {
			persona.reducirMitadActitud()
			persona.salud(empachado)
		}
	}
}

object empachado {
	method modificarSalud(caramelosComidos,persona) {
		if (caramelosComidos > 10) {
			persona.actitud(0)
			persona.salud(enCama)
		}
	}
}

object enCama {
	method modificarSalud(caramelosComidos,persona) {
		throw new Exception(message = "No podes comer mas")
	}
}

class LegionDelTerror{
	var constituyentes
	
	method crearLegion(ninios) {
		if(ninios.size() >= 2)
			return new LegionDelTerror(constituyentes = ninios)
		else
			throw new Exception(message = "Muy pocos ninios")
	}
	
	method capacidadSusto() = constituyentes.sum{con => con.capacidadSusto()}
	method cantCaramelos() = constituyentes.sum{con => con.caramelos()}
	
	method lider() = constituyentes.max{ninio=>ninio.capacidadSusto()}
	
	method asustar(adulto) {
		self.lider().caramelos(adulto.seAsusta(self))
	}

/*
 * No es necesario hacer ningun cambio. Como consituyentes es una lista de asustadores y los metodos son
 * todos polimorficos entre ambas clases, puede ser utilizado legionesDelTerror para contener a solo ninios
 * o legiones y ninios mezclados.
 */
 
}