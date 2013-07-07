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
import nme.text.TextFieldAutoSize;
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
		
		Actuate.tween(stars, 1.5, { alpha: 1 } ).onComplete(fadeInQuote, [getMolyQuote()]);
		
		AtmosBurger.Game().applaud();
	}
	
	private function fadeInQuote(s:String) {
		var t:TextField = new TextField();
		var tf:TextFormat = new TextFormat();
		tf.size = 20;
		tf.color = 0xffffff;
		t.autoSize = TextFieldAutoSize.LEFT;
		t.width = 600;
		t.setTextFormat(tf);
		t.text = "\"" + s + "\"\n--Peter Molyneux";
		
		t.x = 50;
		t.y = 400;
		t.alpha = 0;
		addChild(t);
		
		Actuate.tween(t, 3.0, { alpha: 1 } );
	}
	
	private function getMolyQuote():String {
		var molyquotes:Array<String> = [
"I still have nightmares about holding German sausages over my head.",
"You and your girlfriend will enjoy this like you've never enjoyed\n"+"anything else in your life.",
"If you love your dog, we're gonna mess with your mind, man. You're\n"+"not going to be able to go to bed.",
"Will the first female nudity give you a success or will it turn off\n"+" the audience?",
"When you watch a film, you think why does the baddy have to lose? In\n" +
"James Bond, I always thought it's so unfair, it must have taken ages\n" +
"to build that base and think of the staffing costs!",
"The more times you die, the more you get scarred, the more ugly and\n" +
"disfigured you will look, and the more the world will react.",
"The engine isn't finished. Her buttocks are wrong.",
"If you go into battle, you could win a ginger-haired person!",
"It's easy for me to guess that people like relaxation, but was there\n" +
"a way I could measure it?",
"I'm not punishing you for button mashing; I'm rewarding you for not\n" +
"button mashing, and that is a really big distinction.",
"You can actually break someone's neck on some railing during combat.\n" +
"It could be a spike on a fence or a solid brick wall, and you'll get\n" +
"increased experience for that as well.",
"It's you Americans. There's something about nipples you hate. If this\n" +
"were Germany, we'd be romping around naked on the stage here.",
"Some people leave artwork, some people do rude things, other people\n" +
"then turn those rude things into nice things.",
"This time I'm going to make it really tough to be good. Truly being\n" +
"good is all about sacrifice. How much are you going to sacrifice to\n" +
"do good?",
"Part of the fun of dogs is they misbehave and can be enormously\n" +
"embarrassing to the owner.",
"Remember, this is a role playing game; all the different weapons\n" +
"have different music sounds and give a very individual feel to the\n" +
"combat.",
"..it is enormously contentious for us to do a game, a story, an \n" +
"experience, about a boy. You are immediately appealing to all the\n"+"dark thoughts of humanity.",
"There is an acorn, and it is a golden acorn. We're taking acorns\n"+" to the next level.",
"Pull the right trigger to see The Most Interesting Thing in the World.",
"What do you want, as a player, to be when you play football, and\n" +
"what do you want to feel when you play?",
"I used to have this chat-up line, my only chat-up line. Imagine\n"+
"you're walking on a path - what's the path like? Imagine you go\n" +
"to the woods - what does the forest look like?",
"What do the taps mean?",
"Allow players to marry each other; allow them to have children\n together.",
"You sneak that little thing in there at the end.",
"And if I really was a hero, and were in a world that was, you know,\n" +
"a world of heroes... I don't think I would be like Robin Hood. I \n" +
"think I want to keep a bit of the money. I'd give SOME away, but\n" +
"I wouldn't give it ALL away. I just think that's crazy.",
"I'm only going to make one more game, I think. And that thought – \n" +
"the thought of every ounce of my energy, every ounce of my experience,\n" +
"every mistake that I've made in every single game – if I can learn\n" +
"from that, and use that energy to make one game… that's what I'm\n" +
"trying to do. ",
"I'm angry. I'm super angry. My wife is barely talking to me now,\n" +
"because she lost a million gold coins.",
"I have to be careful what I say, there are PR policeman in the\n" +
"audience with sniper rifles.",
"When you're doing it in multiplayer, it feels incredible. I love that.",
"They could start combining magic together and switching between guns\n" +
"and swords, because they were the same.",
"The most powerful story I could possibly tell is a story that\n" +
"reminds you of your own childhood. We've all had times in our\n" +
"childhood, common experiences when we felt down, and we felt up,\n" +
"or we celebrated doing something for the first time, and I loved that\n" +
"thought.",
"Americans are all celebrating how much they hate the British at\n" +
"the moment.",
"When you rip your fingers on the screen and you tear the landscape\n" +
"apart with your physical hands, it just feels amazing, man. \n" +
"It feels amazing.",
"You can shake people's hands, you can hug them, too. We were\n" +
"inspired by the American man hug - although please don't do it\n" +
"with British people, we find the closeness of the genitalia\n" +
"really frightening.",
"I keep finding myself rejected by men, which is a new experience\n" +
"for me.",
"I think the worst time for me that I've ever had an inspirational\n" +
"idea, which was an idea for a feature in Black & White, was actually\n" +
"when I was being intimate with my wife.",
"We've got tons of graphs and data coming in, and looking at that is\n" +
"the most inspirational thing I have seen as a game designer, ever.",
"We're explorers who have just discovered this new continent of emotion.",
"I actually have an almost physical love for Microsoft.",
"I could be alone in a pub drinking a pint of bitter. Come along!",
"The British people hate successful people; that's why our newspapers\n" +
"are so successful -- because we as a nation build people up, and as\n" +
"soon as they smell success we smash them down into the ground again! ",
"The whole of your body, except for your private parts, can be scarred.\n" +
"You are clothed most of the time, but not in front of your wife,\n" +
"and not when you swim, either. Don't forget, it's the emotion of\n" +
"being scarred.",
"Freedom is... freedom can actually be boring, you've got to realize\n" +
"that.",
"If you really were free to do anything in the world, I think you'd\n" +
"end up being confused, and that's a very interesting point, a design\n" +
"point, actually.",
"I want you to think of the sword as a conductor's baton. As you're\n" +
"fighting, we'll be introducing different musical elements, the more\n" +
"successful you are. And we'll be upping the tempo of the music, the\n" +
"more abilities that you unlock. So you not only get more of a score,\n" +
"you get a cooler soundtrack.",
"I thought, if this crashes the plane, me turning my phone on, so be it",
"There's this new thing called the digital relationship: we have a\n" +
"digital relationship with players now.",
"The trouble with a lot of Hollywood stuff is—I'm so bored with it.\n" +
"James Bond, Tom Cruise—the character of the hero is locked in concrete.\n" +
"He must have a love interest, they must end up in bed, he never talks\n" +
"under torture. The only surprise is whether they're on top of a cliff\n" +
"or under water.",
"To go back to those grass roots again, and to go and get your hands so\n" +
"incredibly dirty from fiddling around.",
"You can eliminate starvation or you can double it, you can empty the\n" +
"treasury or fill it with gold and rub it all over your body?",
"If you could imagine, there was this hill completely full of people,\n" +
"like a forest of people. It was quite scary, actually.",
"You're a rebel and being this rebel, you need to get people to follow\n" +
"you, and they'll do it if you promise to do certain things – you have\n" +
"to sign a piece of paper.",
"I'm 52 years old. I have a strange attitude to life. I consider it a\n" +
"marathon that you've got to keep pushing yourself through. I just hope\n" +
"I'm coming near the end of it.",
"His purpose in life - like Asimov's laws of robotics - is not to\n" +
"aggravate you; Not to piss you off. His second thought is this: He\n" +
"absolutely loves you.",
"They seem so old-school, but three years ago we had them all over\n" +
"the place.",
"You know what this industry's like, as soon as there is the scent\n" +
"of death, everyone jumps on the hearse.",
"Simon and Dene, I worry about them. I lose sleep thinking,\n" +
"are they all right?",
"I don't think experiments should be just experiments.\n" +
"They should start becoming things.",
"I want you to experience things like unconditional love –\n" +
"that's what I'm trying to get to.",
"The fact I have to filter those friends by their skill and by what\n" +
"they're able to do... There's an incredible opportunity there.",
"I wish I had some time machine and could go back two weeks.\n" +
"You live by your mistakes, for sure.",
"The touch, the grab, the stroke, all of those things\n"+"we're going to be obsessed about."];

		return molyquotes[Std.int(Math.random() * molyquotes.length)];
	}
	
}