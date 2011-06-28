package com.pipe.skin 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class SkinData
	{
		protected static var skins:Dictionary;
		
		public static const SKIN_DEFAULT:String = "default";
		public static const SKIN_STANDARD:String = "standard";
		
		public static const OBJECT_PIECE:String = "piece";
		public static const OBJECT_QUADRANT:String = "quadrant";
		
		public static function getSkins():Dictionary
		{
			skins = new Dictionary();
			//Default
			skins[SKIN_DEFAULT + "-" + OBJECT_PIECE] = new PieceDefault();
			skins[SKIN_DEFAULT + "-" + OBJECT_QUADRANT] = new QuadrantDefault();
			//Standard
			skins[SKIN_STANDARD + "-" + OBJECT_PIECE] = new PieceStandard();
			skins[SKIN_STANDARD + "-" + OBJECT_QUADRANT] = new QuadrantStandard();
			return skins;
		}
	}

}