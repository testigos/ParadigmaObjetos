
object asentamiento {
	method desencadenarEn(persona) {
		persona.asentarTodosTusRecuerdos()
	}
}

class AsentamientoSelectivo {
	var palabra
	
	method desencadenarEn(persona) {
		persona.asentarTodosTusRecuerdosQueTengan(palabra)
	}
}

object profundizacion {
	
	method desencadenarEn(persona) {
		persona.agregarLargoPlazo(persona.recuerdosProfundizables())
	}
}

object controlHormonal {
	method desencadenarEn(persona) {
		if(persona.pensamientoCentralEnLargoPlazo() or persona.recuerdosConMismaEmocion()) {
			persona.desequilibrioHormonal()
		}
	}
}

object restauracionCognitiva {
	method desencadenarEn(persona) {
		persona.felicidad(1000.min(100))
	}
}

object liberacionDeRecuerdos {
	method desencadenarEn(persona) {
		persona.eliminarRecuerdos()
	}
}