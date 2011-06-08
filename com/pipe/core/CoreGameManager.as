package pipe.core 
{
	import pipe.core.events.CoreGameManagerEvent;
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
		private var finishQuadrant:Array = [7, 7];
		
		/**
		 * Current quadrand to verify.
		 */
		private var currentQuad:UIQuadrant;
		
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
			timer = new Timer(4000);
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
			var nextQuad:UIQuadrant = quadrantManager.getNext(currentQuad);
			if (nextQuad.piace)
			{
				if (verificatonOfPaths(currentQuad.piace, nextQuad.piace))
				{
					if (nextQuad.piace.piaceData.path[1] != -1)
					{
						currentQuad = nextQuad;
						currentQuad.piace.isInteractive = false;
						dispatchEvent(new CoreGameManagerEvent(CoreGameManagerEvent.CHANGE_PIECE));
					}
					else
					{
						timer.stop();
						dispatchEvent(new CoreGameManagerEvent(CoreGameManagerEvent.GAME_WIN));
						trace("Winner - Game Over")
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
		
		/**
		 * Varifys if the path of 2 pieces have comunication.
		 * @param	p1
		 * @param	p2
		 * @return if have or no a comunication in paths
		 */
		private function verificatonOfPaths(p1:UIPiece, p2:UIPiece):Boolean 
		{
			(p1.piaceData.pathNumEnter == 0) ? p1.piaceData.pathNumEnter = 1 : p1.piaceData.pathNumEnter = 0;
			var p1NumExit:int = p1.piaceData.path[p1.piaceData.pathNumEnter];
			var p2NumEnter:int = 0;
			
			//opposite side of piece
			if ((p1NumExit + 2) > 3)
			{
				p2NumEnter = ((p1NumExit + 2) - 4);
			}
			else
			{
				p2NumEnter = p1NumExit + 2;
			}
			
			for (var i:int = 0; i < p2.piaceData.path.length; i++) 
			{
				if (p2.piaceData.path[i] == p2NumEnter)
				{
					p2.piaceData.pathNumEnter = i;
					return true;
				}
			}
			return false
		}
		
	}

}