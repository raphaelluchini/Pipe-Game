package com.pipe.skin 
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class SkinData extends EventDispatcher
	{		
		public static const SKIN_DEFAULT:String = "skin1.swf";
		public static const SKIN_STANDARD:String = "skin2.swf";
		
		public static const OBJECT_PIECE:String = "piece";
		public static const OBJECT_QUADRANT:String = "quadrant";
		
		protected static var _skinFolder:String;
		protected static var _skinLoader:Loader;
		protected static var _skin:MovieClip;
		protected static var _skinPiece:MovieClip;
		protected static var _skinQuadrant:MovieClip;
		
		public function setSkinFolder(folder:String):void
		{
			_skinFolder = folder;
		}
		
		public function getQuadrant():MovieClip
		{
			var QuadrantClass:Object = _skin.loaderInfo.applicationDomain.getDefinition("QuadrantSkin");
			_skinQuadrant = new QuadrantClass();
			return _skinQuadrant;
		}
		
		public function getPiece():MovieClip
		{
			var PieceClass:Object = _skin.loaderInfo.applicationDomain.getDefinition("PieceSkin");
			_skinPiece = new PieceClass();
			return _skinPiece;
		}
		
		public function loadSkin(source:String):void
		{
			_skinLoader = new Loader();
			_skinLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteLoadSkin);
			_skinLoader.load(new URLRequest(_skinFolder + source));
		}
		
		private function onCompleteLoadSkin(event:Event):void 
		{
			_skinLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteLoadSkin);
			_skin = MovieClip(_skinLoader.content);
			dispatchEvent(new Event(Event.COMPLETE, true))
		}
	}

}