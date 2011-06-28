package com.pipe
{
	import com.pipe.core.Game;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class Pipe extends MovieClip
	{
		private var _game:Game;
		
		public function Pipe() 
		{
			_game = new Game();
			addChild(_game)
		}
		
		public function get game():Game 
		{
			return _game;
		}
		
		public function set game(value:Game):void 
		{
			_game = value;
		}
		
	}

}