package ;

import com.eclecticdesignstudio.motion.Actuate;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.display.Shape;
import nme.events.MouseEvent;
import nme.Lib;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.geom.Rectangle;
import nme.geom.Point;

/**
 * ...
 * @author Ben Lanier
 */
class ResultsScene extends Sprite
{
	
	private var burger:Burger;

	public function new(b:Burger, flagOffset:Float) 
	{
		super();
		
		var blackBox:Shape = new Shape();
		blackBox.graphics.beginFill(0);
		blackBox.graphics.drawRect(0, 0, Lib.stage.width, Lib.stage.height);
		addChild(blackBox);
		
		Lib.stage.addEventListener(MouseEvent.CLICK, function(event:MouseEvent) {
			trace(event.stageX + ", " + event.stageY);
		});
		
		burger = new Burger(function() { }, true);
		burger.x = 50;
		burger.y = 150;
		
		// reconstruct a larbger burgebre
		
		var input:Array<BurgerPiece> = b.getBurgerPieces();
		for (p in input) {
			burger.addBurgerPiece(new BurgerPiece(p.getIngredient(), true));
		}
		
		var t:TextField = new TextField();
		var tf:TextFormat = new TextFormat();
		tf.size = 40;
		tf.color = 0xffffff;
		t.setTextFormat(tf);
		t.text = "Your burger scores...";
		t.x = 300;
		t.y = 120;
		
		var score:Float = burger.calcRating();
		
		addChild(burger);
		addChild(t);
		
		var stars:Bitmap = new Bitmap(Assets.getBitmapData("assets/stars.png"));
		stars.x = 410;
		stars.y = 245;
		stars.alpha = 0;
		addChild(stars);
		
		var starWidth:Float = stars.width / 5;
		
		// de la ghetto
		var covering:Shape = new Shape();
		covering.graphics.beginFill(0);
		covering.graphics.drawRect(0, 0, stars.width, stars.height);
		covering.x = stars.x + stars.width - (starWidth * (5 - score));
		covering.y = 245;
		addChild(covering);
		
		trace(score);
		trace(stars.width * score / 5);
		
		Actuate.tween(stars, 1.5, { alpha: 1 } );
	}
	
}