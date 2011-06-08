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
		protected var paths:Array = [[0, 2], [0, 1]];
		
		/**
		 * Array of selected path that contains the numerical side of their entrie and output.
		 */
		protected var _path:Array;
		
		/**
		 * Number of selected path or index in array of paths.
		 */
		protected var _pathNumber:int;
		
		/**
		 * Number of selected path or index in path in array of paths.
		 * 0 or 1
		 */
		protected var _pathNumEnter:int = 0;
		
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
			pathNumber = Math.round(randomNumber(0,1))
			path = paths[pathNumber];
		}
		
		/**
		 * Rotate paths to right
		 */
		public function rotateRight():void
		{
			for (var i:int = 0; i < paths.length; i++) 
			{
				for (var j:int = 0; j < paths[i].length; j++) 
				{
					paths[i][j] += 1;
					if (paths[i][j] > 3)
					{
						paths[i][j] = 0;
					}
				}
			}
		}
		
		/**
		 * Rotate paths to left
		 */
		public function rotateLeft():void
		{
			for (var i:int = 0; i < paths.length; i++) 
			{
				for (var j:int = 0; j < paths[i].length; j++) 
				{
					paths[i][j] -= 1;
					if (paths[i][j] < 0)
					{
						paths[i][j] = 3;
					}
				}
			}
		}
		
		/**
		 * Generates the random number with a range
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
		 * Get the number of selected path or index in path in array of paths.
		 * 0 or 1
		 */
		public function get pathNumEnter():int 
		{
			return _pathNumEnter;
		}
		
		/**
		 * Set the number of selected path or index in path in array of paths.
		 * 0 or 1
		 */
		public function set pathNumEnter(value:int):void 
		{
			_pathNumEnter = value;
		}
		

	}

}