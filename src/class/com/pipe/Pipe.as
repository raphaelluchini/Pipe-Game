package com.pipe
{
	import com.pipe.core.events.CoreGameManagerEvent;
	import com.pipe.core.Game;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class Pipe extends MovieClip
	{
		private var _game:Game;
		private var _status:TextField;
		
		public function Pipe(stage:Stage, status:TextField)
		{
			_status = status;
			_game = new Game(stage);
			_game.addEventListener(Game.START, function() {
				game.gameManager.addEventListener(CoreGameManagerEvent.CHANGE_PIECE, onChangePiece);
				game.gameManager.addEventListener(CoreGameManagerEvent.HAVENT_NEXT_PIECE, onHaventPiece);
				game.gameManager.addEventListener(CoreGameManagerEvent.GAME_LOSE, onLose);
				game.gameManager.addEventListener(CoreGameManagerEvent.GAME_WIN, onWin);
				addChild(_game)
			})
		}
		
		public function get game():Game 
		{
			return _game;
		}
		
		public function set game(value:Game):void 
		{
			_game = value;
		}
		private function onHaventPiece(e:CoreGameManagerEvent):void 
		{
			_status.text = "Haven't Piece";
		}
		
		private function onWin(e:CoreGameManagerEvent):void 
		{
			_status.text = "You Win";
		}
		
		private function onLose(e:CoreGameManagerEvent):void 
		{
			_status.text = "Game Over";
		}
		
		private function onChangePiece(e:CoreGameManagerEvent):void 
		{
			_status.text = "Goto next piece";
		}
		
	}

}