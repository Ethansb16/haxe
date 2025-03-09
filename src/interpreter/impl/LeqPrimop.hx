package interpreter.impl;

import haxe.Exception;

class LeqPrimop implements Primop {
    public function apply(args:Array<Value>):Value {
        switch args {
            case [NumV(a), NumV(b)]:
                return BoolV(a <= b);
            case _:
                throw new Exception('QWJZ: Invalid arguments for <= $args');
        }
    }

    public function new() {}
}
