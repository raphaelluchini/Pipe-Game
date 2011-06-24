package com 
{
	import com.pixelbreaker.ui.osx.MacMouseWheel;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class Main extends MovieClip
	{
		
		public function Main() 
		{
			MacMouseWheel.setup( this.stage );
		}
		
	}

}