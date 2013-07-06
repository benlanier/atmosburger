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

	public function new() 
	{
		super();
		
		burgerPieces = new Array<BurgerPiece>();
		
		x = Lib.stage.width / 2;
		y = Lib.stage.height / 2 -100;
	}
	
	public function addBurgerPiece(piece:BurgerPiece) {
		
		Actuate.apply(piece, { y:Std.int(burgerPieces.length / 6) * piece.height, 
							   x:Std.int(burgerPieces.length % 6) * piece.width } );
		//Actuate.stop(piece);
		burgerPieces.insert(burgerPieces.length, piece);
		addChild(piece);
	}
}