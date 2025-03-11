package interpreter.impl;

import haxe.Exception;

class JoinPrimop implements Primop {
    public function apply(args:Array<Value>):Value {
        switch args {
            case [StringV(a), StringV(b)]:
                return StringV(a + b);
            case _:
                throw new Exception('QWJZ: Invalid arguments for ++ $args');
        }
    }

    public function new() {}
}
