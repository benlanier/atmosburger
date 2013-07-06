package ;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.Assets;
import nme.events.MouseEvent;
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Linear;
import nme.Lib;

/**
 * ...
 * @author 
 */
class Claw extends Sprite
{
	private var baseX:Float = 0;
	private var baseY:Float = 0;
	
	public function new() {
		super();
		addChild(new Bitmap(Assets.getBitmapData("assets/small/claw.png")));
		Lib.stage.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
	}
	
	public function onClick(event:MouseEvent) {
		var distance:Float = distance(baseX, baseY, event.stageX, event.stageY);
		trace(distance);
		var time:Float = distance / 750.0;
		trace(time);
		
		Actuate.tween(this, time, { x: event.stageX } ).ease(Linear.easeNone);
		Actuate.tween(this, time, { y: event.stageY } ).ease(Linear.easeNone).onComplete(retract, [time]);
	}
	
	public function retract(time:Float ) {
		Actuate.tween(this, time, { x: baseX } ).ease(Linear.easeNone);
		Actuate.tween(this, time, { y: baseY } ).ease(Linear.easeNone);
	}
	
	private function distance(x1:Float, y1:Float, x2:Float, y2:Float):Float {
		var x_ = x2 - x1;
		var y_ = y2 - y1;
		return Math.sqrt(x_ * x_ + y_ * y_);
	}
}