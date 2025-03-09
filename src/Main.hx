import interpreter.Interpreter;

class Main {
  public static function main() {
    Sys.println(Interpreter.topInterp(
      AppC(
        ProcC(["a"], IdC("a")),
        [NumC(2)]
      )
    ));
  }
}
