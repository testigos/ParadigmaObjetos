import emociones.*

object riley {
	var felicidad = 1000
	var emocionDominante
	var recuerdosDelDia
	var pensamientosCentrales
	var fechaDeNacimiento
	var procesosMentales
	var memoriaALargoPlazo
	
	//AUXILIARES
	
	method edad() = new Date().year() - fechaDeNacimiento.year()
	
	method disminuirFelicidadEn(porcentaje){
		felicidad = 1.min(felicidad*(1-porcentaje))
		if (felicidad < 1)
			throw new Exception(message = "No puede ser menor que uno")
	}
	
	method agregarPensamientoCentral(recuerdo) {
		pensamientosCentrales.add(recuerdo)
	}
	
	method felicidadMayorA(cant) = felicidad > cant
	
	//VIVIR
	method vivirEvento(descripcion) {
		var recuerdo = new Recuerdo(descripcion = descripcion, fecha = new Date(),emocion = emocionDominante)
		recuerdosDelDia.add(recuerdo)
	}
	
	method asentarRecuerdo(recuerdo) {
		emocionDominante.afectarPersona(recuerdo,self)
	}
	
	method cantRecuerdos() = recuerdosDelDia.size()
	method recuerdosRecientes() {
		if (self.cantRecuerdos() < 5)
			return recuerdosDelDia
		else
			return recuerdosDelDia.drop(self.cantRecuerdos()-5)
	}
	
	method pensamientosCentrales() = pensamientosCentrales
	
	method dificilesDeExplicar() = pensamientosCentrales.filter{x=> x.dificilDeExplicar()}
	
	//DESCANSAR
	
	method negarRecuerdo(recuerdo) = emocionDominante.negar(recuerdo)
	
	method asentarRecuerdos() {
		recuerdosDelDia.forEach{recuerdo => self.asentarRecuerdo(recuerdo)}
	}
	
	method asentarTodosTusRecuerdosQueTengan(palabra) {
		recuerdosDelDia.filter{x=> recuerdo.tienePalabra(palabra)}.forEach{recuerdo => self.asentarRecuerdo(recuerdo)}
	}
	
	method agregarLargoPlazo(recuerdos) {
		recuerdos.forEach{recuerdo=>memoriaALargoPlazo.add(recuerdo)}
	}
	
	method eliminarRecuerdos() {
		recuerdosDelDia.clear()
	}
	
	method desequilibrioHormonal() {
		self.disminuirFelicidadEn(0.15)
		pensamientosCentrales.drop(3)
	}
	
	method recuerdosProfundizables() = recuerdosDelDia.filter{x=> !pensamientosCentrales.contains(x) and !self.negarRecuerdo(x)}
	
	method pensamientoCentralEnLargoPlazo() = pensamientosCentrales.any{pc => memoriaALargoPlazo.contains(pc)}
	
	method recuerdosConMismaEmocion() = recuerdosDelDia.all{recuerdo => recuerdo.emocion() == recuerdosDelDia.head().emocion()}
	
	method aDormir() {
		procesosMentales.forEach{proceso => proceso.desencadenarEn(self)}
	}
	
	//REMEMORAR
	method cantVecesRepetido(recuerdo) = memoriaALargoPlazo.occurancesOf(recuerdo)
	
	method dejaVu() = pensamientosCentrales.any{ pc => self.cantVecesRepetido(pc) > 1}
	
	method rememorar(recuerdo) {
		pensamientosCentrales.add(memoriaALargoPlazo.findOrElse({x=> x.esRememorable(self)},{throw new Exception(message = "nada para rememorar")}))
	}
}

class Recuerdo {
	var descripcion
	var fecha = new Date()
	var emocion
	
	method dificilDeExplicar() = descripcion.size() > 10
	
	method tienePalabra(palabra) = descripcion.contains(palabra)
	
	method esRememorable(persona) = new Date().year() - fecha.year() > (persona.edad()/2)
}