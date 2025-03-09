import tokenizer.Tokenizer;
import parser.Sexp;
import factory.EnvironmentFactory;
import interpreter.Value;
import parser.Parser;
import interpreter.Interpreter;

class Main {
  public static function main() {
    Sys.println(topInterp("{{proc {a b} {if {<= a b} 1 0}} 1 1}"));

    Sys.println(topInterp('"foobar"'));
    Sys.println(topInterp("*"));
    Sys.println(topInterp("{proc {} 0}"));

    Sys.println(topInterp("{{proc {a b} {* a b}} 5 3}"));

    Sys.println(topInterp("{declare {[a 5] [b 7]} in {* a b}}"));
  }

  public static function topInterp(program:String) {
    final tokenized = Tokenizer.tokenize(program);
    final parsed = Parser.parse(tokenized);
    final env = EnvironmentFactory.getEnvironment();
    final result = Interpreter.interp(parsed, env);
    return serialize(result);
  }

  private static function serialize(value:Value):String {
    switch value {
        case NumV(n):
          return '$n';
        case StringV(string):
          return '"$string"';
        case PrimopV(_):
          return "#<primop>";
        case CloV(_, _, _):
          return "#<procedure>";
        case BoolV(bool):
          return '$bool';
    }
  }
}
