import wollok.game.*
import piezas.*

class Puzzle {
	var property level
	var property piezas
	
	constructor(_level) { 
		level = _level
		piezas = []
		self.initialize()
	}
	
	method initialize() {
		(0..3).forEach { f =>
			(0..3).forEach { c =>
				if ((f != 0) or (c != 3)) { piezas.add(new PiezaMovible(new Position(c,f), self)) }
				else { piezas.add(new PiezaVacia(new Position(c,f), self)) }
			}
		}
	}
	
	method estaArmado() {
		return piezas.all({ p => p.estaBienUbicada() })
	}
	
	method mezclar() {
		piezas.forEach { p =>
			var i = 0.randomUpTo(piezas.size()-1).roundUp(0)
			var piezaDestino = piezas.get(i)
			p.intercambiarPosicion(piezaDestino)
		}
	}
}
