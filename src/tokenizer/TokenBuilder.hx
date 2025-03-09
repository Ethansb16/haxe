package tokenizer;

import parser.Sexp;

interface TokenBuilder {
    public function append(value:Sexp):Void;
    public function build():Sexp;
    public function getClosingChars():Array<String>;
    public function getTokenType():TokenType;
}
