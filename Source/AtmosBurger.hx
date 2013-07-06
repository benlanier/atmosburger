package ;


import nme.Assets;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.Lib;


/**
 * @author 
 */
class AtmosBurger extends Sprite {
	
	
	public function new () {
		
		super ();
		
		initialize ();
		
		
	}
	
	
	private function initialize ():Void {
		
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		Lib.current.stage.frameRate = 0;
		
		var restaurant:Bitmap = new Bitmap(Assets.getBitmapData("assets/small/restaurant.png"));
		trace(restaurant.height);
		restaurant.y = Lib.stage.height - restaurant.height;
		addChild(restaurant);
		
		addChild(new BurgerPiece(Meat));
		addChild(new Claw());
	}
	
	
	
	
	// Entry point
	
	
	
	
	public static function main () {
		
		Lib.current.addChild (new AtmosBurger ());
		
	}
	
	
}