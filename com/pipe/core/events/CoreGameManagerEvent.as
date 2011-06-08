package pipe.core.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class CoreGameManagerEvent extends Event 
	{
		public static const GAME_WIN:String = "game-win";
		public static const GAME_LOSE:String = "game-losese";
		public static const CHANGE_PIECE:String = "game-losese";
		
		public function CoreGameManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new CoreGameManagerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("CoreGameManagerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}