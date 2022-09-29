import fisicas.*
import cuerpos.*
import wollok.game.*

class Puntito{
	var property x
	var property y
	method position() = game.at(x,y)
	method image() = "circle_10x10.png"
}
class Punto{
	var property x
	var property y
	method position() = game.at(x,y)
	method image() = "circle_32x32.png"
}
class Particula{
	var property x
	var property y
	var property cinetica
	var property position = game.at(x,y)
	var property colisionar = {}
	
	method estaChocandoX() = x == 0 || x == juego.w()
	method estaChocandoY() = y == 0 || y == juego.h()
	method estaEnElPiso() = y == 0
	
	method image() = "circle_32x32.png"
	
	method moverse(){
		self.evaluarChoques()
		x = cinetica.actualizarX(x)
		y = cinetica.actualizarY(y)
		position = game.at(x,y)
	}
	method moverse(vx,vy){
		x += vx
		y += vy
		position = game.at(x,y)
	}
	method evaluarChoques(){
		
		if(x+cinetica.vx() < 0)
			cinetica.vx(-x)
		else if(x+cinetica.vx() > juego.w())
			cinetica.vx(juego.w() - x)
		
		if(y+cinetica.vy() < 0)
			cinetica.vy(-y)
		else if(y+cinetica.vy() > juego.h())
			cinetica.vy(juego.h()-y)
	}
	
}

object pelota{
	
	var property cuerpoCollider = new Cuerpo()
	var property position = game.at(8,15)
	var property radio = 64
	var property size = radio / juego.cellSize()
	method inicializarPelota(){
		cuerpoCollider.agregarSegmentoFy(10,15,10,18)
		cuerpoCollider.agregarSegmentoFy(9,15,9,18)
		cuerpoCollider.agregarSegmentoFy(8,16,8,17)
		cuerpoCollider.agregarSegmentoFy(11,16,11,17)
		cuerpoCollider.dibujar()
		game.addVisual(self)
	}
	//method image() = "soccer_ball_128x128.png"
	method moverse(){
		position = position.up(cuerpoCollider.dyPartLider())
		position = position.right(cuerpoCollider.dxPartLider())
	}
	
}