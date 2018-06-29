//CORRECCION: Nota Primer entrega: Bien+. Siempre entregar con los test en verde! (auque por la manera del test que falla podría pasar 
//CORRECCION: que en ciertas combinacion de versiones de wollok/JVM de verde y en otras aosmarillo).
//CORRECCION:  Mejorar el polimorfismo de elementos.
//CORRECCION: Los test pueden mejorarse, en particular el testeo sobre el espejo.
 
 // TODO Siguen estando los tests en rojo?
 // TOTO Este archivo tiene demasiado código no necesariamente cohesivo y demasiado largo, divídanlo en varios archivos.
class Capo {
	
	var property valorBaseLucha = 0
	var property valorBaseHechiceria = 0
	var property artefactos = #{}
	var property bando = null
	var property estaMuerto = false
	var imagen = null
	var property posicion = game.origin()

	method getArtefactos() = artefactos

	// TODO Este método no tiene sentido si ya tenemos una property con el mismo nombre	
//	method valorLuchaBase() = valorBaseLucha
	
	// TODO Este método no tiene sentido si ya tenemos una property con el mismo nombre	
	// Es necesario? ¿Dónde se usa?
//	method valorHechiceriaBase() = valorBaseHechiceria
	
	method incrementaLucha(valor) { valorBaseLucha += valor }
	
	method incrementaHechiceria(valor) { valorBaseHechiceria += valor }
	
	method valorLucha() = valorBaseLucha + artefactos.sum{ artefacto=> artefacto.valorLucha(self) }
	
	method valorHechiceria() = valorBaseHechiceria + artefactos.sum{ artefacto=> artefacto.valorHechiceria(self) }
	
	method puntosEnTotal() = self.valorLucha() + self.valorHechiceria()
	
	method getBando() = bando
	
    method encontrarElemento(elem) { elem.encontradoPor(self)}
    
    method encontradoPor(capo){
    	if (self.somosAmigos(capo)){
    		self.regalarArtefactos(capo)
    	} 
    	else {
    		self.peleaCon(capo)	
    	}
    }
    
    method regalarArtefacto(unArtefacto,unCapo){
    	unCapo.agregarArtefacto(unArtefacto)
		self.artefactos().remove(unArtefacto)
    }
    
    method regalarArtefactos(capo){
    	// TODO No es correcto manipular la colección de artefactos de otro capo directamente.

		self.artefactos().forEach({artefacto => self.regalarArtefacto(capo, artefacto)})
    } 	
    
    method peleaCon(capo){
    	
    	if (self.puntosEnTotal() >= capo.puntosEnTotal()){
    		// TODO ¿Cómo podría evitar la repetición de código entre las dos ramas del if?

			capo.fallecer()
			
    	}else{

			self.fallecer()
    	}
    }
	
	method agregarArtefacto(unArtefacto){
		artefactos.add(unArtefacto)
	}
		
	method somosAmigos(capo) = capo.getBando() == self.bando()
	
	method fallecer(){
		self.estaMuerto(true)
    	game.removeVisual(self)
	}
	
}


class Bando {
	
	var tesoro = 0
	var reserva = 0
	
	method getReserva() = reserva
	method getTesoro() = tesoro
	
	method agregaTesoro(ctd){ tesoro += ctd}
	method agregaReserva(ctd){ reserva += ctd}
		
}


class Cofrecito {
	// TODO ¿Por qué "var property"? 	
	var property valor = 100
	var imagen = "Cofre.png"
			
	method encontradoPor(capo){
		capo.getBando().agregaTesoro(valor)
		game.removeVisual(self)
		
	}
	
}

class Carbon {
				
	method encontradoPor(capo){
		capo.getBando().agregaReserva(50)
		
	}
	
}

