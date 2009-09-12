package crystalscript.avm2.name 
{
	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class Avm2Namespace 
	{
		
		public var kind:uint = 0;
		public var name:uint = 0;
		
		public function Avm2Namespace(tkind:uint, tname:uint) 
		{
			kind = tkind;
			name = tname;
		}
		
		public function hash():String 
		{
			return kind + "." + name;
		}
		
	}
	
}
