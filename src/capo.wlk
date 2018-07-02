import elementos.*
import artefactos.*

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
    
    	method mejorArtefacto(_artefactos) {
		
        return _artefactos.max({ artefacto => artefacto.valorHechiceria(self) + artefacto.valorLucha(self)})
       		
	 }
    
    method regalarArtefacto(unArtefacto,unCapo){
    	unCapo.agregarArtefacto(unArtefacto)
		self.artefactos().remove(unArtefacto)
    }
    
    method regalarArtefactos(capo){

		self.artefactos().forEach({artefacto => self.regalarArtefacto(artefacto, capo)})
    } 	
    
    method peleaCon(capo){
    	
    	if (self.puntosEnTotal() >= capo.puntosEnTotal()){

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
		
	var  valor = 100
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

