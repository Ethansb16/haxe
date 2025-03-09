package tokenizer.impl;

import haxe.macro.Expr.Error;
import haxe.Exception;
import parser.Sexp;

class LeafTBuilder implements TokenBuilder {
    private static final NUMBER_STARTER = ~/^[0-9\+-]$/;
    private static final STRING_STARTER = ~/^"$/;
    private static final SYMBOL_STARTER = ~/^[^\[\](){}]$/;

    private final stringBuilder:StringBuf;
    private final tokenType:TokenType;

    public function new(openedBy:String) {
        this.stringBuilder = new StringBuf();
        if (NUMBER_STARTER.match(openedBy)) {
            this.tokenType = NUMBER;
            this.stringBuilder.add(openedBy);
        } else if (STRING_STARTER.match(openedBy)) {
            this.tokenType = STRING;
        } else if (SYMBOL_STARTER.match(openedBy)) {
            this.tokenType = SYMBOL;
            this.stringBuilder.add(openedBy);
        } else {
            throw new Exception('QWJZ: Invalid char to start TreeT "$openedBy"');
        }
    }

    public function append(value:Sexp):Void {
        switch value {
            case LeafT(string):
                this.stringBuilder.add(string);
            case TreeT(_):
                throw new Exception('QWJZ: cannot tokenize $value to a leaf');
        }
    }

    public function getTokenType():TokenType {
        return this.tokenType;
    }

    public function getClosingChars():Array<String> {
        return this.tokenType == STRING
            ? Tokenizer.STRING_DELIMITERS
            : Tokenizer.TOKEN_DELIMITERS;
    }

    public function build():Sexp {
        return this.tokenType == STRING
            ? LeafT('"${this.stringBuilder.toString()}"')
            : LeafT(this.stringBuilder.toString());
    }
}
