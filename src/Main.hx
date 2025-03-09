import interpreter.Environment;
import interpreter.Interpreter;
import parser.ExprC;

class Main {
  public static function main() {
    Sys.println(Interpreter.topInterp(StringC("foobar")));

    final env = new Environment(["+"], [CloV([], NumC(1), Environment.empty())]);

    Sys.println(env.lookup("-"));
  }
}
