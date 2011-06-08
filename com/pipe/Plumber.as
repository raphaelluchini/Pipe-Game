package pipe
{
	import pipe.core.Game;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class Plumber extends MovieClip
	{
		
		public function Plumber() 
		{
			var game:Game = new Game();
			addChild(game)
		}
		
	}

}