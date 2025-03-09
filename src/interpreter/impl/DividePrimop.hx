package interpreter.impl;

import haxe.Exception;

class DividePrimop implements Primop {
    public function apply(args:Array<Value>):Value {
        switch args {
            case [NumV(a), NumV(b)]:
                if (b == 0) {
                    throw new Exception("QWJZ: Division by zero");
                }

                return NumV(a / b);
            case _:
                throw new Exception('QWJZ: Invalid arguments for / $args');
        }
    }

    public function new() {}
}
