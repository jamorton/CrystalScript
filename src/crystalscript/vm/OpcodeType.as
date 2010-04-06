package crystalscript.vm
{
	import crystalscript.etc.Enum;
	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class OpcodeType extends Enum
	{

		{
			initEnum(OpcodeType);
		}
		
		/*
		   for reference:
		   cptr = the code pointer, points to next instruction to be executed.
		   R(x) = register at index x
		   CONST(X) = constant at index x
		*/
		   
		
		// No operation. For testing purposes only, this shouldn't be generated usually
		public static const NOP:OpcodeType = new OpcodeType();
		
		// R(A) = R(B)
		public static const COPY:OpcodeType = new OpcodeType();
		
		// cptr += A
		public static const JMP:OpcodeType = new OpcodeType();
		
		// if (R(A) == R(B)) { ptr += C }
		public static const EQ:OpcodeType = new OpcodeType();
		
		// if (R(A) < R(B)) { ptr += C }
		public static const LT:OpcodeType = new OpcodeType();
		
		// if (R(A) <= R(B)) { ptr += C }
		public static const LE:OpcodeType = new OpcodeType();
		
		// R(A) = CONST(B)
		public static const LCONST:OpcodeType = new OpcodeType();
		
		// R(A) = null
		public static const LNULL:OpcodeType = new OpcodeType();
		
		// R(
		
		// arithmetic
		// R(A) = R(B) [operation] R(C)
		public static const ADD:OpcodeType = new OpcodeType();
		public static const SUB:OpcodeType = new OpcodeType();
		public static const MUL:OpcodeType = new OpcodeType();
		public static const DIV:OpcodeType = new OpcodeType();
		public static const MOD:OpcodeType = new OpcodeType();
		public static const NOT:OpcodeType = new OpcodeType();
		public static const NEG:OpcodeType = new OpcodeType();
		
		
		

	}
	
}
