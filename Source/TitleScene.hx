package ;

import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.Lib;

/**
 * ...
 * @author Ben Lanier
 */
class TitleScene extends Sprite
{

	public function new() 
	{
		super();
		graphics.beginFill(0x000000);
		graphics.drawRect(0, 0, Lib.stage.width, Lib.stage.height);
		graphics.beginFill(0x00ff00);
		graphics.drawCircle(200, 200, 100);
		Lib.stage.addEventListener(MouseEvent.CLICK, startGame);
	}
	
	private function startGame(d:Dynamic) {
		
		Lib.stage.removeEventListener(MouseEvent.CLICK, startGame);
		AtmosBurger.Game().changeScene(new PlayScene());

	}
	
}