package ;

import nme.display.Sprite;
import nme.display.Bitmap;
import  nme.Assets;

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

	public function new(i:Ingredient=BBun) 
	{
		super();
		switch (i) {
			case BBun:
				addChild(new Bitmap(Assets.getBitmapData("assets/small/bbun.png")));
			case Meat:
				addChild(new Bitmap(Assets.getBitmapData("assets/small/meat.png")));
			case Lettuce:
				addChild(new Bitmap(Assets.getBitmapData("assets/small/lettuce.png")));
			case Tomato:
				addChild(new Bitmap(Assets.getBitmapData("assets/small/tomato.png")));
			case SBun:
				addChild(new Bitmap(Assets.getBitmapData("assets/small/sbun.png")));
		}
	}
	
}