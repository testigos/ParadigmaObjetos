import peliculas.*
import calificaciones.*

class Usuario {
	var property nombre
	var property apellido
	var property edad
	var peliculasVistas = []
	var calificacionesPeliculas = []
	
	method verPelicula(pelicula) {
		peliculasVistas.add(pelicula)	
	}
	method calificarPelicula(pelicula,puntaje) {
			const calif = new Calificacion (peli = pelicula, calificacion = puntaje, usuario = self)
			pelicula.agregarCalificacion(calif)
			calificacionesPeliculas.add(calif)
	}
	method  mejorCalificada() {
		 return (calificacionesPeliculas.filter{cal => peliculasVistas.contains(cal.peli())}).max{cal => cal.calificacion()}
	}
}
