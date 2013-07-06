package ;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.Assets;
import nme.events.MouseEvent;
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Linear;
import nme.geom.Point;
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
	private var isRetracting:Bool = false;
	
	private var claw:Bitmap;
	private var arm:Bitmap;
	
	private var target:Point;
	
	public function new() {
		super();
		
		arm = new Bitmap(Assets.getBitmapData("assets/small/arm.png"));
		arm.y = -arm.height/2;
		addChild(arm);
		
		claw = new Bitmap(Assets.getBitmapData("assets/small/claw.png"));
		claw.x = arm.width;
		claw.y = - claw.height / 2;
		addChild(claw);
		
		baseX = Lib.stage.width / 2;
		baseY = Lib.stage.height - 101;
		x = baseX;
		y = baseY;
		
		Lib.stage.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		Lib.stage.addEventListener(Event.ENTER_FRAME, update);
	}
	
	public function onClick(event:MouseEvent) {
		if (isOut)
			return;
			
		target = globalToLocal(new Point(event.stageX, event.stageY));
		
		// Calculate travel time
		var distance:Float = target.x - arm.width;
		var time:Float = distance / 750.0;
		
		setIsOut(true);
		Actuate.tween(claw, time, { x: target.x } ).ease(Linear.easeNone).onComplete(retract, [time]).onUpdate(drawLine);
	}
	
	public function retract(time:Float ) {
		setIsRetracting(true);
		Actuate.tween(claw, time, { x: arm.width } ).ease(Linear.easeNone).onComplete(setIsOut, [false]).onUpdate(drawLine);
	}
	
	private function drawLine() {
		graphics.clear();
		graphics.lineStyle(1);
		graphics.moveTo(arm.width, 0);
		graphics.lineTo(claw.x, 0);
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
	}
	
	public function setIsOut(isOut:Bool) {
		this.isOut = isOut;
		if (!isOut) {
			graphics.clear();
		}
	}
	public function setIsRetracting(isRetracting:Bool) {
		this.isRetracting = isRetracting;
	}
	
	private function distance(x1:Float, y1:Float, x2:Float, y2:Float):Float {
		var x_ = x2 - x1;
		var y_ = y2 - y1;
		return Math.sqrt(x_ * x_ + y_ * y_);
	}
}