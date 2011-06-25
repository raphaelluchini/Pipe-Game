package pipe.core.piace 
{
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class Piece 
	{		
		/**
		 * Array of paths that contains the numerical sides of their entries and outputs.
		 */
		protected var paths:Array = [
		[[0, 2]],
		[[0, 1]],
		[[0, 3],[1, 2]]
		];
		
		/**
		 * Array of selected path that contains the numerical side of their entrie and output.
		 */
		protected var _path:Array;
		
		/**
		 * Number of selected path or index in array of paths.
		 */
		protected var _pathNumber:int;
		
		/**
		 * The name of type path.
		 */
		protected var _pathName:String;
		
		/**
		 * The number of rotations (max 3)
		 */
		protected var _rotationNumber:int = 0;
		
		/**
		 * Defines if is a new piece (never added in a quadrant).
		 */
		protected var _isNew:Boolean = true;
		
		/**
		 * Defines if the piece was used (liquid passed)
		 */
		protected var _used:Boolean = false;
		
		
		/**
		 * Contructor method create the random path
		 */
		public function Piece() 
		{
			_pathNumber = randomNumber(0, 2);
			_path = paths[pathNumber];
			
			switch(pathNumber)
			{
				case 0:
				{
					_pathName = PiecePathName.ONE_LINE;
					break;
				}
				case 1:
				{
					_pathName = PiecePathName.ONE_CURVE;
					break;
				}
				case 2:
				{
					_pathName = PiecePathName.TWO_CURVES;
					break;
				}
			}
		}
		
		/**
		 * Search the corrent path with the enter path number
		 * @param	enter
		 * @return array
		 */
		public function searchPath(enter:int):Array
		{
			for (var i:int = 0; i < paths.length; i++) 
			{
				for (var j:int = 0; j < paths[i].length; j++) 
				{
					if (paths[i][j] == enter)
					{
						return paths[i];
					}
				}
			}
			return null;
		}
		
		/**
		 * Rotate paths to right
		 */
		public function rotateRight():void
		{
			for (var i:int = 0; i < _path.length; i++) 
			{
				for (var j:int = 0; j < _path[i].length; j++) 
				{
						_path[i][j] += 1;
						
						if (_path[i][j] > 3)
						{
							_path[i][j] = 0;
						}
				}
			}
			_rotationNumber += 1;
			if (_rotationNumber > 3)
			{
				_rotationNumber = 0;
			}
		}
		
		/**
		 * Rotate paths to left
		 */
		public function rotateLeft():void
		{
			for (var i:int = 0; i < _path.length; i++) 
			{
				for (var j:int = 0; j < _path[i].length; j++) 
				{
					_path[i][j] -= 1;
					
					if (_path[i][j] < 0)
					{
						_path[i][j] = 3;
					}
				}
			}
			_rotationNumber -= 1;
			if (_rotationNumber < 0)
			{
				_rotationNumber = 3;
			}
		}
		
		/**
		 * Generate the random number with a range
		 * @param	low
		 * @param	high
		 * @return random number with range
		 */
		public function randomNumber(low:Number=0, high:Number=1):Number
		{
		  return Math.floor(Math.random() * (1+high-low)) + low;
		}
		
		//Geters And Seters
		
		public function get isNew():Boolean 
		{
			return _isNew;
		}
		
		/**
		 * Set if is a new piece (never added in a quadrant).
		 */
		public function set isNew(value:Boolean):void 
		{
			_isNew = value;
		}
		
		/**
		 * Returns if the piece was used
		 */
		public function get used():Boolean 
		{
			return _used;
		}
		
		/**
		 * Set if the piece was used
		 */
		public function set used(value:Boolean):void 
		{
			_used = value;
		}
		
		/**
		 * Get the number of selected path or index in array of paths.
		 */
		public function get pathNumber():int 
		{
			return _pathNumber;
		}
		
		/**
		 * Set the number of selected path or index in array of paths.
		 */
		public function set pathNumber(value:int):void 
		{
			_pathNumber = value;
		}
		
		/**
		 * Get the array of selected path that contains the numerical side of their entrie and output.
		 */
		public function get path():Array 
		{
			return _path;
		}
		
		/**
		 * Set the array of selected path that contains the numerical side of their entrie and output.
		 */
		public function set path(value:Array):void 
		{
			_path = value;
		}
		
		/**
		 * Get the name of type path.
		 */
		public function get pathName():String 
		{
			return _pathName;
		}
		
		/**
		 * Set the number of rotation (max 3).
		 */
		public function get rotationNumber():int 
		{
			return _rotationNumber;
		}
		
		/**
		 * Get the the opposite side of exit
		 * else returns -1 (dont have a valid path)
		 * @param	pieceExitSide
		 * @return entrance of piece
		 */
		public function getEntraceSide(pieceExitSide:int):int
		{
			//opposite side of piece
			if ((pieceExitSide + 2) > 3)
			{
				return (pieceExitSide + 2) - 4;
			}
			else
			{
				return pieceExitSide + 2;
			}
			return -1;
		}
		
		/**
		 * With the entrance side, get the exit of path.
		 * @param	entraceSide
		 * @return the exit of path if exist a path
		 */
		public function getExitSide(entraceSide:int):int
		{
			for (var i:int = 0; i < _path.length; i++) 
			{
				for (var j:int = 0; j < _path[i].length; j++) 
				{
					if (entraceSide == _path[i][j])
					{
						var value:int = j == 0?  entraceSide = 1 : entraceSide = 0;
						return _path[i][value];
					}
				}
			}
			return -1
		}
		
		/**
		 * The number of entry path
		 * @param	entraceSide
		 * @return umber of entry path
		 */
		public function getEnterNum(entraceSide:int):int
		{
			for (var i:int = 0; i < _path.length; i++) 
			{
				for (var j:int = 0; j < _path[i].length; j++) 
				{
					if (entraceSide == _path[i][j])
					{
						return j;
					}
				}
			}
			return -1
		}
		
		/**
		 * Verify if the entrance have a path to continue
		 * @param	entranceSideNumber
		 * @return if have path in this side
		 */
		public function isEntraceSideValid(entranceSideNumber:int):Boolean
		{
			if (entranceSideNumber == -1)
			{
				return false;
			}
			

			for (var i:int = 0; i < _path.length; i++) 
			{
				for (var j:int = 0; j < _path[i].length; j++) 
				{
					if (_path[i][j] == entranceSideNumber)
					{
						return true;
					}
				}
			}
			
			return false;
		}

	}

}