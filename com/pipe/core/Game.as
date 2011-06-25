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
		private var _coreGame:CoreGame;
		private var _gameManager:CoreGameManager;
		
		public function Game() 
		{
			_coreGame = new CoreGame(500,200, SkinData.SKIN_STANDARD);
			addChild(_coreGame)
			gameManager = new CoreGameManager(_coreGame);
			gameManager.initGame();
		}
		
		public function get coreGame():CoreGame 
		{
			return _coreGame;
		}
		
		public function set coreGame(value:CoreGame):void 
		{
			_coreGame = value;
		}
		
		public function get gameManager():CoreGameManager 
		{
			return _gameManager;
		}
		
		public function set gameManager(value:CoreGameManager):void 
		{
			_gameManager = value;
		}
		
	}

}