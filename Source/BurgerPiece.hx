package ;

import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Expo;
import com.eclecticdesignstudio.motion.easing.Linear;
import com.eclecticdesignstudio.motion.easing.Quad;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.Assets;
import nme.events.Event;

enum Ingredient {
	BBun;
	Meat;
	Lettuce;
	Tomato;
	SBun;
}

/**
 * ...
 * @author 
 */
class BurgerPiece extends Sprite
{

	public function new(i:Ingredient) 
	{
		super();
		var bm:Bitmap;
		switch (i) {
			case BBun:
				bm = new Bitmap(Assets.getBitmapData("assets/small/bbun.png"));
			case Meat:
				bm = new Bitmap(Assets.getBitmapData("assets/small/meat.png"));
			case Lettuce:
				bm = new Bitmap(Assets.getBitmapData("assets/small/lettuce.png"));
			case Tomato:
				bm = new Bitmap(Assets.getBitmapData("assets/small/tomato.png"));
			case SBun:
				bm = new Bitmap(Assets.getBitmapData("assets/small/sbun.png"));
		}
		bm.x = -bm.width / 2;
		bm.y = -bm.height / 2;
		addChild(bm);
		bobDown(1.0);
		Actuate.tween(this, 100.0, { x: this.x + 800 } ).ease(Linear.easeNone);
	}
	
	private function bobDown(time:Float) {
		Actuate.tween(this, time, { y: this.y + 25 } ).ease(Quad.easeInOut).onComplete(bobUp, [time]);
	}
	
	private function bobUp(time:Float) {
		Actuate.tween(this, time, { y: this.y - 25 } ).ease(Quad.easeInOut).onComplete(bobDown, [time]);
	}
	
}