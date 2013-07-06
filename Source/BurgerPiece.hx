package ;
import nme.display.Sprite;
import nme.display.Bitmap;
import  nme.Assets;

/**
 * ...
 * @author 
 */
class BurgerPiece extends Sprite
{

	public function new() 
	{
		super();
		addChild(new Bitmap(Assets.getBitmapData("assets/bbun.png")));
	}
	
}