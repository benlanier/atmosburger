package ;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.Assets;
import nme.events.MouseEvent;
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Linear;
import nme.Lib;
import nme.geom.Matrix;

/**
 * ...
 * @author 
 */
class Claw extends Sprite
{
	private var baseX:Float = 0;
	private var baseY:Float = 0;
	private var isOut:Bool = false;
	
	public function new() {
		super();
		var image:Bitmap = new Bitmap(Assets.getBitmapData("assets/small/claw.png"));
		
		/*var m:Matrix = new Matrix();
		m.translate(0, image.height / 2);
		this.transform.matrix = m;*/
		image.y -= image.height / 2;
		
		addChild(image);
		Lib.stage.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
	}
	
	public function onClick(event:MouseEvent) {
		if (isOut)
			return;
		
		this.rotation = Math.atan2(event.stageY - baseY, event.stageX - baseX)/(Math.PI*2) * 360;
		trace(this.rotation);
		var distance:Float = distance(baseX, baseY, event.stageX, event.stageY);
		var time:Float = distance / 750.0;
		
		setIsOut(true);
		Actuate.tween(this, time, { x: event.stageX } ).ease(Linear.easeNone);
		Actuate.tween(this, time, { y: event.stageY } ).ease(Linear.easeNone).onComplete(retract, [time]);
	}
	
	public function retract(time:Float ) {
		Actuate.tween(this, time, { x: baseX } ).ease(Linear.easeNone);
		Actuate.tween(this, time, { y: baseY } ).ease(Linear.easeNone).onComplete(setIsOut, [false]);
		
	}
	
	public function setIsOut(isOut:Bool) {
		this.isOut = isOut;
	}
	
	private function distance(x1:Float, y1:Float, x2:Float, y2:Float):Float {
		var x_ = x2 - x1;
		var y_ = y2 - y1;
		return Math.sqrt(x_ * x_ + y_ * y_);
	}
}