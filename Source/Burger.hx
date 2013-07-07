package ;
import nme.display.Sprite;
import nme.Lib;
import com.eclecticdesignstudio.motion.Actuate;
import BurgerPiece.Ingredient;

/**
 * ...
 * @author 
 */
class Burger extends Sprite
{
	private var burgerPieces:Array<BurgerPiece>;
	private var size:Float = 19;
	

	private var burgerFinishedCB:Void -> Void;

	public function new(cback:Void -> Void = null) 
	{
		super();
		
		burgerPieces = new Array<BurgerPiece>();
		
		x = Lib.stage.width / 2 + 150;
		y = Lib.stage.height - size * 4.5;
		
		burgerFinishedCB = cback;
	}
	
	public function calcRating():Float {
		// BBun
		var score:Float = 0;
		for (i in 0...6) {
			if (burgerPieces[i].getIngredient() == BBun)
				score += 1.25 / 6;
			else if (burgerPieces[i].getIngredient() == SBun)
				score += 0.75 / 6;
		}
		// SBun
		for (i in 6...12) {
			if (burgerPieces[i].getIngredient() == SBun)
				score += 1.25 / 6;
			else if (burgerPieces[i].getIngredient() == BBun)
				score += 0.75 / 6;
		}
		
		// Meat
		for (i in 12...18) {
			if (burgerPieces[i].getIngredient() == Meat)
				score += 1.25 / 6;
			else if (burgerPieces[i].getIngredient() == Lettuce || burgerPieces[i].getIngredient() == Tomato)
				score += 0.5 / 6;
		}
		
		// Lettuce/Tomato
		for (i in 12...18) {
			if (burgerPieces[i].getIngredient() == Lettuce || burgerPieces[i].getIngredient() == Tomato)
				score += 1.25 / 6;
			else if (burgerPieces[i].getIngredient() == Meat)
				score += 0.5 / 6;
		}
		
		return score;
	}
	
	public function addBurgerPiece(piece:BurgerPiece) {
		//Actuate.tween(piece, 1, { x: Std.int(burgerPieces.length % 6) * size + size/2,
		//							y: 4 * size - Std.int(burgerPieces.length / 6) * size } );
		piece.y = 4*size - Std.int(burgerPieces.length / 6) * size;
		piece.x = Std.int(burgerPieces.length % 6) * size + size/2;
		
		burgerPieces.push(piece);
		addChild(piece);
		
		if (burgerPieces.length == 24) {
			burgerFinishedCB();
		}
	}
}