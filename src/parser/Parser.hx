package parser;

import haxe.Exception;

class Parser {
    public static function parse(token:Sexp):ExprC {
        switch token {
            case TreeT([LeafT("if"), condition, ifTrue, ifFalse]):
                // Parse {if cond true false}
                return IfC(parse(condition), parse(ifTrue), parse(ifFalse));
            case TreeT([LeafT("proc"), TreeT(rawIds), rawBody]):
                // Parse {proc {id*} body}
                final ids = ParseUtils.sexpsToIds(rawIds);
                final body = parse(rawBody);
                return ProcC(ids, body);
            case TreeT([LeafT("declare"), TreeT(declarations), LeafT("in"), rawBody]):
                final clauses = declarations.map(x -> new ClauseC(x));
                return AppC(ProcC(clauses.map(x -> x.symbol), parse(rawBody)),
                            clauses.map(x -> x.value));
            case TreeT(nodes):
                // Parse {expr expr*}
                if (nodes.length == 0) {
                    fail(token);
                }

                final parsed = nodes.map(parse);

                return AppC(parsed[0], parsed.slice(1));
            case LeafT(value):
                // Parse standalone leaf
                return parseLeafT(value);
        }
    }

    private static function parseLeafT(value:String):ExprC {
        if (ParseUtils.isNumeric(value)) {
            return NumC(Std.parseFloat(value));
        }

        if (ParseUtils.isId(value)) {
            return IdC(value);
        }

        if (ParseUtils.isString(value)) {
            // This removes the wrapping quotes
            final regexp = ~/^"(.*)"$/;
            regexp.match(value);
            return StringC(regexp.matched(1));
        }

        throw new Exception('QWJZ: cannot parse $value');
    }

    private static function fail(sexp:Sexp) {
        throw new Exception('QWJZ: Invalid expression $sexp');
    }
}
