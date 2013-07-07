package ;

import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.Lib;
import nme.Assets;
import nme.display.Bitmap;

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
		
		var bm:Bitmap = new Bitmap(Assets.getBitmapData("assets/title.png"));
		bm.x = Lib.stage.width / 2 - bm.width / 2;
		bm.y = Lib.stage.height / 2 - bm.height / 2;
		addChild(bm);
		
		Lib.stage.addEventListener(MouseEvent.CLICK, startGame);
	}
	
	private function startGame(d:Dynamic) {
		
		Lib.stage.removeEventListener(MouseEvent.CLICK, startGame);
		AtmosBurger.Game().changeScene(new PlayScene());

	}
	
}