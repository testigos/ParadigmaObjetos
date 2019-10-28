import peliculas.*
import usuarios.*

object flixnet {
	var property peliculas = []
	var property usuarios = []
	var property calificaciones = []
	
	method noCalificadas() {
		return peliculas.filter{pel => calificaciones.contains(pel).negate()}
	}
	method trabajoEn(laburante,pelicula) {
		return pelicula.actores().contains(laburante) or pelicula.director() == laburante
	}
}