package interpreter.impl;
import haxe.Exception;

class EqualPrimop implements Primop {
    public function apply(args:Array<Value>):Value {
        if (args.length != 2) {
            throw new Exception('QWJZ: Expected 2 arguments for =, got ${args.length}');
        }
        switch args {
            case [CloV(args1, body1, env1), CloV(args2, body2, env2)]:
                return BoolV(false);

            case [NumV(a), NumV(b)]:
                return BoolV(a == b);

            case _:
                throw new Exception('QWJZ: Invalid arguments for - $args');
        }
    }
  
  public function new() {}
}