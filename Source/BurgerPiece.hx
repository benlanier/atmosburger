package ;

import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Expo;
import com.eclecticdesignstudio.motion.easing.Linear;
import com.eclecticdesignstudio.motion.easing.Quad;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.Assets;
import nme.events.Event;
import nme.Lib;

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
	private var isFlying:Bool = true;
	private var phase:Float;
	private var phaseOffset:Float;
	private var amplitude:Float;
	private var baseX:Float;
	private var baseY:Float;
	private var velocityX:Float;
	private var ingredient:Ingredient;
	
	private var timeElapsed:Float = 0;
	private var timePerFrame:Float = 1.0 / 60;
	
	public function setIsFlying(isFlying:Bool) {
		this.isFlying = isFlying;
	}
	public function getIsFlying():Bool {
		return isFlying;
	}
	public function getIngredient():Ingredient {
		return ingredient;
	}
	
	public function new(i:Ingredient, isLarge:Bool = false) 
	{
		super();
		var bm:Bitmap;
		ingredient = i;
		var prefix:String = "assets/" + (isLarge ? "" : "small/");
		switch (i) {
			case BBun:
				bm = new Bitmap(Assets.getBitmapData(prefix + "bbun.png"));
			case Meat:
				bm = new Bitmap(Assets.getBitmapData(prefix + "meat.png"));
			case Lettuce:
				bm = new Bitmap(Assets.getBitmapData(prefix + "lettuce.png"));
			case Tomato:
				bm = new Bitmap(Assets.getBitmapData(prefix + "tomato.png"));
			case SBun:
				bm = new Bitmap(Assets.getBitmapData(prefix + "sbun.png"));
		}
		bm.x = -bm.width / 2;
		bm.y = -bm.height / 2;
		addChild(bm);
		
		//bobDown(1.0);
		//Actuate.tween(this, 100.0, { x: this.x + 800 } ).ease(Linear.easeNone);
		
		baseX = (Math.random() * (Lib.stage.width - width/2)) + width/2;
		baseY = Math.random() * (Lib.stage.height - 300) + 80;
		x = baseX;
		y = baseY;
		
		phase = (Math.random() * 2) + 2;
		phaseOffset = Math.random() * Math.PI / 2;
		amplitude = Math.random() * 90 + 10;
		
		velocityX = Math.random() * 250 - 125;
	}
	
	public function update(event:Event) {
		if(isFlying) {
			y = baseY + Math.sin(timeElapsed / phase * Math.PI * 2 + phaseOffset) * amplitude;
			if (x - width/2 < 0 || x + width/2 > Lib.stage.width) {
				velocityX *= -1;
			}
			x += velocityX * timePerFrame;
		}
		timeElapsed += timePerFrame;
	}
	
	private function bobDown(time:Float) {
		if(isFlying)
			Actuate.tween(this, time, { y: this.y + 25 } ).ease(Quad.easeInOut).onComplete(bobUp, [time]);
	}
	
	private function bobUp(time:Float) {
		if (isFlying)
			Actuate.tween(this, time, { y: this.y - 25 } ).ease(Quad.easeInOut).onComplete(bobDown, [time]);
	}
	
}