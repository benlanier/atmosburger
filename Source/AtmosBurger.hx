package ;


import com.eclecticdesignstudio.motion.easing.Quad;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.GradientType;
import nme.display.Shape;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.events.Event;
import nme.geom.Matrix;
import nme.Lib;
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Linear;

/**
 * @author 
 */
class AtmosBurger extends Sprite {
	
	var burger:Burger;
	var claw:Claw;
	var burgerPieces:Array<BurgerPiece>;
	var flag:AnimSprite;
	
	
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
		
		flag = new AnimSprite("assets/small/flag.png", 36, 108);
		flag.addAnim("wave", [0, 1], 0.1);
		flag.playAnim("wave");
		flag.x = Math.random() * Lib.stage.width * 2 / 4 + Lib.stage.width * 1 / 4; // middle half of the screen
		addChild(flag);
		
		burgerPieces = new Array<BurgerPiece>();
		
		var piece:BurgerPiece;
		for (i in 0...24) {
			if(i<6) {
				piece = new BurgerPiece(BBun);
			}
			else if(i<12) {
				piece = new BurgerPiece(Meat);
			}
			else if(i<15) {
				piece = new BurgerPiece(Tomato);
			}
			else if(i<18) {
				piece = new BurgerPiece(Lettuce);
			}
			else {
				piece = new BurgerPiece(SBun);
			}
			burgerPieces.push(piece);
			addChild(piece);
		}
		
		
		claw = new Claw();
		addChild(claw);
		
		burger = new Burger(dropFlag);
		/*burger.addBurgerPiece(new BurgerPiece(BBun));
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
		burger.addBurgerPiece(new BurgerPiece(SBun));*/
		addChild(burger);
		
		addEventListener (Event.ENTER_FRAME, update);
	}
	
	// Entry point
	public function update(event:Event) {
		for (p in burgerPieces) {
			p.update(event);
		}
		if (claw.getIsOut() && !claw.getIsRetracting()) {
			var hiti:Int = -1;
			for (i in 0...burgerPieces.length) {
				if (claw.hitTestObject(burgerPieces[i])) {
					hiti = i;
					
					burgerPieces[i].setIsFlying(false);
					
					Actuate.stop(claw);
					var time:Float = claw.retract(750);
					
					Actuate.tween(burgerPieces[i], time, { x:claw.getArmEndX(),
														   y:claw.getArmEndY() }
								 ).ease(Linear.easeNone).onComplete(burger.addBurgerPiece, [burgerPieces[i]]);
					
					break;
				}
			}
			
			if (hiti != -1) {
				burgerPieces.splice(hiti, 1);
			}
		}
	}
	
	public function dropFlag() {
		Actuate.tween(flag, 4.0, { y: Lib.stage.height } ).ease(Quad.easeIn).onUpdate(checkStabbedBurger);
		claw.removeListeners();
	}
	
	private function checkStabbedBurger() {
		burger.x = Lib.stage.mouseX - burger.width / 2;
		if (flag.y > burger.y + 19*3 && flag.x >= burger.x && flag.x <= burger.x + burger.width) {
			Actuate.stop(flag);
		}
	}
	public static function main () {
		
		Lib.current.addChild (new AtmosBurger ());
		
	}
	
	
}