//CORRECCION: Nota Primer entrega: Bien+. Siempre entregar con los test en verde! (auque por la manera del test que falla podría pasar 
//CORRECCION: que en ciertas combinacion de versiones de wollok/JVM de verde y en otras aosmarillo).
//CORRECCION:  Mejorar el polimorfismo de elementos.
//CORRECCION: Los test pueden mejorarse, en particular el testeo sobre el espejo.
 
object rolando {
	
	var valorBaseLucha = 3
	var valorBaseHechiceria = 1
	var artefactos = #{}
	var bando = bandoDelSur
	
	method getArtefactos() = artefactos
	
	method valorLuchaBase() = valorBaseLucha
	
	method valorHechiceriaBase() = valorBaseHechiceria
	
	method incrementaLucha() { valorBaseLucha += 1 }
	
	method incrementaHechiceria() { valorBaseHechiceria += 1 }
	
	method valorLucha() = valorBaseLucha + artefactos.sum{ artefacto=> artefacto.valorLucha(self) }
	
	method valorHechiceria() = valorBaseHechiceria + artefactos.sum{ artefacto=> artefacto.valorHechiceria(self) }
	
	method getBando() = bando
	
	method encontrarElemento(elem){
	
		
		//CORRECCION: En estas cuatro líneas se ve que un elemento 
		//CORRECCION: modifica alguna de estas 4 cosas. y para programar
		//CORRECCION: un elemento hay que decir específicamente que hace con cada una de estas 4 cosas
		//CORRECCION: Se puede aprovechar de una manera mucho más prolija el polimorfismo 
		//CORRECCION: al dejarle más responsabilidad al elemento. El truco se basa en no dar tanto detalle
		//CORRECCION: sobre las cosas que puede modificar, si no simplemente decirle: "actua sobre un capo"
		//CORRECCION: object rolando { 
		//CORRECCION: method encontrarElemento(elem) { elem.encontradoPor(self)} 	
		//CORRECCION:}
		//CORRECCION: object cofrecito {
		//CORRECCION:	
		//CORRECCION:	method encontradoPor(capo){
		//CORRECCION:		capo.getBando().agregaTesoro(100)
		//CORRECCION:	}
		//CORRECCION: object carbon {
		//CORRECCION:		
		//CORRECCION:	method encontradoPor(capo){
		//CORRECCION:		capo.getBando().agregaReserva(50)
		//CORRECCION:	}
		//CORRECCION:object sabio {
		//CORRECCION:	method encontradoPor(capo){
		//CORRECCION:		 capo.incrementaLucha()
		//CORRECCION:		 capo.incrementaHechiceria()
		//CORRECCION:	}	
		//CORRECCION:}
				
		
		elem.oro(self)
		elem.carbon(self)
		elem.valorLucha(self)
		elem.valorHechiceria(self)
		
	}
	
	method agregarArtefacto(unArtefacto){
		artefactos.add(unArtefacto)
	}
}

object espadaDelDestino {
	
	method valorLucha(capo) = 3
	
	method valorHechiceria(capo) = 0
}

object libroDeHechizos {
	
	method valorLucha(capo) = 0
	
	method valorHechiceria(capo) = capo.valorHechiceriaBase()
}

object collarDivino {
	
	method valorLucha(capo) = 1
	
	method valorHechiceria(capo) = 1
}

object armadura {
	
	var refuerzo = ninguna
	
	method setRefuerzo(ref) { refuerzo = ref }
	
	method valorLucha(capo) = 2 + refuerzo.valorLucha(capo)
	
	method valorHechiceria(capo) = refuerzo.valorHechiceria(capo)
		
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


object espejoFantastico	{
	
	//CORRECCION La forma abreviada con = ya hace el return, por lo que está de más
	//CORRECCION: sin embargo cuando el método tiene un cuerpo que ocupa más de una línea
	//CORRECCION conviene usar {return ...}
	method mejorArtefacto(capo) = 

	 //CORRECCION: No es del todo cierto que el mejor artefacto cuando no hay otro es self.
     //CORRECCION: En que contexto se le pediría el mejor artefacto al espejo cuando lo tiene a él solo?
     //CORRECCION: si este mensaje está diseñado para ser enviado por self en valorHechiceria y valorLucha y allí
     //CORRECCION: ya están los if necesarios. Lo mejor es evitar este if y dejar que falle (tire error) si se usa mal
     return if( capo.getArtefactos().size()>=1)
     
     
       (self.artefactosSinEspejo(capo)).max({artefacto=>artefacto.valorHechiceria(capo)+ artefacto.valorLucha(capo)})
        
       		else self
       	
	method artefactosSinEspejo(capo) {
       	
       	return capo.getArtefactos().filter({artefacto=>artefacto!=self})
       	
       	}

//CORRECCION: Indentar mejor
	method valorHechiceria(capo) {
	
	   return if(self.contieneSoloEspejo(capo)) 0 
	   
	  	 else self.mejorArtefacto(capo).valorHechiceria(capo)
	  	 
	  	 }
	   
	method valorLucha(capo) {
	
	   return if(self.contieneSoloEspejo(capo)) 0 
	  
	  	 else self.mejorArtefacto(capo).valorLucha(capo)
	  	 
	  	 }
	  	 
	method contieneSoloEspejo(capo){
		return capo.getArtefactos().size() == 1 and capo.getArtefactos().contains(self)
	}  	 
	   
}

object bandoDelSur {
	
	var tesoro = 0
	var reserva = 0
	
	method getReserva() = reserva
	method getTesoro() = tesoro
	
	method agregaTesoro(ctd){ tesoro += ctd}
	method agregaReserva(ctd){ reserva += ctd}
	
}

//CORRECCION: ver la correccion que quedó en rolando.encontrarElemento(elem)
object cofrecito {
	
	method oro(capo){
		capo.getBando().agregaTesoro(100)
	}
	method carbon(capo){
		capo.getBando().agregaReserva(0)
	}
	//CORRECCION: estos mensajes deben ser ordenes. no deben devolver nada
	method valorLucha(capo) = 0
	method valorHechiceria(capo) = 0
		
}
object carbon {
	
	method oro(capo){
		capo.getBando().agregaTesoro(0)
	}
	method carbon(capo){
		capo.getBando().agregaReserva(50)
	}
	//CORRECCION: estos mensajes deben ser ordenes. no deben devolver nada
	method valorLucha(capo) = 0
	method valorHechiceria(capo) = 0
		
}
object sabio {
	
	method oro(capo){
		capo.getBando().agregaTesoro(0)
	}
	method carbon(capo){
		capo.getBando().agregaReserva(0)
	}
	//CORRECCION: estos mensajes deben ser ordenes. no deben devolver nada
	method valorLucha(capo) = capo.incrementaLucha()
	method valorHechiceria(capo) = capo.incrementaHechiceria()
		
}