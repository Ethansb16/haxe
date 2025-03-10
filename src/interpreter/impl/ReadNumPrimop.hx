package interpreter.impl;
import haxe.Exception;

class ReadNumPrimop implements Primop {
    public function apply(args:Array<Value>):Value {
        try {
            Sys.print("> ");
            var input = Sys.stdin().readLine();
        
            var num = Std.parseFloat(input);
        
            if (Math.isNaN(num)) {
                throw new Exception("QWJZ Invalid number");
        }
        
        return NumV(num);

        } catch (e:Exception) {
            throw new Exception("QWJZ Error reading number: " + e.message);
        }
  }
  
  public function new() {}
}