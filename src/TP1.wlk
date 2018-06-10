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
	method valorLuchaBase() = valorBaseLucha
	
	// TODO Este método no tiene sentido si ya tenemos una property con el mismo nombre	
	// Es necesario? ¿Dónde se usa?
	method valorHechiceriaBase() = valorBaseHechiceria
	
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
    
    method regalarArtefactos(capo){
    	// TODO No es correcto manipular la colección de artefactos de otro capo directamente.
    	capo.artefactos().addAll(self.getArtefactos())
    	self.artefactos().clear()
    } 	
    
    method peleaCon(capo){
    	if (self.puntosEnTotal()>=capo.puntosEnTotal()){
    		// TODO ¿Cómo podría evitar la repetición de código entre las dos ramas del if?
    		capo.estaMuerto(true)
    		capo.regalarArtefactos(self)
    		game.removeVisual(capo)
    	}else{
    		
    		self.estaMuerto(true)
    		self.regalarArtefactos(capo)
    		game.removeVisual(self)

    	}
    }
	
	method agregarArtefacto(unArtefacto){
		artefactos.add(unArtefacto)
	}
		
	method somosAmigos(capo) = capo.getBando() == self.bando()
	
}


object espadaDelDestino {
	
	var imagen = "Espada.png"
	
	method valorLucha(capo) = 3
	
	method valorHechiceria(capo) = 0
	
	method encontradoPor(capo){
		capo.agregarArtefacto(self)
		game.removeVisual(self)
	}
}

object libroDeHechizos {
	
	method valorLucha(capo) = 0
	
	method valorHechiceria(capo) = capo.valorHechiceriaBase()
	
	method encontradoPor(capo){
		capo.agregarArtefacto(self)
	}
}

object collarDivino {
	
	method valorLucha(capo) = 1
	
	method valorHechiceria(capo) = 1
	
	method encontradoPor(capo){
		capo.agregarArtefacto(self)
	}
}

class Armadura {
	
	var refuerzo = ninguna
	var imagen = "Armadura.png"
	
	method setRefuerzo(ref) { refuerzo = ref }
	
	method valorLucha(capo) = 2 + refuerzo.valorLucha(capo)
	
	method valorHechiceria(capo) = refuerzo.valorHechiceria(capo)
	
	method encontradoPor(capo){
		capo.agregarArtefacto(self)
		game.removeVisual(self)
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
		// TODO Hay que mejorar la organización espacial del código
		// Esta línea tan larga dificulta la lectura.
		// También podría mejorar si usamos más delegación.
        return capo.getArtefactos().max({artefacto=>artefacto.valorHechiceria(capo)+ artefacto.valorLucha(capo)})
       		
	 }
    
	method valorHechiceria(capo){
		// TODO Por falta de división en subtareas, repite código.
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
		capo.agregarArtefacto(self)
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

// TODO ¿Por qué usamos clases siempre? ¿Es necesario?
class Sabio {
	
	var puntoslucha = 1
	var imagen = "Sabio.png"
	
	method encontradoPor(capo){
		capo.incrementaLucha(puntoslucha) 
		capo.incrementaHechiceria(cSabio.valor())
		game.removeVisual(self)
	}	
	
}	

// TODO ¿Qué es este objeto?
object cSabio{
	
	var property valor = 1
	
}

class Neblina {

	var oculto = []
	var imagen = "Neblina.png"

	method encontradoPor(capo) {
		oculto.forEach({ ocultos => capo.encontrarElemento(ocultos)})
		game.removeVisual(self)
	}

}
