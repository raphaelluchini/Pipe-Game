package 
{
	import com.pixelbreaker.ui.osx.MacMouseWheel;
	import flash.display.MovieClip;
	import pipe.core.events.CoreGameManagerEvent;
	import pipe.Pipe;
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class Main extends MovieClip
	{
		
		public function Main() 
		{
			MacMouseWheel.setup( this.stage );
			
			var pipeGame:Pipe = new Pipe();
			addChild(pipeGame);
			pipeGame.game.gameManager.addEventListener(CoreGameManagerEvent.CHANGE_PIECE, onChangePiece);
			pipeGame.game.gameManager.addEventListener(CoreGameManagerEvent.HAVENT_NEXT_PIECE, onHaventPiece);
			pipeGame.game.gameManager.addEventListener(CoreGameManagerEvent.GAME_LOSE, onLose);
			pipeGame.game.gameManager.addEventListener(CoreGameManagerEvent.GAME_WIN, onWin);
		}
		
		private function onHaventPiece(e:CoreGameManagerEvent):void 
		{
			status.text = "Haven't Piece";
		}
		
		private function onWin(e:CoreGameManagerEvent):void 
		{
			status.text = "You Win";
		}
		
		private function onLose(e:CoreGameManagerEvent):void 
		{
			status.text = "Game Over";
		}
		
		private function onChangePiece(e:CoreGameManagerEvent):void 
		{
			status.text = "Goto next piece";
		}
		
	}

}