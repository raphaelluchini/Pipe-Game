package com.pipe.skin.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class SkinEvent extends Event 
	{
		public static const ANIMATION_INIT:String = "animation-init";
		public static const ANIMATION_FINISH:String = "animation-finish";
		
		public function SkinEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new SkinEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SkinEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}