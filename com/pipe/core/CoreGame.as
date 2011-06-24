package pipe.core 
{
	import pipe.core.piace.PieceType;
	import pipe.core.quadrant.Quadrant;
	import pipe.core.quadrant.QuadrantManager;
	import pipe.core.quadrant.QuadrantStage;
	import pipe.skin.Skin;
	import pipe.ui.UIObject;
	import pipe.ui.UIPiece;
	import pipe.ui.UIQuadrant;
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
		 * The cinstructor method needs the piece x and y for know where the pieces is added
		 */
		public function CoreGame(pieceX:Number, pieceY:Number, skinName:String = "default") 
		{
			Skin.setSkinName(skinName);
			_pieceY = pieceY;
			_pieceX = pieceX;
		}
		
		/**
		 * Create a piece using the class UIPiece.
		 * The piace have automatically a listeners
		 * @return a UIPiece
		 */
		public function createPiece():UIPiece 
		{
			_piece = new UIPiece();
			_piece.x = _pieceX;
			_piece.y = _pieceY;
			_piece.setPieceType(PieceType.NORMAL);
			
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
					cacheQuadrant.piace = null;
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
			var initPiece:UIPiece = new UIPiece();
			initPiece.piaceData.path = [[-1, 2]];
			initPiece.setPieceType(PieceType.START);
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
			var initPiece:UIPiece = new UIPiece();
			initPiece.piaceData.path = [[2, -1]];
			initPiece.setPieceType(PieceType.FINISH);
			addChild(initPiece);
			var quad:UIQuadrant = quadrantManager.getQuadrant(xRef, yRef);
			addToQuadrant(initPiece, quad);
			return initPiece
		}
		
		
		/**
		 * OnMouseUp listener os UIPiece created
		 * When this method dispatched, the piace loses all listners if added in a quadrant
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
				if (quad.piace == null)
				{
					addToQuadrant(cachePiece, quad);
				}
				else
				{
					cachePiece.x = cacheX;
					cachePiece.y = cacheY;
					if (cacheQuadrant)
					{
						cacheQuadrant.piace = cachePiece;
					}
				}
			}
			else
			{
				cachePiece.x = cacheX;
				cachePiece.y = cacheY;
				if (cacheQuadrant)
				{
					cacheQuadrant.piace = cachePiece;
				}
			}
			cacheQuadrant = null;
			cachePiece = null;
		}
		
		/**
		 * Adds the piace at defined quadrant
		 * @param	piece UIPiace
		 * @param	xRef Quadrant xRef
		 * @param	yRef Quadrant yRef
		 */
		public function addToQuadrant(piece:UIPiece, quad:UIQuadrant):void
		{
			piece.x = quad.x + (piece.width / 2);
			piece.y = quad.y + (piece.height / 2);
			
			quad.piace = piece;
			
			if (piece.piaceData.isNew)
			{
				piece.piaceData.isNew = false;
				createPiece();
			}
		}
	}
}