import pajaros.*

object sesionManejoDeIra {
	method desencadenarEvento(pajaro) {
		pajaro.tranquilizarse()
	}
}

class InvasionDeCerditos {
	var cantCerditos
	var cantidadDeVeces = (cantCerditos/100).roundUp(0)
	
	method desencadenarEvento(pajaro) {
		cantidadDeVeces.times{pajaro.enojarse()}
	}
}

class FiestaSorpresa {
	var pajarosHomenageados = []
	method desencadenarEvento(pajaro) {
		if (pajarosHomenageados.contains(pajaro)) {
			pajaro.enojarse()
		}
	}
}

class SerieDeEventosDesafortunados {
	var eventos = []
	
	method desencadenarEvento(pajaro) {
		eventos.forEach{evento => evento.desencadenarEvento(pajaro)}
	}
}
