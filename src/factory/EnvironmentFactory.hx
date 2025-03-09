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
    ];

    private static final INITIAL_PRIMOPS = [
        PrimopV(new PlusPrimop()),
        PrimopV(new MinusPrimop()),
        PrimopV(new MultiplyPrimop()),
        PrimopV(new DividePrimop()),
    ];

    public static function getEnvironment():Environment {
        return Environment.empty().extend(INITIAL_SYMBOLS, INITIAL_PRIMOPS);
    }
}
