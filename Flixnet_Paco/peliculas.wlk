import usuarios.*

class Pelicula {
	var property titulo
	var property duracion
	var property director
	var property actores = []
	var property calificaciones = []
	
	method agregarCalifacion(calificacion) {
		calificaciones.add(calificacion)
	}
	
	method promedioCalificaciones() {
		calificaciones.sum{cal => cal.calificacion()}
	}
}