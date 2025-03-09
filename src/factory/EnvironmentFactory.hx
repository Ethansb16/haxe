package factory;

import interpreter.impl.*;
import interpreter.Value;
import interpreter.Environment;

class EnvironmentFactory {
    private static final initialSymbols = [
        "+",
        "-",
        "*",
        "/",
    ];

    private static final initialPrimops = [
        PrimopV(new PlusPrimop()),
        PrimopV(new MinusPrimop()),
        PrimopV(new MultiplyPrimop()),
        PrimopV(new DividePrimop()),
    ];

    public static function getEnvironment():Environment {
        return Environment.empty().extend(initialSymbols, initialPrimops);
    }
}
