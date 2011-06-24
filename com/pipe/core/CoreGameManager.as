package pipe.core 
{
	import pipe.core.events.CoreGameManagerEvent;
	import pipe.core.piace.Piece;
	import pipe.core.piace.PieceType;
	import pipe.core.quadrant.QuadrantManager;
	import pipe.ui.UIPiece;
	import pipe.ui.UIQuadrant;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * This class is reponsable for verify and process the game.
	 * @author Raphael Luchini
	 */
	public class CoreGameManager extends EventDispatcher
	{
		private var _coreGame:CoreGame;
		private var timer:Timer;
		
		private var quadrantManager:QuadrantManager;
		/**
		 * Reference of initial quadrant for initial piece.
		 */
		private var initQuadrant:Array = [2, 2];
		
		/**
		 * Reference of finish quadrant for finish piece.
		 */
		private var finishQuadrant:Array = [3, 2];
		
		/**
		 * Current quadrand to verify.
		 */
		private var currentQuad:UIQuadrant;
		
		private var currentExit:int;
		private var currentEntrance:int;
		private var nextEntrance:int 
		/**
		 * Constructor method is necessary for create the CoreGameManager.
		 * @param	needs the coreGame for create and manege the pieces/quadrants
		 */
		public function CoreGameManager(coreGame:CoreGame) 
		{
			_coreGame = coreGame;		
		}
		
		/**
		 * Init a especif game
		 */
		public function initGame():void
		{
			_coreGame.createStageQuadrant(10, 10, 40, 40);
			_coreGame.createInitPiece(initQuadrant[0], initQuadrant[1]);
			_coreGame.createFinishPiece(finishQuadrant[0], finishQuadrant[1]);
			_coreGame.createPiece();
			quadrantManager = _coreGame.quadrantManager
			initVerification();
		}
		
		/**
		 * Inities varifications of pieces
		 */
		public function initVerification():void 
		{
			timer = new Timer(3000);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			currentQuad = quadrantManager.getQuadrant(initQuadrant[0], initQuadrant[1]);
			timer.start();
		}
		
		/**
		 * This loop used to start and process the game.
		 * @param	event
		 */
		private function onTimer(event:TimerEvent):void 
		{			
			if (currentQuad.piace.getPieceType() == PieceType.START)
			{
				currentEntrance = currentQuad.piace.piaceData.path[0][0];
				currentExit = currentQuad.piace.piaceData.path[0][1];
			}
			else
			{
				currentEntrance = nextEntrance;
				currentExit = currentQuad.piace.piaceData.getExitSide(currentEntrance);
			}
			
			nextEntrance = currentQuad.piace.piaceData.getEntraceSide(currentExit);
			
			var nextQuad:UIQuadrant = quadrantManager.getNext(currentQuad, currentExit);
			if (nextQuad.piace)
			{
				if (nextQuad.piace.piaceData.isEntraceSideValid(nextEntrance))
				{
					if (nextQuad.piace.getPieceType() == PieceType.FINISH)
					{
						timer.stop();
						dispatchEvent(new CoreGameManagerEvent(CoreGameManagerEvent.GAME_WIN));
						trace("Winner - Game Over")
					}
					else
					{
						currentQuad = nextQuad;
						nextQuad = null;
						currentQuad.piace.executePiece(nextEntrance);
						dispatchEvent(new CoreGameManagerEvent(CoreGameManagerEvent.CHANGE_PIECE));
						trace("Next Piece")
					}		
				}
				else
				{
					timer.stop();
					dispatchEvent(new CoreGameManagerEvent(CoreGameManagerEvent.GAME_LOSE));
					trace("Wrong piece - Game Over")
				}
			}
			else
			{
				timer.stop();
				dispatchEvent(new CoreGameManagerEvent(CoreGameManagerEvent.GAME_LOSE));
				trace("Haven't piece - Game Over")
			}
		}
		
	}

}