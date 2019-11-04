import cantantes.*

object elegidos {
	var jueces = []
	var participantes = []
	
	method calcularPuntaje(cantante) = jueces.sum{juez => juez.voto(cantante)}
	
	method ganador() = participantes.max{participante => self.calcularPuntaje(participante)}
}

class Juez {
	var tipo
	
	method voto(cantante) {
		if(tipo.votoPositivo())
			return 10
		else
			return -5
	}
}

class Publico {
	method voto(cantante) = 2
}

class PublicoInfluenciado inherits Publico {
	const juezFavorito
	
	override method voto(cantante) = juezFavorito.voto(cantante)/5
}


//TIPO DE JUECES

object machirulo{
	
	method votoPositivo(cantante) = cantante.esMujer() and cantante.esJoven()
}

object tradicionalista{
	
	method votoPositivo(cantante) = cantante.cantaRitmoArgentino()
}

object tecnico{
	
	method votoPositivo(cantante) = cantante.aparentaLoQueEs()
}