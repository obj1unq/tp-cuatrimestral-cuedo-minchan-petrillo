

object rolando {
	
	var property valorBaseLucha = 3
	var property valorBaseHechiceria = 1
	var artefactos = #{}
	
	
	method valorLucha() = valorBaseLucha + artefactos.sum({artefacto=> artefacto.valorLucha()})
	
	method valorHechiceria() = valorBaseHechiceria + artefactos.sum({artefacto=> artefacto.valorHechiceria(self)})
	
	
	method agregarArtefacto(unArtefacto){
		artefactos.add(unArtefacto)
	}
}

object espadaDelDestino {
	
	method valorExtraLucha()= 3
	
	method valorExtraHechiceria(capo)= 0
}

object libroDeHechizos {
	
	method valorExtraLucha() = 0
	
	method valorHechiceria(capo) = capo.valorBaseHechiceria()
}

object collarDivino {
	
	method valorLucha() = 1
	
	method valorHechiceria(capo) = 1
}