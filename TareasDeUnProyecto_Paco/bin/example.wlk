class Proyecto {
	var property tareas = []
	var property presupuesto
		
	method hayActividadEn(inicio,fin) {
		return tareas.filter{tar => inicio < tar.fecha() < fin}.map{tare => tare.lugar().provincia()}.asSet()
	}
	method superficiePromedio() {
		return tareas.sum{tar => tar.lugar().superficie()} / tareas.size()
	}
	method saldoEn(fecha) {
		self.realizarTareasHastaLa(fecha)
		return presupuesto
	}
	method realizarTareasHastaLa(fecha) {
		presupuesto += tareas.filter{ta => ta.fecha() <= fecha}.map{tar => tar.plata()}.sum()
	}
	method puedeRealizarse(tarea) {
		if (tareas.contains(tarea)) {
			tarea.puedeRealizarse(self)
		}
	}
	method esCoherente() {
		return tareas.all{tar => self.puedeRealizarse(tar)}
	}
}

class Tarea {
	var property fecha
	var property lugar
	var property tareasAnteriores = []
	var property servicios = []
	var property tipoTarea
	
	method plata() {
		return tipoTarea.plata(self)
	}
	method puedeRealizarse(proyecto) {
		return tareasAnteriores.all{tar => tar.fecha() < fecha} and tipoTarea.puedeRealizarse(proyecto,self)
	}
	method margen() {
		if (tareasAnteriores.size() == 0) {
			return 0
		} else {
			return fecha - tareasAnteriores.sortedBy{t1, t2 => t1.fecha() > t2.fecha()}.first().fecha()
		}
	}
}

object produccion {
	method plata(tarea) {
		return -(tarea.servicios().sum{sv => sv.plata()})
	}
	method puedeRealizarse(proyecto,tarea) {
		return proyecto.saldoEn(tarea.fecha()) >= 0
	}
}

class Recaudacion {
	var recaudacion
	method plata(tarea) {
		return recaudacion
	}
	method puedeRealizarse(proyecto,tarea) {
		return true
	}
}

object reunion {
	method plata(tarea) {
		return 0
	}
	method puedeRealizarse(proyecto,tarea) {
		return true
	}
}

class Servicio {
	var property plata
}

class Provincia {
	var property provincia
	var property superficie
}

class ZonaRural inherits Provincia {
	var property zona
	var property ancho
	var property largo
	
	override method superficie() {
		return ancho * largo
	}
}

class Ciudad inherits Provincia {
	var property ciudad
}

class Oficina inherits Ciudad {
	var property direccion
}