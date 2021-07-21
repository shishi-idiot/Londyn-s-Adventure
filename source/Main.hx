package;

import flixel.FlxGame;
import flixel.util.FlxColor;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	var framerate:Int = 60; // How many frames per second the game should run at.

	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, PlayState));
	}
}
