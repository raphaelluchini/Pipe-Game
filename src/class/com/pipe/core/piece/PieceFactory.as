package com.pipe.core.piece 
{
	import flash.sampler.NewObjectSample;
	import com.pipe.ui.UIPiece;
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class PieceFactory 
	{
		public static const ONE_LINE_NAME:String = "one-line";
		public static const TWO_LINES_NAME:String = "two-lines";
		public static const ONE_CURVE_NAME:String = "one-curve";
		public static const TWO_CURVES_NAME:String = "two-curves";
		
		public static const START_NAME:String = "start";
		public static const FINISH_NAME:String = "finish";
		
		/**
		 * Create the finish piece, where the game ends
		 * @return the same piece object
		 */
		public static function createFinishPiece():UIPiece 
		{
			var FINISH_PATH:Array = [[2, -1]];
			
			return new UIPiece(new Piece(FINISH_PATH, FINISH_NAME), PieceType.FINISH)
		}
		
		/**
		 * Create the initial piece, where the game starts
		 * @return the same piece object
		 */
		public static function createInitPiece():UIPiece 
		{
			var START_PATH:Array = [[-1, 2]];
			
			return new UIPiece(new Piece(START_PATH,  START_NAME), PieceType.START)
		}
		
		/**
		 * Create a random piece using the class UIPiece.
		 * @return a UIPiece
		 */
		public static function createRandomPiece():UIPiece 
		{
			var oneLine:Array = [[0, 2]];
			var oneCurve:Array = [[0, 1]];
			var twoCurves:Array = [[0, 3], [1, 2]];
		
			var paths:Array = [oneLine, oneCurve, twoCurves];
			var paths_names:Array = [ONE_LINE_NAME, ONE_CURVE_NAME, TWO_CURVES_NAME];
			
			var rand:int = randNumber(0, paths.length-1);
			var path:Array = paths.concat();
			return new UIPiece(new Piece(path[rand], paths_names[rand]), PieceType.NORMAL);
		}
		
		/**
		 * Generate the random number with a range
		 * @param	low
		 * @param	high
		 * @return random number with range
		 */
		public static function randNumber(low:Number = 0, high:Number = 1):int
		{
			return Math.floor(Math.random() * (1+high-low)) + low;
		}
		
	}

}