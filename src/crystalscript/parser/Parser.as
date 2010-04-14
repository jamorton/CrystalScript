package crystalscript.parser 
{
	import crystalscript.parser.ast.AstNode;
	import crystalscript.parser.ast.AstNodeType;
	import crystalscript.parser.ast.BranchNode;
	import crystalscript.parser.ast.LeafNode;
	import crystalscript.parser.exception.UnexpectedTokenException;
	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class Parser 
	{
		
		
		/**
		 * NOTE: next() etiquette! Always leave the current token on the
		 *       FIRST token of the grammar rule function you are
		 *       recursing to. Always leave the current token on the token
		 *       AFTER your grammar rule's last token when returning from a
		 *       function.
		 */
		
		private var _tok  : Tokenizer;
		private var _tree : BranchNode;
		
		public function Parser(source:String)
		{
			_tok  = new Tokenizer(source);
			_tree = new BranchNode(AstNodeType.ROOT_NODE);
		}
		
		public function parse():void 
		{
			_tok.next();
			block(_tree);
		}
		
		/**
		 * block ::= {statement}
		 */
		private function block(ctx:BranchNode):void  
		{ 
			//var bn:BranchNode = new BranchNode(AstNodeType.BLOCK)
			//ctx.children.push(bn);
			while (statement(ctx));
		}
		
		/**
		 * @return has block ended
		 * 
		 * statement ::= assignment  | function_call | if_block |
		 *               loop_block | while_block | breakStmt |
		 *               continueStmt | returnStmt
		 */
		private function statement(ctx:BranchNode):Boolean
		{
			// all statements begin with an identifier (not on purpose though)
			//_tok.expect(TokenType.IDENTIFIER);
			switch (_tok.token.type) 
			{
				case TokenType.IF:
					ifBlock(ctx);
					break;
					
				case TokenType.WHILE:
					whileBlock(ctx);
					break;
					
				case TokenType.LOOP:
					loopBlock(ctx);
					break;
					
				case TokenType.EOF:
					return false;
					
				case TokenType.BREAK:
					ctx.children.push(
						new LeafNode("break", AstNodeType.BREAK));
					return false;
					
				case TokenType.CONTINUE:
					ctx.children.push(
						new LeafNode("break", AstNodeType.CONTINUE));
					return false;
					
				case TokenType.RETURN:
					returnStmt(ctx);
					return false;
					
				case TokenType.END:
					return false;
					
				// function call or assignment
				default:
					var nex:Token = _tok.peek();
					if (nex.type == TokenType.EQUAL)
						assignment(ctx);
					else if (nex.type == TokenType.LPAREN)
						functionCall(ctx);
					else {
						throw new UnexpectedTokenException(_tok.token);
						return false;
					}
						
					break;
			}
			
			return true;
		}
		
		/**
		 * assignment    ::= Identifier '=' expression
		 */
		private function assignment(ctx:BranchNode):void 
		{
			var bn:BranchNode = new BranchNode(AstNodeType.ASSIGNMENT);
			ctx.children.push(bn);
			bn.children.push(new LeafNode(_tok.token.value, AstNodeType.IDENTIFIER));
			_tok.next(); // SKIP identifier
			_tok.next(); // SKIP '='
			expression(bn);
		}
		
		/**
		 * function_call ::= Identifier '(' [expression] {',' expression} ')'
		 */
		private function functionCall(ctx:BranchNode):void 
		{
			var bn:BranchNode = new BranchNode(AstNodeType.FUNCTION_CALL);
			ctx.children.push(bn);
			bn.children.push(new LeafNode(_tok.token.value, AstNodeType.IDENTIFIER));
			
			_tok.next(); // SKIP identifier
			_tok.next(); // SKIP '('
			
			while (_tok.token.type != TokenType.RPAREN) 
			{
				expression(bn);
				if (_tok.token.type == TokenType.COMMA)
					_tok.next(); // SKIP ','
			}
			_tok.next(); // SKIP ')'
		}
		
		/**
		 * if_block      ::= 'if' expression block 'end'
		 */
		private function ifBlock(ctx:BranchNode):void 
		{
			var bn:BranchNode = new BranchNode(AstNodeType.IF_BLOCK);
			ctx.children.push(bn);
			
			_tok.next(); // SKIP 'if'
			expression(bn);
			block(bn);
		}
		
		/**
		 * loop_block    ::= 'loop' block 'end'
		 */
		private function loopBlock(ctx:BranchNode):void 
		{
			var bn:BranchNode = new BranchNode(AstNodeType.LOOP_BLOCK);
			ctx.children.push(bn);
			
			_tok.next(); // SKIP 'loop'
			block(bn);
		}
		
		/**
		 * while_block   ::= 'while' expression block 'end'
		 */
		private function whileBlock(ctx:BranchNode):void 
		{
			
		}
		
		
		/**
		 * returnStmt   ::= 'return' expression
		 */
		private function returnStmt(ctx:BranchNode):void
		{
			_tok.next(); // SKIP 'return'
			var bn:BranchNode = new BranchNode(AstNodeType.RETURN);
			ctx.children.push(bn);
			expression(bn);
		}
		
		
		
		/**
		 * expression         ::= or_expression
		 * or_expression      ::= and_expression {'or' and_expression}
		 * and_expression     ::= compare_expression {'and' compare}
		 * compare_expression ::= add_expression {Comparison add_expression}
		 * add_expression     ::= mul_expression {'+' | '-' mul_expression}
		 * mul_expression     ::= unary_expression {'*' | '/' | 'mod' unary_expression}
		 * unary_expression   ::= {'not' | '-'} atom_expression
		 * atom_expression    ::= Identifier | function_call | '(' expression ')' | Literal
		 */
		
		private function expression(ctx:BranchNode):void 
		{
			
			ctx.children.push(orExpression());
		}
		
		private function orExpression():AstNode 
		{
			var ret:AstNode = andExpression();
			if (_tok.token.type == TokenType.OR) 
			{
				var bn:BranchNode = new BranchNode(AstNodeType.EXPR_OR);
				_tok.next(); // SKIP 'or'
				bn.children.push(ret);
				bn.children.push(orExpression());
				return bn;
			}
			return ret;
		}
		
		private function andExpression():AstNode 
		{
			var ret:AstNode = compareExpression();
			if (_tok.token.type == TokenType.AND) 
			{
				trace("hi");
				var bn:BranchNode = new BranchNode(AstNodeType.EXPR_AND);				
				_tok.next(); // SKIP 'and'
				bn.children.push(ret);
				bn.children.push(orExpression());
				return bn;
			}
			return ret;
		}
		
		private function compareExpression():AstNode 
		{
			var ret:AstNode = addExpression();
			var bn:BranchNode;
			switch (_tok.token.type) 
			{
				case TokenType.NOTEQUAL:
					bn = new BranchNode(AstNodeType.EXPR_COMPARE, AstNodeType.COMPARE_NOTEQ);
					break;
				case TokenType.GREATER:
					bn = new BranchNode(AstNodeType.EXPR_COMPARE, AstNodeType.COMPARE_GREATER);
					break;
				case TokenType.GREATEREQUAL:
					bn = new BranchNode(AstNodeType.EXPR_COMPARE, AstNodeType.COMPARE_GREATEQ);
					break;
				case TokenType.LESS:
					bn = new BranchNode(AstNodeType.EXPR_COMPARE, AstNodeType.COMPARE_LESS);
					break;
				case TokenType.LESSEQUAL:
					bn = new BranchNode(AstNodeType.EXPR_COMPARE, AstNodeType.COMPARE_LESSEQ);
					break;
				case TokenType.EQUALEQUAL:
					bn = new BranchNode(AstNodeType.EXPR_COMPARE, AstNodeType.COMPARE_EQUAL);
					break;
				default:
					return ret;
			}
			
			_tok.next(); // SKIP operator
			bn.children.push(ret);
			bn.children.push(orExpression());
			return bn;
		}
		
		private function addExpression():AstNode 
		{
			var ret:AstNode = mulExpression();
			var bn:BranchNode;
			if (_tok.token.type == TokenType.PLUS)
				bn = new BranchNode(AstNodeType.EXPR_ADD, AstNodeType.ADD_ADD);
			else if (_tok.token.type == TokenType.MINUS)
				bn = new BranchNode(AstNodeType.EXPR_ADD, AstNodeType.ADD_SUBTRACT);
			else
				return ret;
			
			_tok.next(); // SKIP '+' or '-'
			bn.children.push(ret);
			bn.children.push(orExpression());
			return bn;
		}
		
		private function mulExpression():AstNode 
		{
			var ret:AstNode = unaryExpression();
			var bn:BranchNode;
			if (_tok.token.type == TokenType.STAR)
				bn = new BranchNode(AstNodeType.EXPR_MUL, AstNodeType.MUL_MULTIPLTY);
			else if (_tok.token.type == TokenType.SLASH)
				bn = new BranchNode(AstNodeType.EXPR_MUL, AstNodeType.MUL_DIVIDE);
			else
				return ret;
				
			_tok.next(); // SKIP '*' or '/'
			bn.children.push(ret);
			bn.children.push(orExpression());
			return bn;
		}
		
		private function unaryExpression():AstNode
		{
			var bn:BranchNode;
			if (_tok.token.type == TokenType.MINUS)
				bn = new BranchNode(AstNodeType.UNARY_NEGATE);
			else if (_tok.token.type == TokenType.NOT)
				bn = new BranchNode(AstNodeType.UNARY_NOT);
			else
				return atomExpression();
			
			_tok.next(); // SKIP '-' or 'not'
			bn.children.push(atomExpression());
			return bn;
		}

		private function atomExpression():AstNode
		{
			var ret:AstNode;
			
			// TODO: Clean this up.
			
			// identifer is either a function call or a variable.
			if (_tok.token.type ==  TokenType.IDENTIFIER)
			{
				var t:Token = _tok.peek();
				// function call
				if (t.type == TokenType.LPAREN) 
				{
					// bad hack to capture functionCall output :(
					var temp:BranchNode = new BranchNode(AstNodeType.NONE);
					functionCall(temp);
					ret =  temp.children[0];
				}
				// variable
				else 
				{
					ret = new LeafNode(_tok.token.value, AstNodeType.IDENTIFIER);
					_tok.next(); // SKIP identifier
				}
			}
			// grouping parens
			else if (_tok.token.type == TokenType.LPAREN) 
			{
				_tok.next(); // SKIP '('
				ret = orExpression();
				_tok.next(); // SKIP ')'
			}
			// number literal
			else if (_tok.token.type == TokenType.NUMBER)
			{
				ret = new LeafNode(_tok.token.value, AstNodeType.NUMBER_LITERAL);
				_tok.next(); // SKIP number literal
			}
			else
			{
				throw new UnexpectedTokenException(_tok.token);
			}
			return ret;
		}
		
		
		
		
		public function get tree():BranchNode { return _tree; }
	}
}
