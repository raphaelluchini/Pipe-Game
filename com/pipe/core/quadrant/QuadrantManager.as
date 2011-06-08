package pipe.core.quadrant 
{
	import pipe.core.piace.Piece;
	import pipe.core.piace.PieceSide;
	import pipe.ui.UIPiece;
	import pipe.ui.UIQuadrant;
	/**
	 * This class manage all quadrants objects
	 * @author Raphael Luchini
	 */
	public class QuadrantManager
	{
		/**
		 * Matrix with quadrants refrencies
		 */
		protected var _stageRef:Array;
		
		/**
		 * The quadrants widths
		 */
		protected var _quadrantsWidth:Number;
		
		/**
		 * The quadrants heights
		 */
		protected var _quadrantsHeight:Number;
		
		/**
		 * The Number of quadrant by X or stageRef.length
		 */
		protected var _quadrantsNumX:int;
		
		/**
		 * The Number of quadrant by Y or stageRef[i].length
		 */
		protected var _quadrantsNumY:int;
		
		/**
		 * Create a matrix of quadrant with numbers of quadrants by X (xRef) and Y(yRef)
		 * You need set the width and height of yours quadrants
		 * All quadrants needs have the same sizes
		 * @param	xRef number of quadrants by X
		 * @param	yRef number of quadrants by Y
		 * @param	widthQuad height of quadrants by Y
		 * @param	heightQuad width of quadrants by Y
		 * @return Array of quadrants
		 */
		public function newGame(xRef:int, yRef:int, widthQuad:Number, heightQuad:Number):Array
		{
			_quadrantsNumX = xRef;
			_quadrantsNumY = yRef;
			
			_stageRef = [];
			var counterId:int = 0;
			for (var i:int = 0; i < xRef; i++) 
			{
				_stageRef[i] = [];
				for (var j:int = 0; j < yRef; j++) 
				{
					var quad:Quadrant = new Quadrant();
					var uiQuadrant:UIQuadrant = new UIQuadrant();
					quad.id = counterId;
					quad.xRef = i;
					quad.yRef = j;
					uiQuadrant.quadrantData = quad;
					_stageRef[i].push(uiQuadrant);
					counterId += 1;
				}
			}
			_quadrantsWidth  = widthQuad;
			_quadrantsHeight = heightQuad;
			return _stageRef;
		}
		
		/**
		 * Get hte UIQuadrant with his position
		 * @param	xRef position of quadrant by X
		 * @param	yRef position of quadrant by Y
		 * @return
		 */
		public function getQuadrant(xRef:int, yRef:int):UIQuadrant
		{
			//_stageRef[xRef][yRef].gotoAndStop(2);
			if (xRef >= _stageRef.length)
			{
				return null
			}
			
			if (yRef >= _stageRef[xRef].length)
			{
				return null
			}
			
			return _stageRef[xRef][yRef];
		}
		
		/**
		 * Select the neighbors with a position
		 * Returns a array of neighbors, the index is:
		 * 0 is top
		 * 1 is left
		 * 2 is bottom
		 * 3 is right
		 * @param	xRef position of quadrant by X
		 * @param	yRef position of quadrant by Y
		 * @return array of neighbors
		 */
		public function getNeighbors(xRef:int, yRef:int):Array
		{
			var arr:Array = [
			_stageRef[xRef][yRef - 1],
			_stageRef[xRef + 1][yRef],
			_stageRef[xRef][yRef + 1],
			_stageRef[xRef - 1][yRef]
			];
			return arr;
		}
		
		/**
		 * Select the quadrant exit (with the path exit of piece)
		 * @param	quadrant
		 * @return returns the next UIQuadrant
		 */
		public function getNext(quadrant:UIQuadrant):UIQuadrant
		{
			if (quadrant.piace != null)
			{
				var quadData:Quadrant = quadrant.quadrantData;
				var nextNumEnter:int = quadrant.piace.piaceData.pathNumEnter;
				var nextNumExit:int = 1;
				if (nextNumEnter == 1)
				{
					nextNumExit = 0;
				}
				switch (quadrant.piace.piaceData.path[nextNumExit]) 
				{
					case PieceSide.TOP:
					{
						if (_stageRef[quadData.xRef] != null)
						{
							if (_stageRef[quadData.xRef][quadData.yRef - 1] != null)
							{
								_stageRef[quadData.xRef][quadData.yRef-1].gotoAndStop(3);
								return _stageRef[quadData.xRef][quadData.yRef - 1];
							}
							else
							{
								return null;
							}
						}
						else
						{
							return null;
						}
						break;
					}
					
					case PieceSide.RIGHT:
					{
						if (_stageRef[quadData.xRef + 1] != null)
						{
							if (_stageRef[quadData.xRef + 1][quadData.yRef] != null)
							{
								_stageRef[quadData.xRef+1][quadData.yRef].gotoAndStop(3);
								return _stageRef[quadData.xRef + 1][quadData.yRef];
							}
							else
							{
								return null;
							}
						}
						else
						{
							return null;
						}
						break;
					}
					
					case PieceSide.BOTTOM:
					{
						if (_stageRef[quadData.xRef] != null)
						{
							if (_stageRef[quadData.xRef][quadData.yRef + 1] != null)
							{
								_stageRef[quadData.xRef][quadData.yRef+1].gotoAndStop(3);
								return _stageRef[quadData.xRef][quadData.yRef + 1];
							}
							else
							{
								return null;
							}
						}
						else
						{
							return null;
						}
						break;
					}
					
					case PieceSide.LEFT:
					{
						if (_stageRef[quadData.xRef - 1] != null)
						{
							if (_stageRef[quadData.xRef - 1][quadData.yRef] != null)
							{
								_stageRef[quadData.xRef - 1][quadData.yRef].gotoAndStop(3);
								return _stageRef[quadData.xRef - 1][quadData.yRef];
							}
							else
							{
								return null;
							}
						}
						else
						{
							return null;
						}
						
						break;
					}
					default:
					{
						trace("Invalid Position")
						return null;
					}
				}
			}
			else
			{
				trace("Haven't Piece")
				return null;
			}
		}
		
		/**
		 * Returns the matrix with quadrants refrencies
		 */
		public function get stageRef():Array 
		{
			return _stageRef;
		}
		
		/**
		 * Get the quadrants widths
		 */
		public function get quadrantsWidth():Number 
		{
			return _quadrantsWidth;
		}
		
		/**
		 * Get the quadrants heights
		 */
		public function get quadrantsHeight():Number 
		{
			return _quadrantsHeight;
		}
		
		/**
		 * Get Number of quadrant by X or stageRef.length
		 */
		public function get quadrantsNumX():int 
		{
			return _quadrantsNumX;
		}
		
		/**
		 * Get Number of quadrant by Y or stageRef[i].length
		 */
		public function get quadrantsNumY():int 
		{
			return _quadrantsNumY;
		}
		
	}
}