import peliculas.*
import calificaciones.*

class Usuario {
	var property nombre
	var property apellido
	var property edad
	var peliculasVistas = []
	var calificacionesPeliculas = []
	
	method verPelicula(titPelicula) {
		peliculasVistas.add(titPelicula)	
	}
	method calificarPelicula(titPelicula,puntaje) {
			const calif = new Calificacion (titPeli = titPelicula, calificacion = puntaje, usuario = self)
			pelicula.agregarCalificacion(calif)
			calificacionesPeliculas.add(calif)
			flixnet.calificaciones().add(calif)
		 	}
	}
	method  mejorCalificada() {
		if (self.pelisQueCalificoYVio().isEmpty().negate()) {
			return self.pelisQueCalificoYVio().max{cal => cal.calificacion()}
		} else {
			// Como pingo se hace un error
		}
	}
	method pelisQueCalificoYVio() {
		return calificacionesPeliculas.filter{cal => peliculasVistas.contains(cal.titPeli())}
	}
}