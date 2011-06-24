package pipe.ui 
{
	import pipe.core.piace.Piece;
	import pipe.core.piace.PiecePathName;
	import pipe.core.piace.PieceType;
	import pipe.skin.Skin;
	import pipe.ui.UIObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class UIPiece extends MovieClip
	{
		private var _piaceData:Piece;
		private var _isDrag:Boolean;
		private var _isInteractive:Boolean;
		private var _skin:UIObject;
		protected var _pieceType:String;
		private var addedOnStage:Boolean;
		
		/**
		 * Set the type of pice
		 * @param	piece type
		 */
		public function UIPiece(type:String = "normal-piece") 
		{
			_isInteractive = isInteractive;
			_piaceData = new Piece();
			
			_skin = Skin.piece();
			addChild(_skin);
			
			setPieceType(type);
			
			this.mouseChildren = false;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		/**
		 * Dispatched when remove from stage
		 * @param	event
		 */
		private function onRemovedFromStage(event:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			addedOnStage = false;
		}
		
		/**
		 * Dispatched when added to Stage
		 * add listeners of interaction if have permition
		 * @param	event
		 */
		private function onAddedToStage(event:Event):void 
		{
			addedOnStage = true;
			if (isInteractive)
			{
				addInteraction();
			}
		}
		
		/**
		 * Add the listeners for mouse interactions
		 */
		private function addInteraction():void 
		{
			if (_isInteractive)
			{
				removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
				this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				this.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUps);
			}
		}
		
		/**
		 * Remove the listeners for mouse iterations
		 */
		private function killInteraction():void
		{
			if (addedOnStage)
			{
				stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUps);
			}
			this.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.stopDrag();
			this.isDrag = false;
		}
		
		/**
		 * Dispatched when mouse up
		 * @param	event
		 */
		private function onMouseUps(event:MouseEvent):void 
		{
			this.isDrag = false;
			this.removeEventListener(Event.ENTER_FRAME, onDrag);
		}
		
		/**
		 * Dispatched when mouse down
		 * @param	event
		 */
		private function onMouseDown(event:MouseEvent):void 
		{
			this.isDrag = true;
			this.addEventListener(Event.ENTER_FRAME, onDrag);
		}
		
		/**
		 * Loop for drag the object with mouse
		 * @param	event
		 */
		private function onDrag(event:Event):void 
		{
			if (isDrag)
			{
				this.x = stage.mouseX
				this.y = stage.mouseY
			}
		}
		
		/**
		 * Dispatched when use the Wheel of mouse
		 * Used for rotation the object
		 * @param	event
		 */
		private function onMouseWheel(event:MouseEvent):void 
		{
			if (!piaceData.isNew || isDrag)
			{
				if (event.delta > 0)
				{
					this.rotation -= 90;
					_piaceData.rotateLeft();
				}
				else
				{
					this.rotation += 90;
					_piaceData.rotateRight();
				}
			}
		}
		
		/**
		 * Get type of piece ( PieceType.as )
		 * @see PieceType.as
		 * @return nae of type
		 */
		public function getPieceType():String 
		{
			return _pieceType;
		}
		
		/**
		 * Set the type of piece ( PieceType.as )
		 * @see PieceType.as
		 * @param value
		 */
		public function setPieceType(value:String):void 
		{
			_pieceType = value;
			
			switch (_pieceType) 
			{
				
				case PieceType.FINISH:
				{
					_skin.gotoAndStop(4);
					_piaceData.isNew = false;
					_isInteractive = false;
					this.killInteraction();
					break;
				}
				case PieceType.START:
				{
					_skin.gotoAndStop(4);
					_piaceData.isNew = false;
					_isInteractive = false;
					this.killInteraction();
					break;
				}
				default:
				{
					_piaceData.isNew = true;
					_isInteractive = true;
					_skin.gotoAndStop(_piaceData.pathNumber + 1);
					break;
				}
			}
		}
		
		/**
		 * Execute the animations 
		 * @param	side of enter liquid
		 */
		public function executePiece(side:int):void
		{
			this.isInteractive = false;
			if (_piaceData.pathName == PiecePathName.ONE_LINE || _piaceData.pathName == PiecePathName.ONE_CURVE)
			{
				if (_piaceData.rotationNumber != side)
				{
					_skin.animation.gotoAndPlay("init_1");
				}
				else
				{
					_skin.animation.gotoAndPlay("init_2");
				}
			}
			else if (_piaceData.pathName == PiecePathName.TWO_CURVES)
			{				
				var paths:Array = [ { path:1, side:2 }, { path:2, side:1 }, { path:2, side:2 }, { path:1, side:1 } ];
				var value:Number = side - _piaceData.rotationNumber;
				if (value < 0)
				{
					value = value + 4;
				}
				
				if(paths[value].path == 1)
				{
					_skin.animation.gotoAndPlay("init_" + paths[value].side);
				}
				else if(paths[value].path == 2)
				{
					_skin.animation1.gotoAndPlay("init_" + paths[value].side);
				}
			}
		}
		
		/**
		 * Get the data of piece
		 */
		public function get piaceData():Piece 
		{
			return _piaceData;
		}
		
		/**
		 * Set the data of piece
		 */
		public function set piaceData(value:Piece):void 
		{
			_piaceData = value;
		}
		
		/**
		 * Defines if this is interative
		 */
		public function get isInteractive():Boolean 
		{
			return _isInteractive;
		}
		
		/**
		 * Set if this is interative
		 */
		public function set isInteractive(value:Boolean):void 
		{
			_isInteractive = value;
			if (_isInteractive == true)
			{
				if (addedOnStage)
				{
					addInteraction();
				}
			}
			else
			{
				killInteraction();
			}
		}
		
		/**
		 * Get if the object in drag mode
		 */
		public function get isDrag():Boolean 
		{
			return _isDrag;
		}
		
		/**
		 * Set if the object in drag mode
		 */
		public function set isDrag(value:Boolean):void 
		{
			_isDrag = value;
		}
		
	}

}