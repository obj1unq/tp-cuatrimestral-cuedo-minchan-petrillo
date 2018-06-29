
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
