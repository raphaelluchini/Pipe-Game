package pipe.ui 
{
	import pipe.core.piace.Piece;
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
		private var addedOnStage:Boolean;
		private var _isInteractive:Boolean;
		private var _skin:UIObject;
		private var _pieceType:String;
		
		/**
		 * Set the type of pice
		 * @param	piece type
		 */
		public function UIPiece(type:String = "normal-piece") 
		{
			_pieceType = type;
			_isInteractive = isInteractive;
			_piaceData = new Piece();
			
			_skin = Skin.piece();
			addChild(_skin);
			
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
		 * add listeners if have pemition
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
		 * Get type of piece ( PieceType.as )
		 * If is Start piece
		 * If is Finish piece
		 * If is Normal piece
		 * @return nae of type
		 */
		public function getPieceType():String 
		{
			return _pieceType;
		}
		
		/**
		 * Set the type of piece ( PieceType.as )
		 * If is Start piece
		 * If is Finish piece
		 * If is Normal piece
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
		
		public function executePiece():void
		{
			this.isInteractive = false;
			if (this._piaceData.pathNumEnter == 0)
			{
				_skin.animation.gotoAndPlay("init_2");
			}
			else if(this._piaceData.pathNumEnter == 1)
			{
				_skin.animation.gotoAndPlay("init_1");
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