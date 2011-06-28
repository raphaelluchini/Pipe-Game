package  com.pipe.skin
{
	import com.pipe.ui.UIObject;
	import flash.utils.Dictionary;

	public class Skin extends SkinData
	{
		protected static var _instance:Skin;
		protected static var _canInit:Boolean = false;
		protected static var _skinName:String;
		
		public function Skin()
		{
			if (_canInit == false)
			{
				throw new Error('Skin is an singleton and cannot be instantiated.');
			}
			
			skins = getSkins();
		}
		
		public static function piece():UIObject
		{
			return getInstance().piece();
		}
		
		public static function quadrant():UIObject
		{
			return getInstance().quadrant();
		}
		
		public static function setSkinName(skinName:String):void
		{
			getInstance().setSkinName(skinName);
		}
		
		protected function quadrant():UIObject
		{
			skins = getSkins();
			return skins[_skinName +"-" + OBJECT_QUADRANT];
		}

		protected function piece():UIObject
		{
			skins = getSkins();
			return skins[_skinName +"-" + OBJECT_PIECE];
		}
		
		protected function setSkinName(skinName:String):void
		{
			_skinName = skinName;
		}
		
		protected static function getInstance():Skin
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