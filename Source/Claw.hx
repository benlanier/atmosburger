package ;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.Assets;
import nme.events.MouseEvent;
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Linear;
import nme.Lib;
import nme.geom.Matrix;
import nme.events.Event;

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
		image.x = 0;
		image.y = - image.height / 2;
		addChild(image);
		
		baseX = Lib.stage.width / 2;
		baseY = Lib.stage.height - 200;
		x = baseX;
		y = baseY;
		
		Lib.stage.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		Lib.stage.addEventListener(Event.ENTER_FRAME, update);
	}
	
	public function onClick(event:MouseEvent) {
		if (isOut)
			return;
			
		// Rotate around base
		//this.transform.matrix.translate(-baseX, -baseY);
		//this.transform.matrix.rotate(Math.atan2(event.stageY - baseY, event.stageX - baseX));
		//this.transform.matrix.translate(baseX, baseY);
		this.rotation = Math.atan2(event.stageY - baseY, event.stageX - baseX) / Math.PI * 180;
		if (this.rotation > 0)
		{
			if(this.rotation < 90)
				this.rotation = 0;
			else
				this.rotation = 180;
		}
		
		// Calculate travel time
		var distance:Float = distance(baseX, baseY, event.stageX, event.stageY);
		var time:Float = distance / 750.0;
		
		setIsOut(true);
		Actuate.tween(this, time, { x: event.stageX } ).ease(Linear.easeNone);
		
		if (event.stageY > baseY) {
			Actuate.tween(this, time, { y: baseY } ).ease(Linear.easeNone).onComplete(retract, [time]);
		}
		else {
			Actuate.tween(this, time, { y: event.stageY } ).ease(Linear.easeNone).onComplete(retract, [time]);
		}
	}
	
	public function retract(time:Float ) {
		Actuate.tween(this, time, { x: baseX } ).ease(Linear.easeNone);
		Actuate.tween(this, time, { y: baseY } ).ease(Linear.easeNone).onComplete(setIsOut, [false]);
	}
	
	public function update(event:Event) {
		if (!isOut)
		{
			var angle:Float = Math.atan2(Lib.stage.mouseY - baseY, Lib.stage.mouseX - baseX) / Math.PI * 180;
			if (angle > 0)
			{
				if(angle < 90)
					angle = 0;
				else
					angle = 180;
			}
			this.rotation = angle;
		}
		else
		{
			graphics.clear();
			graphics.moveTo(0, 0);
			graphics.lineTo(x, y);
		}
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