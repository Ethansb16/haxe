package interpreter;

import haxe.exceptions.NotImplementedException;
import parser.ExprC;

class Interpreter {
    public static function topInterp(expr:ExprC):String {
        final value = interp(expr);

        return serialize(value);
    }

    private static function serialize(value:Value):String {
        switch value {
            case NumV(n):
                return '$n';
            case StringV(string):
                return '"$string"';
            case _:
                throw new NotImplementedException("Cannot serialize $value");
        }
    }

    private static function interp(expr:ExprC):Value {
        switch expr {
            case NumC(n):
                return NumV(n);
            case StringC(string):
                return StringV(string);
            case _:
                throw new NotImplementedException("");
        }
    }
}
