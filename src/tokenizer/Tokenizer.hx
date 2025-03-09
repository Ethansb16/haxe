package tokenizer;

import tokenizer.impl.LeafTBuilder;
import tokenizer.impl.TreeTBuilder;
import haxe.Exception;
import haxe.ds.GenericStack;
import parser.Sexp;

class Tokenizer {
    public static final LIST_OPENER = ["[", "{", "("];
    public static final LIST_CLOSER = ["]", "}", ")"];
    public static final TOKEN_DELIMITERS = LIST_OPENER.concat(LIST_CLOSER).concat([" "]);
    public static final STRING_DELIMITERS = ['"'];

    public static final AUTO_CLOSE_TOKEN_BUILDERS:Array<TokenType> = [NUMBER, SYMBOL];

    private final builderStack:GenericStack<TokenBuilder>;
    private var result:Sexp = null;

    public static function tokenize(program:String):Sexp {
        return new Tokenizer()._tokenize(program);
    }

    private function new() {
        this.builderStack = new GenericStack<TokenBuilder>();
    }

    private function _tokenize(program:String):Sexp {
        if (program.length == 0) {
            throw new Exception("QWJZ: cannot tokenize program of length 0");
        }

        ingestFirstChar(program.charAt(0));

        for (i in 1...program.length) {
            ingestChar(program.charAt(i));
        }

        if (!this.builderStack.isEmpty()) {
            final nextToken:TokenBuilder = builderStack.pop();
            if (AUTO_CLOSE_TOKEN_BUILDERS.contains(nextToken.getTokenType())
                && this.builderStack.isEmpty()) {
                this.result = nextToken.build();
            }
        }

        if (this.result == null) {
            throw new Exception('QWJZ: unfinished program $program');
        } else {
            return this.result;
        }
    }

    private function ingestFirstChar(char:String):Void {
        if (LIST_CLOSER.contains(char)) {
            throw new Exception('QWJZ: Invalid first char in program "$char"');
        }

        if (LIST_OPENER.contains(char)) {
            this.builderStack.add(new TreeTBuilder(char));
        } else {
            this.builderStack.add(new LeafTBuilder(char));
        }
    }

    private function ingestChar(char:String):Void {
        if (result != null || this.builderStack.isEmpty()) {
            throw new Exception('QWJZ: "$char" past end of program');
        }

        if (this.isInString()) {
            if (!STRING_DELIMITERS.contains(char)) {
                this.builderStack.first().append(LeafT(char));
                return;
            } else {
                final completedString = this.builderStack.pop().build();
                handleCompletedToken(completedString);
                return;
            }
        } else if (LIST_OPENER.contains(char)) {
            final newListBuilder = new TreeTBuilder(char);
            this.builderStack.add(newListBuilder);
            return;
        } else if (LIST_CLOSER.contains(char)) {
            if (builderStack.first().getClosingChars().contains(char)) {
                final completed = builderStack.pop();
                // Correctly closed list
                handleCompletedToken(completed.build());

                if (completed.getTokenType() != PARENT) {
                    ingestChar(char);
                }

                return;
            } else {
                // Incorrectly closed list
                throw new Exception('QWJZ: Invalid list closer "$char"');
            }
        } else if (char == " ") {
            switch builderStack.first().getTokenType() {
                case PARENT:
                    // ignore, a space in a list is fine
                    return;
                case STRING:
                    // this should be unreachable
                    trace("Unreachable case reached");
                    throw new Exception("QWJZ: Internal error");
                    return;
                case NUMBER:
                    handleCompletedToken(builderStack.pop().build());
                    return;
                case SYMBOL:
                    handleCompletedToken(builderStack.pop().build());
                    return;
            }
        } else {
            switch builderStack.first().getTokenType() {
                case PARENT:
                    // create a new token
                    this.builderStack.add(new LeafTBuilder(char));
                    return;
                case STRING:
                    // this should be unreachable
                    trace("Unreachable case reached");
                    throw new Exception("QWJZ: Internal error");
                    return;
                case NUMBER:
                    this.builderStack.first().append(LeafT(char));
                    return;
                case SYMBOL:
                    this.builderStack.first().append(LeafT(char));
                    return;
            }
        }

        throw new Exception('QWJZ: failed to tokenize $char');
    }

    /**
     * Return true IFF the instance of the tokenizer is currently building a
     * string.
     */
    private function isInString():Bool {
        return !this.builderStack.isEmpty()
            && this.builderStack.first().getTokenType() == STRING;
    }

    private function handleCompletedToken(token:Sexp):Void {
        if (this.builderStack.isEmpty()) {
            this.result = token;
        } else {
            this.builderStack.first().append(token);
        }
    }
}
