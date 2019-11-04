import denuncias.*
import reacciones.*
import agresiones.*

class Persona {
	var property agresionesPrevias
	var property reaccionAnteAgresion
	var property familiares
	var property agresionesDenunciadas
	
	method agregarAgresion(agresion) = agresionesPrevias.add(agresion)
	
	method cantidadAgresiones() = agresionesPrevias.size()
	method cantidadAgresionesMismaPersona(agresor) = agresionesPrevias.count{agr => agr.personaQueEfectuo() == agresor}
	
	method esGraveYPersonal(agresion) = agresion.esGrave() and familiares.contains(agresion.personaQueEfectuo())
	method tieneAgresionesGravesYPersonales() = agresionesPrevias.any{agresion => self.esGraveYPersonal(agresion)}
	method estoyPreparadoParaHacerLaDenuncia(agresion) = reaccionAnteAgresion.comoReaccionaria(agresion,self)
	
	method esDenunciable(agresion) = self.esGraveYPersonal(agresion) and self.estoyPreparadoParaHacerLaDenuncia(agresion)
	
	method hacerDenuncia(agresion) = {
		if (self.esDenunciable(agresion)) {
			agresionesDenunciadas.add(agresion)
			policia.registrarDenuncia(agresion,self)
		}
	}
	
	method participarEnOrganizacionSocial() {
		reaccionAnteAgresion = militante
	}
	
	method acompaniamiento(por) {
		reaccionAnteAgresion = por.reaccionAnteAgresion()
	}
	
	method amenazaDeMuerte() {
		reaccionAnteAgresion = reaccionAnteAgresion.amenazadoDeMuerte()
	}
	
	
}