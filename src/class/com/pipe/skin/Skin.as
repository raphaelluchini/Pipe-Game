package  com.pipe.skin
{
	import flash.display.MovieClip;
	import flash.utils.Dictionary;

	public class Skin extends SkinData
	{
		protected static var _instance:Skin;
		protected static var _canInit:Boolean = false;
		protected static var _skinSource:String;
		
		public function Skin()
		{
			if (_canInit == false)
			{
				throw new Error('Skin is an singleton and cannot be instantiated.');
			}
		}
		
		public static function piece():MovieClip
		{
			return getInstance().getPiece();
		}
		
		public static function quadrant():MovieClip
		{
			return getInstance().getQuadrant();
		}
		
		public static function setSkin(skinSource:String, skinFolder:String = ""):void
		{
			getInstance().setSkin(skinSource, skinFolder);
		}
		
		protected function setSkin(skinSource:String, skinFolder:String = ""):void
		{
			_skinSource = skinSource;
			this.setSkinFolder(skinFolder);
			this.loadSkin(_skinSource);
		}

		public static function getInstance():Skin
		{
			if (_instance == null)
			{
				_canInit = true;
				_instance = new Skin();
				_canInit = false;
			}
			return _instance;
		}
    }
}