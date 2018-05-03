//CORRECCION: Nota Primer entrega: Bien+. Siempre entregar con los test en verde! (auque por la manera del test que falla podría pasar 
//CORRECCION: que en ciertas combinacion de versiones de wollok/JVM de verde y en otras aosmarillo).
//CORRECCION:  Mejorar el polimorfismo de elementos.
//CORRECCION: Los test pueden mejorarse, en particular el testeo sobre el espejo.
 
class Capo {
	
	var property valorBaseLucha = 3
	var property valorBaseHechiceria = 1
	var property artefactos = #{}
	var property bando = null
	var property estaMuerto = false
	
	method getArtefactos() = artefactos
	
	method valorLuchaBase() = valorBaseLucha
	
	method valorHechiceriaBase() = valorBaseHechiceria
	
	method incrementaLucha() { valorBaseLucha += 1 }
	
	method incrementaHechiceria() { valorBaseHechiceria += 1 }
	
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
    //en este metodo se remueven todos los elementos de la coleccion pero no se logran pasar
    //a la coleccion del otro capo
    method regalarArtefactos(capo){
    	capo.artefactos().addAll(self.getArtefactos())
    	self.artefactos().clear()
    } 	
    
    method peleaCon(capo){
    	if (self.puntosEnTotal()>=capo.puntosEnTotal()){
    		capo.estaMuerto(true)
    		
    	}else{
    		
    		self.estaMuerto(true)
    	}
    }
	
	method agregarArtefacto(unArtefacto){
		artefactos.add(unArtefacto)
	}
		
	method somosAmigos(capo) = capo.getBando() == self.bando()
	
}


object espadaDelDestino {
	
	method valorLucha(capo) = 3
	
	method valorHechiceria(capo) = 0
	
	method encontradoPor(capo){
		capo.artefactos().add{self}
	}
}

object libroDeHechizos {
	
	method valorLucha(capo) = 0
	
	method valorHechiceria(capo) = capo.valorHechiceriaBase()
	
	method encontradoPor(capo){
		capo.artefactos().add{self}
	}
}

object collarDivino {
	
	method valorLucha(capo) = 1
	
	method valorHechiceria(capo) = 1
	
	method encontradoPor(capo){
		capo.artefactos().add{self}
	}
}

object armadura {
	
	var refuerzo = ninguna
	
	method setRefuerzo(ref) { refuerzo = ref }
	
	method valorLucha(capo) = 2 + refuerzo.valorLucha(capo)
	
	method valorHechiceria(capo) = refuerzo.valorHechiceria(capo)
	
	method encontradoPor(capo){
		capo.artefactos().add{self}
	}
		
}

object cotaDeMalla {
	
	method valorLucha(capo) = 1
	method valorHechiceria(capo) = 0
	
}

object bendicion {
	
	method valorLucha(capo) = 0
	method valorHechiceria(capo) = 1
	
}


object hechizo {
	
	method valorLucha(capo) = 0
	method valorHechiceria(capo) = if (capo.valorHechiceriaBase() > 3) 2  else 0
	
}

object ninguna {
	
	method valorLucha(capo) = 0
	method valorHechiceria(capo) = 0
	
}


object espejoFantastico{
	
	method mejorArtefacto(capo) {

        return capo.getArtefactos().max({artefacto=>artefacto.valorHechiceria(capo)+ artefacto.valorLucha(capo)})
       		
	 }
    
	method valorHechiceria(capo){
	
	   return if( capo.getArtefactos().size()>=1 and !(capo.getArtefactos().contains(self)))
	   		self.mejorArtefacto(capo).valorHechiceria(capo)
	   else
	   		0
	  	 
	 }
	   
	method valorLucha(capo){
	
	  return if( capo.getArtefactos().size()>=1 and !(capo.getArtefactos().contains(self)))
	  			self.mejorArtefacto(capo).valorLucha(capo)	 
	   		else
	   			0
	}
	
	method encontradoPor(capo){
		capo.artefactos().add{self}
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


object cofrecito {
			
	method encontradoPor(capo){
		capo.getBando().agregaTesoro(100)
	}
	
}

object carbon {
				
	method encontradoPor(capo){
		capo.getBando().agregaReserva(50)
	}
	
}

object sabio {
	method encontradoPor(capo){
		capo.incrementaLucha()
		capo.incrementaHechiceria()
	}	
}	
