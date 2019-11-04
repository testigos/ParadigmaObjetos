import sustos.*

class Barrio {
 	var ninios
 	
 	method tresConMasCaramelos() = ninios.sortBy{n1,n2 => n1.caramelos() > n2.caramelos()}.take(3)
 	
 	method elementosDeNiniosConMasCaramelos() = ninios.filter{n => n.caramelos() > 10}.map{n=>n.elementos()}.asSet()
 }