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

	public function new() 
	{
		super();
		addChild(new Bitmap(Assets.getBitmapData("assets/meat.png")));
		Lib.stage.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
	}
	
	public function onClick(event:MouseEvent)
	{
		
		Actuate.tween(this, 1, { x: event.stageX } ).ease(Linear.easeNone);
		Actuate.tween(this, 1, { y: event.stageY } ).ease(Linear.easeNone);
	}
}