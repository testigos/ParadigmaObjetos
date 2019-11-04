const ritmosArgentinos = [folklore,tango]

const ritmos = [folklore,tango,cumbia,pop]

class Cantante {
	var property genero
	var property edad
	var property generoMusical
	var indumentaria
	var property formaDeBailar
	var afino
	var property cancion
	
	method esMujer() = genero == "mujer"
	
	method esJoven() = edad <= 18
	
	method esViejo() = edad > 50
	
	method esAfinado() = afino
	
	method usa(algo) = indumentaria.contains(algo)
	
	method cantaRitmoArgentino() = ritmosArgentinos.contains(generoMusical)
	
	method bailaBien() = true 
	
	method aparentaLoQueEs() = cancion.perteneceAlGenero(self)
}

object folklore {
	method perteneceAlRitmo(cantante) = cantante.usa("poncho") and (cantante.usa("alpargatas") or cantante.usa("botas"))
}

object tango {
	method perteneceAlRitmo(cantante) = cantante.esViejo() and cantante.esAfinado() and cantante.usa("sombrero")
}

object cumbia {
	method perteneceAlRitmo(cantante) = cantante.bailaBien()
}

object pop {
	method perteneceAlRitmo(cantante) = true
}

class Cancion {
	var property autor
	var property generoMusical
	
	method perteneceAlGenero(cantante) = generoMusical.perteneceAlRitmo(cantante)
}