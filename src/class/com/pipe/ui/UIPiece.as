﻿package com.pipe.ui 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.pipe.core.piece.Piece;
	import com.pipe.core.piece.PieceFactory;
	import com.pipe.core.piece.PieceType;
	import com.pipe.skin.Skin;
	import flash.utils.getTimer;
	import org.libspark.ui.SWFWheel;
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class UIPiece extends MovieClip
	{
		private var _pieceData:Piece;
		private var _isDrag:Boolean;
		private var _isInteractive:Boolean;
		private var _skin:MovieClip;
		protected var _pieceType:String;
		private var addedOnStage:Boolean;
		
		/**
		 * Set the type of pice
		 * @param	piece type
		 */
		public function UIPiece(pieceData:Piece, type:String = "normal-piece") 
		{
			_pieceData = pieceData;
			
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
				SWFWheel.initialize(stage);
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
			if (!pieceData.isNew || isDrag)
			{
				if (event.delta > 0)
				{
					this.rotation -= 90;
					_pieceData.rotateLeft();
				}
				else
				{
					this.rotation += 90;
					_pieceData.rotateRight();
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
					_pieceData.isNew = false;
					_isInteractive = false;
					this.killInteraction();
					break;
				}
				case PieceType.START:
				{
					_pieceData.isNew = false;
					_isInteractive = false;
					this.killInteraction();
					break;
				}
				default:
				{
					_pieceData.isNew = true;
					_isInteractive = true;
					break;
				}
			}
			_skin.gotoAndStop(_pieceData.pathName);
		}
		
		/**
		 * Execute the animations 
		 * @param	side of enter liquid
		 */
		public function executePiece(side:int):void
		{
			this.isInteractive = false;
			if (_pieceData.pathName == PieceFactory.ONE_LINE_NAME || _pieceData.pathName == PieceFactory.ONE_CURVE_NAME)
			{
				if (_pieceData.rotationNumber != side)
				{
					_skin.animation.gotoAndPlay("init_1");
				}
				else
				{
					_skin.animation.gotoAndPlay("init_2");
				}
			}
			else if (_pieceData.pathName == PieceFactory.TWO_CURVES_NAME)
			{				
				var paths:Array = [ { path:1, side:2 }, { path:2, side:1 }, { path:2, side:2 }, { path:1, side:1 } ];
				var value:Number = side - _pieceData.rotationNumber;
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
			else if (_pieceData.pathName == PieceFactory.START_NAME || _pieceData.pathName == PieceFactory.FINISH_NAME)
			{
				_skin.animation.gotoAndPlay("init");
			}
		}
		
		/**
		 * Get the data of piece
		 */
		public function get pieceData():Piece 
		{
			return _pieceData;
		}
		
		/**
		 * Set the data of piece
		 */
		public function set pieceData(value:Piece):void 
		{
			_pieceData = value;
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