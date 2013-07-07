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
	
	public function getLength():Int {
		return burgerPieces.length;
	}
	
	public function new() 
	{
		super();
		
		burgerPieces = new Array<BurgerPiece>();
		
		x = Lib.stage.width / 2 + 150;
		y = Lib.stage.height - size*4.5;
	}
	
	public function addBurgerPiece(piece:BurgerPiece) {
		//Actuate.tween(piece, 1, { x: Std.int(burgerPieces.length % 6) * size + size/2,
		//							y: 4 * size - Std.int(burgerPieces.length / 6) * size } );
		piece.y = 4*size - Std.int(burgerPieces.length / 6) * size;
		piece.x = Std.int(burgerPieces.length % 6) * size + size/2;
		
		burgerPieces.push(piece);
		addChild(piece);
	}
}