

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
