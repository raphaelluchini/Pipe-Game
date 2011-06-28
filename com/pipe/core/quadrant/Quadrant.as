package pipe.core.quadrant 
{
	import pipe.core.piece.Piece;
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class Quadrant
	{
		protected var _id:int;
		protected var _xRef:int;
		protected var _yRef:int;
		
		/**
		 * This class can contains the piece added;
		 */
		public function Quadrant() 
		{
			
		}
		
		/**
		 * Returns the id of this quadrant
		 */
		public function get id():int 
		{
			return _id;
		}
		
		/**
		 * Set the id of this quadrant
		 */
		public function set id(value:int):void 
		{
			_id = value;
		}
		
		/**
		 * Returns the X reference of this quadrant across others
		 */
		public function get xRef():int 
		{
			return _xRef;
		}
		
		/**
		 * Set the X reference of this quadrant across others
		 */
		public function set xRef(value:int):void 
		{
			_xRef = value;
		}
		
		/**
		 * Returns the Y reference of this quadrant across others
		 */
		public function get yRef():int 
		{
			return _yRef;
		}
		
		/**
		 * Set the Y reference of this quadrant across others
		 */
		public function set yRef(value:int):void 
		{
			_yRef = value;
		}
		
	}

}