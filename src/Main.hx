import interpreter.Interpreter;

class Main {
  public static function main() {
    Sys.println(Interpreter.topInterp(
      AppC(
        ProcC(["a", "b"], AppC(IdC("*"), [IdC("a"), IdC("b")])),
        [NumC(2), NumC(4)]
      )
    ));
  }
}
