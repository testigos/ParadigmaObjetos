class Pais {
	var property presidentes 
	
	method presidenteMayorImagenPositiva() = presidentes.max{presidente => presidente.imagenPositiva()}
}

class Presidente {
	var property actosDeGobierno
	var property tiempoDesdeSuMuerte
	
	method realizarActo(acto) = actosDeGobierno.add(acto)
	
	method imagenPositiva() = actosDeGobierno.sum{acto => acto.impacto()}*(1/100)*tiempoDesdeSuMuerte
	
	method muchosActos() = actosDeGobierno.size() >= 4

	method cumplirPromesasIncumplidas() {
		actosDeGobierno.forEach{a=>a.cumplir()}
	}
}