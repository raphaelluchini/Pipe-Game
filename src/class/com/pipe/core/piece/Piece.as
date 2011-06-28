package com.pipe.core.piece 
{
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class Piece 
	{
		/**
		 * Array of selected path that contains the numerical side of their entrie and output.
		 */
		protected var _path:Array;
		
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
		public function Piece(path:Array, pathName:String) 
		{
			_path = path;
			_pathName = pathName;
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