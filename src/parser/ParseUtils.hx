package parser;

import haxe.Exception;

class ParseUtils {
    private static final IS_NUMERIC_REGEXP = ~/^\d+(\.\d+)?$/;
    private static final IS_STRING_REGEXP = ~/^".*"$/;
    private static final IS_ID_REGEXP = ~/^[^"]+$/;
    private static final ILLEGAL_SYMBOLS = [
        "if",
        "proc",
        "declare",
        "in",
    ];

    /**
     * Takes a string and returns true if the string represents a string, false
     * otherwise.
     */
    public static function isString(token:String):Bool {
        return IS_STRING_REGEXP.match(token);
    }

    /**
     * Takes a string and returns true if the string represents a number, false
     * otherwise.
     */
    public static function isNumeric(token:String):Bool {
        return IS_NUMERIC_REGEXP.match(token);
    }

    /**
     * Takes a string and returns true if the string represents a valid id,
     * false otherwise. 
     */
    public static function isId(token:String):Bool {
        return IS_ID_REGEXP.match(token) && !ILLEGAL_SYMBOLS.contains(token);
    }

    /**
     * Takes an array of Sexp. This is to be called from a context in parsing
     * where we expect each to be a valid id. Return the list of ids, or error.
     */
    public static function sexpsToIds(tokens:Array<Sexp>):Array<String> {
        if (!allAreLeafTs(tokens)) {
            throw new Exception('QWJZ: Invalid ids $tokens');
        }

        return tokens.map(leafTToIdString);
    }

    /**
     * Takes an array of Sexp. Return true IFF all of the Sexp are LeafTs.
     */
    private static function allAreLeafTs(tokens:Array<Sexp>):Bool {
        return !tokens.map(x -> x.match(LeafT(_))).contains(false);
    }

    /**
     * Take a Sexp. Attempt to convert it to an IdC. Error on failure.
     */
    private static function leafTToIdString(token:Sexp):String {
        switch token {
            case LeafT(value):
                if (isId(value)) {
                    return value;
                }
            case _:
                // Continue to the failure message
        }

        throw new Exception('QWJZ: Illegal symbol $token');
    }
}
