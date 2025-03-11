package factory;

import interpreter.impl.*;
import interpreter.Value;
import interpreter.Environment;

class EnvironmentFactory {
    private static final INITIAL_SYMBOLS = [
        "+",
        "-",
        "*",
        "/",
        "<=",
        "read-str",
        "read-num",
        "equal?", 
        "++", 
        "seq"
    ];

    private static final INITIAL_PRIMOPS = [
        PrimopV(new PlusPrimop()),
        PrimopV(new MinusPrimop()),
        PrimopV(new MultiplyPrimop()),
        PrimopV(new DividePrimop()),
        PrimopV(new LeqPrimop()),
        PrimopV(new ReadStrPrimop()),
        PrimopV(new ReadNumPrimop()),
        PrimopV(new EqualPrimop()), 
        PrimopV(new JoinPrimop()), 
        PrimopV(new SeqPrimop()) 
    ];

    public static function getEnvironment():Environment {
        return Environment.empty().extend(INITIAL_SYMBOLS, INITIAL_PRIMOPS);
    }
}
