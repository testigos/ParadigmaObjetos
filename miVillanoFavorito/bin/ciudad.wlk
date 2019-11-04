class Ciudad {
	var temperatura
	var objetos
	
	method bajarTemperatura(cant) {
		temperatura -= cant
	}
	
	method perder(obj) {
		objetos.remove(obj)
	}
}
