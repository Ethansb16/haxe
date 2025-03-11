package interpreter.impl;

import haxe.Exception;

class SeqPrimop implements Primop {
    public function apply(args:Array<Value>):Value {
        if (args.length == 0) {
            throw new Exception('QWJZ: Invalid arguments for seq $args');
        }
        return args[args.length - 1]; 
    }

    public function new() {}
}
