package ;
import nme.display.Sprite;
import nme.Lib;
import com.eclecticdesignstudio.motion.Actuate;

/**
 * ...
 * @author 
 */
class Burger extends Sprite
{
	private var burgerPieces:Array<BurgerPiece>;
	private var size:Float = 19;

	public function new() 
	{
		super();
		
		burgerPieces = new Array<BurgerPiece>();
		
		x = Lib.stage.width / 2;
		y = Lib.stage.height / 2 -100;
	}
	
	public function addBurgerPiece(piece:BurgerPiece) {
		piece.isFlying = false;
		piece.y = 4*size - Std.int(burgerPieces.length / 6) * size;
		piece.x = Std.int(burgerPieces.length % 6) * size + size/2;
		/*Actuate.apply(piece, { y:Std.int(burgerPieces.length / 6) * piece.height, 
							   x:Std.int(burgerPieces.length % 6) * piece.width } );*/
		//Actuate.stop(piece);
		
		burgerPieces.insert(burgerPieces.length, piece);
		addChild(piece);
	}
}