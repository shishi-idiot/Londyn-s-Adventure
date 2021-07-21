package;

import flixel.FlxSprite;

class Coin extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);

		loadGraphic('assets/images/coin.png', true, 64, 64);
	}
}
