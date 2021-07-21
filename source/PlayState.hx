package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import openfl.display.FPS;

class PlayState extends FlxState
{
	var _player:FlxSprite;
	var ground:FlxSprite;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var coins:FlxTypedGroup<Coin>;

	override public function create()
	{
		trace('BOOTED UP BABY');

		FlxG.camera.fade(FlxColor.BLACK, 1, true);

		FlxG.sound.playMusic('assets/music/cavern.ogg');

		var bg:FlxSprite = new FlxSprite();
		bg.loadGraphic('assets/images/bg.png');
		add(bg);

		map = new FlxOgmo3Loader('assets/data/cavern.ogmo', 'assets/data/cavern.json');
		walls = map.loadTilemap('assets/images/tiles.png', 'walls');
		walls.follow();
		walls.setTileProperties(1, FlxObject.ANY);
		walls.setTileProperties(2, FlxObject.NONE);
		add(walls);

		_player = new FlxSprite(200, 200);
		_player.loadGraphic('assets/images/londyn.png', true, 100, 100);
		add(_player);

		coins = new FlxTypedGroup<Coin>();
		add(coins);

		map.loadEntities(placeEntities, 'entities');

		_player.acceleration.y = 600;

		FlxG.camera.follow(_player, TOPDOWN, 1);

		super.create();
	}

	function placeEntities(entity:EntityData):Void
	{
		if (entity.name == "player")
		{
			_player.setPosition(entity.x, entity.y);
		}
		else if (entity.name == "coin")
		{
			coins.add(new Coin(entity.x + 4, entity.y + 4));
		}
	}

	function playerOverlapsCoins(_player:FlxSprite, coins:Coin)
	{
		coins.kill();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(_player, walls);
		FlxG.overlap(_player, coins, playerOverlapsCoins);

		if (FlxG.keys.pressed.RIGHT)
		{
			_player.x += 1;
			_player.flipX = false;
		}

		if (FlxG.keys.pressed.LEFT)
		{
			_player.x -= 1;
			_player.flipX = true;
		}

		if (FlxG.keys.pressed.SPACE)
		{
			_player.y -= 10;
		}
	}
}
