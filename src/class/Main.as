package 
{
	import flash.display.MovieClip;
	import com.pipe.Pipe;

	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class Main extends MovieClip
	{
		
		public function Main() 
		{
			var pipeGame:Pipe = new Pipe(this.stage, this.status);
			addChild(pipeGame);			
		}		
	}
}