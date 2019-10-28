import peliculas.*
import usuarios.*

object flixnet {
	var property peliculas = []
	var property usuarios = []
	var property calificaciones = []
	
	method noCalificadas() {
		return peliculas.filter{pel => calificaciones.contains(pel).negate()}
	}
	
}