class Sabio {
	
	var property puntosHechiceria = 1
	var puntoslucha = 1
	var imagen = "Sabio.png"
	
	method encontradoPor(capo){
		capo.incrementaLucha(puntoslucha) 
		capo.incrementaHechiceria(puntosHechiceria)
		game.removeVisual(self)
	}	
	
}	


class Neblina {

	var oculto = []
	var imagen = "Neblina.png"

	method encontradoPor(capo) {
		oculto.forEach({ ocultos => capo.encontrarElemento(ocultos)})
		game.removeVisual(self)
	}

}
