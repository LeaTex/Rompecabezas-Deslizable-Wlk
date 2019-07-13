import wollok.game.*

class Pieza {
	const property initialPosition
	var property position
	const property puzzle
	
	constructor(_position, _puzzle) { 
		initialPosition =  _position
		position =  _position
		puzzle = _puzzle
	}
	
	method estaBienUbicada() = return initialPosition == position

	method intercambiarPosicion(pieza) {
		var nuevaPosicion = pieza.position()
		pieza.position(self.position())
		self.position(nuevaPosicion)
	}
}

class PiezaMovible inherits Pieza {
	method image() = puzzle.level().toString() + "/" + initialPosition.x().toString() + "_" + initialPosition.y().toString() + ".png"
}

class PiezaVacia inherits Pieza {
	constructor(_position, _puzzle) = super(_position, _puzzle) {
		self.initializeKeyboard()
	}
	method image() = "emptySlot.png"
	
	method initializeKeyboard() {
		keyboard.up().onPressDo { self.moverHacia(position.down(1)) }
		keyboard.down().onPressDo { self.moverHacia(position.up(1)) }
		keyboard.left().onPressDo { self.moverHacia(position.right(1)) }
		keyboard.right().onPressDo { self.moverHacia(position.left(1)) }
	}

	method moverHacia(newPosition) {
		var objects = game.getObjectsIn(newPosition)
		if (not objects.isEmpty()) {
			self.intercambiarPosicion(objects.first())
		}
		//console.println(puzzle.estaArmado())
		if (puzzle.estaArmado()) { game.say(self, "ganaste!")}
	}
}