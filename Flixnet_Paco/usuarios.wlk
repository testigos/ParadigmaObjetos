import peliculas.*
import calificaciones.*

class Usuario {
	var property nombre
	var property apellido
	var property edad
	var peliculasVistas = []
	var peliculasCalificadas = []
	
	method verPelicula(pelicula) {
		peliculasVistas.add(pelicula)	
	}
	method calificarPelicula(pelicula,puntaje) {
		if (puntaje <= 0 && puntaje <= 5) {
			const calif = new Calificacion (peli = pelicula, calificacion = puntaje, usuario = self)
			pelicula.agregarCalificacion(calif)
			peliculasCalificadas.add(calif)
		}
	}
}
