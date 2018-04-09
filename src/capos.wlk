

object rolando {
	
	var property valorBaseLucha = 3
	var property valorBaseHechiceria = 1
	var artefactos = #{}
	
	
	method valorLucha() = valorBaseLucha + artefactos.sum({artefacto=> artefacto.valorExtraLucha()})
	
	method valorHechiceria() = valorBaseHechiceria + artefactos.sum({artefacto=> artefacto.valorExtraHechiceria(self)})
	
	
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
	
	method valorExtraHechiceria(capo) = capo.valorBaseHechiceria()
}

object collarDivino {
	
	method valorExtraLucha() = 1
	
	method valorExtraHechiceria(capo) = 1
}


//////////////////// ARTEFACTOS AVANZADOS ///////////////////

object armadura{
	
	var property valorTotalLucha = 2
	var property valorTotalHechiceria = 0
	
	method valorExtraLucha()= valorTotalLucha
	
	method valorExtraHechiceria(capo) = valorTotalHechiceria
	
	method agregarRefuerzo(refuerzo, capo){
		self.resetearValores()
		refuerzo.sumarRefuerzo(capo)
	}
	
	method calcularHechizo(capo){
		if (capo.valorBaseHechiceria() > 3){valorTotalHechiceria += 2}
			else valorTotalHechiceria += 0
	}
	
	method resetearValores(){
		valorTotalLucha = 2
		valorTotalHechiceria = 0
	}
}

object cotaDeMalla{
	
	method sumarRefuerzo(capo){
		armadura.valorTotalLucha(3) 
	}
}

object bendicion{
	
	method sumarRefuerzo(capo){
		armadura.valorTotalHechiceria(1) 
	}
}
object hechizo{
	
	method sumarRefuerzo(capo){
		armadura.calcularHechizo(capo) 
	}
}
