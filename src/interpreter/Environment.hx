package interpreter;

import interpreter.Value;
import interpreter.impl.PlusPrimop;
import haxe.Exception;
import haxe.exceptions.ArgumentException;

class Environment {
    private static final primopSymbols = ["+"];
    private static final primopValues = [PrimopV(new PlusPrimop())];

    private final symbols:Array<String>;
    private final values:Array<Value>;

    public static function baseEnvironment() {
        return new Environment(primopSymbols, primopValues);
    }

    public static function empty() {
        return new Environment([], []);
    }

    public function new(symbols:Array<String>, values:Array<Value>) {
        if (symbols.length != values.length) {
            trace('Cannot create environment with symbols of length ${symbols.length} and values of length ${values.length}');
            throw new ArgumentException("");
        }

        this.symbols = symbols;
        this.values = values;
    }

    public function extend(newSyms:Array<String>, newVals:Array<Value>) {
        final extendedSymbols = newSyms.concat(this.symbols);
        final extendedValues = newVals.concat(this.values);

        return new Environment(extendedSymbols, extendedValues);
    }

    public function lookup(symbol:String):Value {
        for (i in 0...this.symbols.length) {
            if (this.symbols[i] == symbol) {
                return this.values[i];
            }
        }

        throw new Exception('QWJZ: symbol $symbol not found');
    }
}
