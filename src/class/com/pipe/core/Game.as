package com.pipe.core 
{
	import com.pipe.skin.Skin;
	import com.pipe.skin.SkinData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class Game extends Sprite
	{
		public static const START:String = "start";
		private var _stage:Stage;
		private var _coreGame:CoreGame;
		private var _gameManager:CoreGameManager;
		
		public function Game(stage:Stage) 
		{
			_stage = stage;
			Skin.getInstance().addEventListener(Event.COMPLETE, function() {
				_coreGame = new CoreGame(500,200);
				addChild(_coreGame)
				gameManager = new CoreGameManager(_coreGame);
				gameManager.initGame();
				dispatchEvent(new Event(Game.START, true))
			})
			
			Skin.setSkin(SkinData.SKIN_STANDARD, _stage.loaderInfo.parameters.skinFolder || "");
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