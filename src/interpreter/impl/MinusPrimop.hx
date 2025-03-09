package interpreter.impl;

import haxe.Exception;

class MinusPrimop implements Primop {
    public function apply(args:Array<Value>):Value {
        switch args {
            case [NumV(a), NumV(b)]:
                return NumV(a - b);
            case _:
                throw new Exception('Invalid arguments for - $args');
        }
    }

    public function new() {}
}
