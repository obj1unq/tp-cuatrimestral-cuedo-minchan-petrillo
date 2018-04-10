object rolando {
	
	var valorBaseLucha = 3
	var valorBaseHechiceria = 1
	var artefactos = #{}
	var bando = bandoDelSur
	
	method getArtefactos() = artefactos
	
	method valorLuchaBase() = valorBaseLucha
	
	method valorHechiceriaBase() = valorBaseHechiceria
	
	method incrementaLucha() { valorBaseLucha += 1}
	
	method incrementaHechiceria() { valorBaseHechiceria += 1}
	
	method valorLucha() = valorBaseLucha + artefactos.sum{artefacto=> artefacto.valorLucha(self)}
	
	method valorHechiceria() = valorBaseHechiceria + artefactos.sum{artefacto=> artefacto.valorHechiceria(self)}
	
	method getBando() = bando
	
	method encontrarElemento(elem){
		
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
	
	method mejorArtefacto(capo) = 

	 return if( capo.getArtefactos().size()>=1)
     
       (self.artefactosSinEspejo(capo)).max({artefacto=>artefacto.valorHechiceria(capo)+ artefacto.valorLucha(capo)})
        
       		else self
       	
	method artefactosSinEspejo(capo) {
       	
       	return capo.getArtefactos().filter({artefacto=>artefacto!=self})
       	
       	}

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

object bandoDelSur{
	
	var tesoro = 0
	var reserva = 0
	
	method getReserva() = reserva
	method getTesoro() = tesoro
	
	method agregaTesoro(ctd){ tesoro += ctd}
	method agregaReserva(ctd){ reserva += ctd}
	
}

object cofrecito {
	
	method oro(capo){
		capo.getBando().agregaTesoro(100)
	}
	method carbon(capo){
		capo.getBando().agregaReserva(0)
	}
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
	method valorLucha(capo) = capo.incrementaLucha()
	method valorHechiceria(capo) = capo.incrementaHechiceria()
		
}



