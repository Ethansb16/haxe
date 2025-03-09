import parser.Sexp;
import factory.EnvironmentFactory;
import haxe.exceptions.NotImplementedException;
import interpreter.Value;
import parser.Parser;
import interpreter.Interpreter;

class Main {
  public static function main() {
    final result = topInterp(
      TreeT([
        TreeT([LeafT("proc"), TreeT([LeafT("a"), LeafT("b")]), TreeT([LeafT("*"), LeafT("a"), LeafT("b")])]),
        LeafT("5"),
        LeafT("3")
      ]));

    Sys.println(result);

    Sys.println(Interpreter.interp(
      AppC(
        ProcC(["a", "b"], AppC(IdC("*"), [IdC("a"), IdC("b")])),
        [NumC(2), NumC(4)]
      ),
      EnvironmentFactory.getEnvironment()
    ));
  }

  public static function topInterp(program:Sexp) {
    final parsed = Parser.parse(program);
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
        case _:
            throw new NotImplementedException("Cannot serialize $value");
    }
}
}
