package com.pipe.core.quadrant 
{
	import com.pipe.ui.UIQuadrant;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class QuadrantStage extends Sprite
	{
		protected var _quadrantManager:QuadrantManager;
		protected var _created:Boolean;
		
		/**
		 * Class used for create the quadrants and show it.
		 */
		public function QuadrantStage() 
		{
		}
		
		/**
		 * Create the visual stageQuadrant
		 * You need set the width and height of yours quadrants
		 * All quadrants needs have the same sizes
		 * @param	xRef number of quadrants by X
		 * @param	yRef number of quadrants by Y
		 * @param	widthQuad height of quadrants by Y
		 * @param	heightQuad width of quadrants by Y
		 */
		public function createStageQuadrant(xRef:int, yRef:int, widthQuad:Number, heightQuad:Number):void 
		{
			_quadrantManager = new QuadrantManager();
			var arrManager:Array = _quadrantManager.newGame(xRef, yRef, widthQuad, heightQuad);
			
			for (var i:int = 0; i < arrManager.length; i++) 
			{
				for (var j:int = 0; j < arrManager[i].length; j++) 
				{
					var quad:UIQuadrant = arrManager[i][j] as UIQuadrant;
					quad.x = Math.round(widthQuad * i);
					quad.y = Math.round(heightQuad * j);
					addChild(quad);
				}
			}
		}
		
		public function createInitQuadrant(xRef:int, yRef:int):void
		{
			var quad:UIQuadrant = _quadrantManager.getQuadrant(xRef, yRef);
		}
		
		public function createEndQuadrant(xRef:int, yRef:int):void
		{
			
		}
		
		/**
		 * Removes and clear of memory all objects
		 */
		public function dispose():void 
		{			
			for (var i:int = 0; i < _quadrantManager.stageRef.length; i++) 
			{
				for (var j:int = 0; j < _quadrantManager.stageRef[i].length; j++) 
				{
					removeChild(_quadrantManager.stageRef[i][j]);
					_quadrantManager.stageRef[i][j] = null;
					
				}
			}
			_quadrantManager = null;
			_created
		}		
		
		/**
		 * Get the quadrant manager, used for create news quadrants, get the espeifics quadrants.
		 */
		public function get quadrantManager():QuadrantManager 
		{
			return _quadrantManager;
		}
		
		/**
		 * Returns if the quadrant is created (createStageQuadrant()).
		 */
		public function get created():Boolean 
		{
			return _created;
		}
		
	}

}