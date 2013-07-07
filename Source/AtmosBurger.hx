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
import nme.media.Sound;

/**
 * @author 
 */
class AtmosBurger extends Sprite {

	private var currentScene:Sprite;
	private static var _instance:AtmosBurger;
	
	private var applause:Sound;
	
	public function new () {
		
		super ();
		
		initialize ();
	}
	
	
	private function initialize ():Void {
		
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		Lib.current.stage.frameRate = 0;
		
		applause = Assets.getSound("assets/sound/applause.mp3");
		
		currentScene = new TitleScene();
		addChild(currentScene);
	}
	
	public function changeScene(to:Sprite) {
		removeChild(currentScene);
		currentScene = to;
		addChild(currentScene);
	}
	
	public function applaud() {
		applause.play();
	}
	
	// ugh
	public static function Game():AtmosBurger {
		return _instance;
	}
	
	public static function main () {
		
		_instance = new AtmosBurger();
		Lib.current.addChild (_instance);
		
	}
	
	
}