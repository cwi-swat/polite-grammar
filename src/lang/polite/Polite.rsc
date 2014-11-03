module lang::polite::Polite

start syntax Program
  = {Stat "."}+ "."?
  ;
  

syntax Stat
  = Expr 
  | Name ":=" Expr 
  | "^" Expr
  ;

keyword Reserved
  = "self" | "super" | "thisContext";

start syntax Expr
  = Name
  | Literal
  | Block 
  | "self"
  | "super"
  | "thisContext"
  | bracket "(" Expr ")"
  | kw: KeywordSend
  | Expr!kw "," Name
  > right Expr!kw BinOp Expr!kw
  ;

syntax KeywordSend
  = Expr!kw "," KeywordMessage+
  | KeywordMessage+
  ;

syntax KeywordMessage
  = Name ":" Expr!kw
  ;
  
syntax Block
  = "[" {Stat "."}+ "."? "]"
  | "[" {Name ","}* "|" {Stat "."}* "."? "]"
  | "[" {Name ","}* "|" "|" {Name ","}+ "|" {Stat "."}+ "."? "]"
  ;
  
  
syntax Literal
  = Int
  | Str
  | Bool
  ;
  
syntax Bool
  = "True"
  | "False"
  ;
  
lexical Int 
  = @category="Constant" [0-9]+ !>> [0-9];

lexical Str 
  = @category="StringLiteral" [\'] (![\'] | ([\'][\']))* [\'];

syntax WhitespaceOrComment 
  = whitespace: Whitespace whitespace
  | Comment
  ;

lexical Comment 
  = @category="Comment" [\"] (![\"]|([\"][\"]))* [\"];

lexical Whitespace 
  = [\u0009-\u000D \u0020 \u0085 \u00A0 \u1680 \u180E \u2000-\u200A \u2028 \u2029 \u202F \u205F \u3000];

layout Standard = WhitespaceOrComment* !>> [\ \t\n\f\r];

syntax Name = Word+;

lexical Word = word: [a-zA-Z0-9] !<< ([a-zA-Z][0-9A-Za-z_]*) !>> [0-9A-Za-z_] \ Reserved;

lexical BinOp = [%&*+\-|\<=\>?@\\~]+ !>> [%&*+\-|\<=\>?@\\~];


