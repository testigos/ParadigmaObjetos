import sustos.*

class Adulto {
	var sustosPrevios
	
	method tolerancia() = sustosPrevios.filter{ninio => ninio.cantCaramelos() > 15}.size()*10
	
	method seAsusta(ninio) {
		if(ninio.capacidadSusto() > self.tolerancia()) {
			return self.caramelosAEntregar()
		} else {
			return 0
		}
	}
	
	method caramelosAEntregar() = self.tolerancia().div(2)
}

class Abuelo inherits Adulto {
	override method seAsusta(ninio) = true
	override method caramelosAEntregar() = super().div(2)
}

class AdultoNecio inherits Adulto {
	override method seAsusta(ninio) = false
}