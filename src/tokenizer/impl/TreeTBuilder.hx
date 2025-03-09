package tokenizer.impl;

import haxe.Exception;
import parser.Sexp;

class TreeTBuilder implements TokenBuilder {
    private final children:Array<Sexp>;
    private final openedBy:String;

    public function new(openedBy:String) {
        this.children = [];
        this.openedBy = openedBy;
    }

    public function append(value:Sexp) {
        this.children.push(value);
    }

    public function build():Sexp {
        return TreeT(this.children);
    }

    public function getTokenType():TokenType {
        return PARENT;
    }

    public function getClosingChars():Array<String> {
        switch this.openedBy {
            case "{":
                return ["}"];
            case "[":
                return ["]"];
            case "(":
                return [")"];
            case _:
                throw new Exception('Invalid openedBy ${this.openedBy}');
        }
    }
}
