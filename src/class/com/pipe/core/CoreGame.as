package com.pipe.core 
{
	import com.pipe.core.piece.PieceFactory;
	import com.pipe.core.piece.PieceType;
	import com.pipe.core.quadrant.Quadrant;
	import com.pipe.core.quadrant.QuadrantManager;
	import com.pipe.core.quadrant.QuadrantStage;
	import com.pipe.skin.Skin;
	import com.pipe.ui.UIPiece;
	import com.pipe.ui.UIQuadrant;
	import com.utils.DepthManager;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * GameCore is reponsable of controls the pieces and quadrant stage.
	 * @author Raphael Luchini
	 */
	public class CoreGame extends QuadrantStage 
	{
		private var _piece:UIPiece;
		private var _pieceX:Number;
		private var _pieceY:Number;
		private var cacheX:Number;
		private var cacheY:Number;
		private var cacheQuadrant:UIQuadrant;
		private var cachePiece:UIPiece;
		
		/**
		 * The constructor method needs the piece x and y for know where the pieces is added
		 */
		public function CoreGame(pieceX:Number, pieceY:Number) 
		{
			_pieceY = pieceY;
			_pieceX = pieceX;
		}
		
		/**
		 * Create a piece using the class UIPiece.
		 * The piece have automatically a listeners
		 * @return a UIPiece
		 */
		public function createPiece():UIPiece 
		{
			_piece = PieceFactory.createRandomPiece();
			_piece.x = _pieceX;
			_piece.y = _pieceY;
			
			_piece.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
			addChild(_piece);
			return _piece
		}
		
		/**
		 * On mouse down this method remove pice of quadrant(if added)
		 * Bring to Top the piece
		 * Cache the positions and old quadrant(if added)
		 * @param	event
		 */
		private function mDown(event:MouseEvent):void 
		{
			var currentPiece:UIPiece = event.currentTarget as UIPiece;
			if (currentPiece.isInteractive)
			{
				stage.addEventListener(MouseEvent.MOUSE_UP, mUp);
				cachePiece = event.currentTarget as UIPiece;
				DepthManager.bringToTop(currentPiece);
				cacheX = currentPiece.x;
				cacheY = currentPiece.y;
				
				var xGrid:int = quadrantManager.quadrantsWidth;
				var yGrid:int = quadrantManager.quadrantsHeight;
				var xQuadRef:int = Math.floor(stage.mouseX / xGrid);
				var yQuadRef:int = Math.floor(stage.mouseY / yGrid);
				
				cacheQuadrant = quadrantManager.getQuadrant(xQuadRef, yQuadRef);
				if (cacheQuadrant)
				{
					cacheQuadrant.piece = null;
				}
			}
		}
		
		/**
		 * Create the initial piece, where the game starts
		 * @param	xRef
		 * @param	yRef
		 * @return the same piece object
		 */
		public function createInitPiece(xRef:int, yRef:int):UIPiece 
		{
			var initPiece:UIPiece = PieceFactory.createInitPiece();
			addChild(initPiece);
			var quad:UIQuadrant = quadrantManager.getQuadrant(xRef, yRef);
			addToQuadrant(initPiece, quad);
			return initPiece
		}
		
		/**
		 * Create the finish piece, where the game ends
		 * @param	xRef
		 * @param	yRef
		 * @return the same piece object
		 */
		public function createFinishPiece(xRef:int, yRef:int):UIPiece 
		{
			var initPiece:UIPiece = PieceFactory.createFinishPiece();
			addChild(initPiece);
			var quad:UIQuadrant = quadrantManager.getQuadrant(xRef, yRef);
			addToQuadrant(initPiece, quad);
			return initPiece
		}
		
		
		/**
		 * OnMouseUp listener os UIPiece created
		 * When this method dispatched, the piece loses all listners if added in a quadrant
		 * @param	event
		 */
		private function mUp(event:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, mUp);
			var xGrid:int = quadrantManager.quadrantsWidth;
			var yGrid:int = quadrantManager.quadrantsHeight;
			var xQuadRef:int = Math.floor(cachePiece.x / xGrid);
			var yQuadRef:int = Math.floor(cachePiece.y / yGrid);
			
			var quad:UIQuadrant = quadrantManager.getQuadrant(xQuadRef, yQuadRef);
			//verifica se está dentro do quadrant
			if (quad != null)
			{
				if (quad.piece == null)
				{
					addToQuadrant(cachePiece, quad);
				}
				else
				{
					cachePiece.x = cacheX;
					cachePiece.y = cacheY;
					if (cacheQuadrant)
					{
						cacheQuadrant.piece = cachePiece;
					}
				}
			}
			else
			{
				cachePiece.x = cacheX;
				cachePiece.y = cacheY;
				if (cacheQuadrant)
				{
					cacheQuadrant.piece = cachePiece;
				}
			}
			cacheQuadrant = null;
			cachePiece = null;
		}
		
		/**
		 * Adds the piece at defined quadrant
		 * @param	piece UIPiece
		 * @param	xRef Quadrant xRef
		 * @param	yRef Quadrant yRef
		 */
		public function addToQuadrant(piece:UIPiece, quad:UIQuadrant):void
		{
			piece.x = quad.x + (piece.width / 2);
			piece.y = quad.y + (piece.height / 2);
			
			quad.piece = piece;
			
			if (piece.pieceData.isNew)
			{
				piece.pieceData.isNew = false;
				createPiece();
			}
		}
	}
}