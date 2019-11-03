class Agresion {
	var property lugar
	var property persona
	var palabrasUtilizadas = []
	var elementoUtilizado
	
	method esComun() {
		return elementoUtilizado == null
	}
	method esFisica() {
		return self.esComun().negate()
	}
	method esGrave() {
		return elementoUtilizado != null  or palabrasUtilizadas.any{pal => diccionario.palabrasInaceptables().contains(pal)}
	}
	method esIgnea() {
		return (self.esComun() and palabrasUtilizadas.contains("fuego")) or (self.esFisica() and (palabrasUtilizadas.contains("fuego") or elementoUtilizado == "combustible"))
	}
}

object diccionario {
	var property palabrasInaceptables = []
}

class Persona {
	var property composicionFamiliar = []
	var property agresionesRecibidas = []
	var property actitud
	var property umbralTolerancia
	var experiencias = []
	
	method recibirAgresion(agresion) {
		agresionesRecibidas.add(agresion)
		if (agresion.esGrave() and composicionFamiliar.contains(agresion.persona()) and actitud.hacerDenuncia(self,agresion)) {
			self.hacerDenuncia(agresion)
		} else {}
	}
	method hacerDenuncia(agresion) {
		policia.recibirDenuncia(self,agresion)
	}
	method vivirExperiencia(experiencia) {
		experiencias.add(experiencia)
		experiencia.cambiarActitud(self)
	}
}

object policia {
	var denuncias = []
	
	method recibirDenuncia(victimaa,agresionn) {
		denuncias.add(new Denuncia(agresion = agresionn, victima = victimaa, numero = denuncias.size() + 1))
	}
}

class Denuncia {
	var property agresion
	var property victima
	var property numero
}

class Actitud {
	var property nombre
	
	method hacerDenuncia(persona,agresion) {
		return true
	}
	method meAmenazaronDeMuerte(persona) {
	}
}

object miedo inherits Actitud {
	override method hacerDenuncia(persona,agresion) {
		return false
	}
}

object paciencia inherits Actitud {
	override method hacerDenuncia(persona,agresion) {
		return persona.agresionesRecibidas().filter{agr => agr.persona() == agresion.persona()}.size() > persona.umbralTolerancia()	
	}
	override method meAmenazaronDeMuerte(persona) {
		persona.umbralTolerancia(2 * persona.umbralTolerancia()) 
	}
}

object aguerrido inherits Actitud {
	override method hacerDenuncia(persona,agresion) {
		return persona.agresionesRecibidas().take(persona.agresionesRecibidas().size() - 1).any{agr => agr.esGrave() and persona.composicionFamiliar().contains(agr.persona())}
	}
	override method meAmenazaronDeMuerte(persona) {
		persona.actitud(paciencia)
		persona.umbralTolerancia(5)
	}
}

object militante inherits Actitud {
	override method meAmenazaronDeMuerte(persona) {
		persona.actitud(aguerrido)
	}
}

class Experiencia {
	var property descripcion
	var property acompanante
	
	method cambiarActitud(persona) {
		
	}
}

object militar inherits Experiencia {
	override method cambiarActitud(persona) {
			persona.actitud(militante)
	}
}

object acompanamientoCercano inherits Experiencia {
	override method cambiarActitud(persona) {
			persona.actitud(acompanante.actitud())
	}
}

object amenazaDeMuerte inherits Experiencia {
	override method cambiarActitud(persona) {
		persona.actitud().meAmenazaronDeMuerte(persona)
	}
}