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
	
	method valorHechiceria(capo) = capo.valorBaseHechiceria()
	
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
	//TODO Hay que mejorar la organización espacial del código
		// Esta línea tan larga dificulta la lectura.
	// También podría mejorar si usamos más delegación.
      return capo.getArtefactos().max({artefacto=>artefacto.valorHechiceria(capo) + artefacto.valorLucha(capo)})
       		
	 }

	method artefactosMenosYo(capo){
		var artefactos = capo.getArtefactos()
		
		artefactos.remove(self)
		return artefactos
	}
    
	method valorHechiceria(capo){
		var artefactos = self.artefactosMenosYo(capo)
		
		return if (!artefactos.isEmpty())	
			capo.mejorArtefacto(artefactos).valorHechiceria(capo) else 0
	}
	
	   
	method valorLucha(capo){
		var artefactos = self.artefactosMenosYo(capo)
		
		return if (!artefactos.isEmpty())	
			capo.mejorArtefacto(artefactos).valorLucha(capo) else 0
	}
	
	method encontradoPor(capo){
		capo.agregarArtefacto(self)
	}    
}
