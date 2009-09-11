package crystalscript
{
	import crystalscript.etc.Util;
	import crystalscript.parser.Parser;
	import crystalscript.parser.Token;
	import crystalscript.parser.Tokenizer;
	import crystalscript.parser.TokenType;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var source:String = "loop\na = random()\nif a == 5\na = b + 6\nend\nend";
			var parse:Parser = new Parser(source);
			parse.parse();
			
			trace(parse.tree.toString());
		}
	}
}
