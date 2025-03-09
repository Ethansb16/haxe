package parser;

import haxe.Exception;

class ClauseC {
    public final symbol:String;
    public final value:ExprC;

    public function new(clause:Sexp) {
        switch clause {
            case TreeT([LeafT(symbol), value]):
                this.symbol = symbol;
                this.value = Parser.parse(value);
            case _:
                throw new Exception('QWJZ: cannot parse clause $clause');
        }
    }
}
