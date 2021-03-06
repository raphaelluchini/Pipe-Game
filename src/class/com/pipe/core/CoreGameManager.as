package com.pipe.core 
{
	import com.pipe.skin.events.SkinEvent;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import com.pipe.core.events.CoreGameManagerEvent;
	import com.pipe.core.piece.PieceType;
	import com.pipe.core.quadrant.QuadrantManager;
	import com.pipe.ui.UIQuadrant;
	/**
	 * This class is reponsable for verify and process the game.
	 * @author Raphael Luchini
	 */
	public class CoreGameManager extends EventDispatcher
	{
		/**
		* Duration of piece animation in ms
		*/
		public var pieaceTime:Number = 3000;
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
		private var finishQuadrant:Array = [5, 4];
		
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
			timer = new Timer(pieaceTime);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			currentQuad = quadrantManager.getQuadrant(initQuadrant[0], initQuadrant[1]);
			currentQuad.piece.executePiece(-1);
			timer.start();
		}
		
		/**
		 * This loop used to start and process the game.
		 * @param	event
		 */
		private function onTimer(event:TimerEvent):void 
		{
			if (currentQuad.piece.getPieceType() == PieceType.START)
			{
				currentEntrance = currentQuad.piece.pieceData.path[0][0];
				currentExit = currentQuad.piece.pieceData.path[0][1];
				
			}
			else
			{
				currentEntrance = nextEntrance;
				currentExit = currentQuad.piece.pieceData.getExitSide(currentEntrance);
			}
			
			nextEntrance = currentQuad.piece.pieceData.getEntraceSide(currentExit);
			
			var nextQuad:UIQuadrant = quadrantManager.getNext(currentQuad, currentExit);
			if (nextQuad.piece)
			{
				if (nextQuad.piece.pieceData.isEntraceSideValid(nextEntrance))
				{
					if (nextQuad.piece.getPieceType() == PieceType.FINISH)
					{
						nextQuad.piece.executePiece(-1);
						timer.stop();
						dispatchEvent(new CoreGameManagerEvent(CoreGameManagerEvent.GAME_WIN));
					}
					else
					{
						currentQuad = nextQuad;
						nextQuad = null;
						currentQuad.piece.executePiece(nextEntrance);
						dispatchEvent(new CoreGameManagerEvent(CoreGameManagerEvent.CHANGE_PIECE));
					}
					
				}
				else
				{
					timer.stop();
					dispatchEvent(new CoreGameManagerEvent(CoreGameManagerEvent.GAME_LOSE));
				}
			}
			else
			{
				timer.stop();
				dispatchEvent(new CoreGameManagerEvent(CoreGameManagerEvent.HAVENT_NEXT_PIECE));
			}
		}
	}

}