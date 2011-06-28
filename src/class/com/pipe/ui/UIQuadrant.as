package com.pipe.ui 
{
	import com.pipe.core.quadrant.Quadrant;
	import com.pipe.skin.Skin;
	import flash.display.MovieClip;
	/**
	 * The visual object of quadrants
	 * @author Raphael Luchini
	 */
	public class UIQuadrant extends MovieClip
	{
		private var _quadrantData:Quadrant;
		private var _piece:UIPiece;
		private var _skin:UIObject;
		
		/**
		 * Constructor method adds the current skin
		 */
		public function UIQuadrant() 
		{
			_skin = Skin.quadrant();
			addChild(_skin)
		}
		
		/**
		 * Get the Quadrant object, he have data informations
		 */
		public function get quadrantData():Quadrant 
		{
			return _quadrantData;
		}
		
		/**
		 * Set the Quadrant object, he have data informations
		 */
		public function set quadrantData(value:Quadrant):void 
		{
			_quadrantData = value;
		}
		
		/**
		 * Get the UIPiece object added in UIQuadrant
		 */
		public function get piece():UIPiece 
		{
			return _piece;
		}
		
		/**
		 * Set the UIPiece object in UIQuadrant
		 */
		public function set piece(value:UIPiece):void 
		{
			_piece = value;
		}
		
		
	}

}