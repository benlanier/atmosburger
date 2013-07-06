package ;


import nme.Assets;
import nme.display.Bitmap;
import nme.display.GradientType;
import nme.display.Shape;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.geom.Matrix;
import nme.Lib;


/**
 * @author 
 */
class AtmosBurger extends Sprite {
	
	var burger:Burger;
	
	public function new () {
		
		super ();
		
		initialize ();
	}
	
	
	private function initialize ():Void {
		
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		Lib.current.stage.frameRate = 0;
		
		var skymatrix:Matrix = new Matrix();
		skymatrix.createGradientBox(Lib.stage.width, Lib.stage.height, Math.PI/2);
		var skysquare:Shape = new Shape();
		skysquare.graphics.beginGradientFill(GradientType.LINEAR, [0x6aa5e5, 0x59f8e7], [1, 1], [0, 255], skymatrix);
		skysquare.graphics.drawRect(0, 0, Lib.stage.width, Lib.stage.height);
		addChild(skysquare);
		
		var restaurant:Bitmap = new Bitmap(Assets.getBitmapData("assets/small/restaurant.png"));
		restaurant.x = Lib.stage.width / 2 - restaurant.width / 2;
		restaurant.y = Lib.stage.height - restaurant.height;
		addChild(restaurant);
		
		addChild(new BurgerPiece(Meat));
		addChild(new Claw());
		burger = new Burger();
		burger.addBurgerPiece(new BurgerPiece(BBun));
		burger.addBurgerPiece(new BurgerPiece(BBun));
		burger.addBurgerPiece(new BurgerPiece(BBun));
		burger.addBurgerPiece(new BurgerPiece(BBun));
		burger.addBurgerPiece(new BurgerPiece(BBun));
		burger.addBurgerPiece(new BurgerPiece(BBun));
		burger.addBurgerPiece(new BurgerPiece(Meat));
		burger.addBurgerPiece(new BurgerPiece(Meat));
		burger.addBurgerPiece(new BurgerPiece(Meat));
		burger.addBurgerPiece(new BurgerPiece(Meat));
		burger.addBurgerPiece(new BurgerPiece(Meat));
		burger.addBurgerPiece(new BurgerPiece(Meat));
		burger.addBurgerPiece(new BurgerPiece(Tomato));
		burger.addBurgerPiece(new BurgerPiece(Lettuce));
		burger.addBurgerPiece(new BurgerPiece(Tomato));
		burger.addBurgerPiece(new BurgerPiece(Lettuce));
		burger.addBurgerPiece(new BurgerPiece(Tomato));
		burger.addBurgerPiece(new BurgerPiece(Lettuce));
		burger.addBurgerPiece(new BurgerPiece(SBun));
		burger.addBurgerPiece(new BurgerPiece(SBun));
		burger.addBurgerPiece(new BurgerPiece(SBun));
		burger.addBurgerPiece(new BurgerPiece(SBun));
		burger.addBurgerPiece(new BurgerPiece(SBun));
		burger.addBurgerPiece(new BurgerPiece(SBun));
		addChild(burger);
	}
	
	
	
	
	// Entry point
	
	
	
	
	public static function main () {
		
		Lib.current.addChild (new AtmosBurger ());
		
	}
	
	
}