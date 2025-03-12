package interpreter.impl;

import haxe.Exception;

class PrintlnPrimop implements Primop {
    public function apply(args:Array<Value>):Value {
        switch args {
            case [StringV(string)]:
                Sys.println(string);
            case _:
                throw new Exception('QWJZ: Invalid args for println $args');
        }

        return BoolV(true);
    }

    public function new() {}
}
