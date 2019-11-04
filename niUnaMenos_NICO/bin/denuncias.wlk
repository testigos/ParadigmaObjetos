import agresiones.*

class Denuncia {
	const victima
	const agresion
	const nroDenuncia
	
	method victima() = victima
	method agresion() = agresion
	method nroDenuncia() = nroDenuncia
}

object policia {
	var property denuncias = []
	var property nroDenuncias = 0
	
	method registrarDenuncia(agr,persona) {
		nroDenuncias+=1
		denuncias.add(new Denuncia(victima = persona, agresion = agr,nroDenuncia = nroDenuncias))
	}
	
	method denuncio(denunciante) = denuncias.any{denuncia => denuncia.victima() == denunciante}
}

