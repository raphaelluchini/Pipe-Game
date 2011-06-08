package pipe.core 
{
	import pipe.skin.SkinData;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class Game extends Sprite
	{
		private var coreGame:CoreGame;
		private var gameManager:CoreGameManager;
		
		public function Game() 
		{
			coreGame = new CoreGame(500,200, SkinData.SKIN_DEFAULT);
			addChild(coreGame)
			gameManager = new CoreGameManager(coreGame);
			gameManager.initGame();
		}
		
	}

}