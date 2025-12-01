package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class OutdatedState extends MusicBeatState
{
	public static var leftState:Bool = false;

	#if mobile
	var warnTextMobile:FlxText;
	#else
	var warnText:FlxText;
	#end
	
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		#if mobile
		warnTextMobile = new FlxText(0, 0, FlxG.width,
			"Yoo, looks like you're running an   \n
			outdated version of Mods Engine (" + MainMenuState.modsEngineVersion + "),\n
			please update to " + TitleState.updateVersion + "!\n
			Press B to proceed anyway.\n
			\n
			Thank you for using the Port!"
			32);
		warnTextMobile.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnTextMobile.screenCenter(Y);
		add(warnTextMobile);
		#else
		warnText = new FlxText(0, 0, FlxG.width,
		    "Yoo, looks like you're running an   \n
			outdated version of Mods Engine (" + MainMenuState.modsEngineVersion + "),\n
			please update to " + TitleState.updateVersion + "!\n
			Press ESCAPE to proceed anyway.\n
			\n
			Thank you for using the Port!"
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);
		#end
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			if (controls.ACCEPT) {
				leftState = true;
				CoolUtil.browserLoad("https://github.com/Engines-Team/Mods-Engine-0.6.3/releases");
			}
			else if(controls.BACK) {
				leftState = true;
			}

			#if mobile
			if(leftState)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(warnTextMobile, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						MusicBeatState.switchState(new MainMenuState());
					}
				});
			}
			#else
			if(leftState)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(warnText, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						MusicBeatState.switchState(new MainMenuState());
					}
				});
			}
			#end
		}
		super.update(elapsed);
	}
}
