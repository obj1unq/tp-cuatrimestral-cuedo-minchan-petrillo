import capo.*


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
	method valorHechiceria(capo) = if (capo.valorBaseHechiceria() > 3) 2  else 0
	
}

object ninguna {
	
	method valorLucha(capo) = 0
	method valorHechiceria(capo) = 0
	
}

