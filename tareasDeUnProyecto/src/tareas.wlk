
class Proyecto {
	var property conjuntoDeTareas
	var property presupuestoInicial
	
	method saldoHasta(hasta) = presupuestoInicial + conjuntoDeTareas.filter{tarea=>tarea.esPreviaA(hasta)}.sum{tarea => tarea.gasto()}
	
	method tieneTareasEntre(f1,f2) = conjuntoDeTareas.any{tarea => tarea.estaEntre(f1,f2)}
	
	method seHaceEn(lugar) = conjuntoDeTareas.any{tarea => tarea.seHaceEn(lugar)}
	
	method esCoherente() = conjuntoDeTareas.all{tarea => tarea.puedeHacerse()}
	
	method provinciasConProyectosEntre(f1,f2) = conjuntoDeTareas.filter{tarea => tarea.estaEntre(f1,f2)}.map{tarea => tarea.provincia()}.asSet()
}

class Tarea {
	var property fecha = new Date()
	var property lugar
	var property tareasPrevias
	
	method estaEntre(f1,f2) = fecha.between(f1,f2)
	
	method seHaceEn(l) = lugar == l
	
	method superficiePromedio() = lugar.superficie()
	
	method esPreviaA(f) = fecha < f
	
	method puedeHacerse() = tareasPrevias.all{tp => tp.esPreviaA(fecha)}
	
	method fechaDeLaTareaPreviaMasCercana() = tareasPrevias.max{t1 => t1.fecha()}.fecha()
	
	method tieneTareasPrevias() = !tareasPrevias.isEmpty()
	
	method margenAnterior() {
		if(self.tieneTareasPrevias())
			return fecha - self.fechaDeLaTareaPreviaMasCercana()
		else
			return 0
	}
}

class TareaProduccion inherits Tarea {
	var property servicios
	method gasto() = -servicios.sum{ser => ser.costo()}
}

class Servicio {
	var property costo
}

class TareaRecaudacion inherits Tarea {
	var ingreso
	method gasto() = ingreso
}

class Reunion inherits Tarea {
	method gasto()
}

class Oficina {
	var direccion
	var ciudad
	const superficie
	
	method provincia(provincia) = ciudad.estaEn(provincia)
	
	method superficie() = superficie
}

class Ciudad {
	var property provincia
	const superficie

	method superficie() = superficie
	
	method provincia(prov) = provincia == prov
}

class ZonaRural {
	var provincia
	var ancho
	var largo
	
	method superficie() = ancho*largo
}