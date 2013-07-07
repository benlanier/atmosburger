package ;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.events.Event;
import nme.geom.Point;
import nme.geom.Rectangle;
import nme.Lib;

/**
 * ...
 * @author Ben Lanier
 */

typedef Anim = {
	var dt:Float; // seconds between frames
	var frames:Array<Int>; // frame numbers of spritesheet
}

class AnimSprite extends Sprite
{
	private var position:Point;
	private var source:Bitmap;
	private var _image:Bitmap;
	private var anims:Hash<Anim>;
	private var currentAnimName:String;
	private var currentFrame:Int;
	private var playing:Bool;
	private var lastFrameChangeTime:Float;
	private var frameIndex:Int;
	private var manualAnim:Bool;
	
	private var timeElapsed:Float = 0;
	private var timePerFrame:Float = 1.0 / 60;
	
	public function new(filename:String, w:Int, h:Int, isManual:Bool=false) 
	{
		super();
		width = w;
		height = h;
		source = new Bitmap(Assets.getBitmapData(filename));
		_image = new Bitmap();
		_image.width = w;
		_image.height = h;
		_image.bitmapData = new BitmapData(w, h);
		
		// hacky things just for flag
		_image.x = -2; 
		_image.y = -h; // coordinates for the point of the toothpick	
		
		anims = new Hash<Anim>();
		manualAnim = isManual;
		currentFrame = 0;
		position = new Point();
		addChild(_image);
		addEventListener(Event.ENTER_FRAME, draw);
	}
	
	public function setPosition(pos:Point)
	{
		position = pos;
	}
	
	public function addAnim(name:String, frames:Array<Int>, dt:Float) {
		var newAnim:Anim = {
			dt: dt,
			frames: frames
		};
		anims.set(name, newAnim);
	}
	
	public function playAnim(name:String) {
		var cAnim:Anim = anims.get(name);
		if (cAnim == null) {
			trace("animation " + name + " not defined");
			return;
		}
		currentAnimName = name; // this is probably stupid
		// because in draw we're not caching the current anim.
		// and getting it from Hash every draw().
		// this is an easy optimization if we ever have to do it.
		playing = true;
		currentFrame = cAnim.frames[0];
		frameIndex = 0;
	}
	
	public function setFrame(num:Int)
	{
		currentFrame = num;
	}
	
	public function draw(event:Event) {
		
		if (!manualAnim) {
			// do we need to update our frame
			var cTime:Float = timeElapsed;
			var cAnim:Anim = anims.get(currentAnimName);
			if (lastFrameChangeTime == null) {
				currentFrame = cAnim.frames[frameIndex];
				lastFrameChangeTime = cTime;
			} else if (cTime - lastFrameChangeTime > cAnim.dt) {
				frameIndex++;
				frameIndex %= cAnim.frames.length;
				currentFrame = cAnim.frames[frameIndex];
				lastFrameChangeTime = cTime;
			}
		}
		
		//_image.bitmapData.fillRect(new Rectangle(0, 0, width, height), 0x00ffffff);
		_image.bitmapData.copyPixels(source.bitmapData, new Rectangle(currentFrame * width, 0, width, height), new Point());
		
		timeElapsed += timePerFrame;
	}
	
}