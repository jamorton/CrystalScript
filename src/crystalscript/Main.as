package crystalscript
{
	import crystalscript.etc.HashTable;
	import crystalscript.etc.Util;
	import crystalscript.parser.Parser;
	import crystalscript.parser.Token;
	import crystalscript.parser.Tokenizer;
	import crystalscript.parser.TokenType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import crystalscript.avm2.abc.*;
	import crystalscript.avm2.name.*;
	
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
			
			var cp:AbcConstantPool = new AbcConstantPool();
			
			cp.int32(42);
			var ns:AvmNamespaceSet = new AvmNamespaceSet();
			ns.add(new AvmNamespace(AbcInfo.CONSTANT_PackageNamespace, "fooNs"));
			cp.multiname(new AvmMultiname("foobar", ns));
			
			var bs:AbcByteStream = new AbcByteStream();
			
			cp.serialize(bs);
			
			trace(bs.toString());
			
			/*
			var source:String = "loop\na = random()\nif a == 5\na = b + 6\nend\nend";
			var parse:Parser = new Parser(source);
			parse.parse();
			
			trace(parse.tree.toString());
			*/
		}
	}
}
