package crystalscript.parser 
{
	import crystalscript.etc.Enum;
	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class Opcode extends Enum
	{

		{
			initEnum(Opcode);
		}

		public static const NOP:Opcode = new Opcode();
	}
	
}
