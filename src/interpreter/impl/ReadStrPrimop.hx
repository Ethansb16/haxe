package interpreter.impl;
import haxe.Exception;

class ReadStrPrimop implements Primop {
    public function apply(args:Array<Value>):Value {
        try {
            Sys.print("> ");
            var input = Sys.stdin().readLine();
        
        return StringV(input);

        } catch (e:Exception) {
            throw new Exception("QWJZ Error reading string: " + e.message);
        }
  }
  
  public function new() {}
}